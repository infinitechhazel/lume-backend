<?php

namespace App\Http\Controllers;

use App\Models\Reservation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class ReservationController extends Controller
{
    /**
     * Display a listing of reservations.
     */
    public function index(Request $request)
    {
        $user = $request->user('sanctum');
        
        Log::info('=== Reservation Index Called ===', [
            'has_user' => $user !== null,
            'user_id' => $user ? $user->id : null,
            'user_email' => $user ? $user->email : null,
            'is_admin' => $user ? ($user->is_admin ?? false) : false,
        ]);
        
        if ($user) {
            $isAdmin = (isset($user->is_admin) && $user->is_admin) || 
                       (isset($user->role) && $user->role === 'admin');
            
            if ($isAdmin) {
                // Admin sees ALL reservations including walk-ins
                $reservations = Reservation::orderBy('date', 'desc')
                    ->orderBy('time', 'desc')
                    ->get();
                    
                Log::info('✅ Admin fetching all reservations', [
                    'count' => $reservations->count(),
                    'walkins_count' => $reservations->where('is_walkin', true)->count()
                ]);
            } else {
                // Regular users see only their own reservations
                $reservations = Reservation::where('user_id', $user->id)
                    ->orderBy('date', 'desc')
                    ->orderBy('time', 'desc')
                    ->get();
                    
                Log::info('✅ User fetching their reservations', [
                    'count' => $reservations->count()
                ]);
            }

            return response()->json([
                'success' => true,
                'data' => $reservations,
                'debug' => [
                    'is_admin' => $isAdmin,
                    'user_id' => $user->id,
                    'total_count' => $reservations->count(),
                    'authenticated' => true
                ]
            ]);
        }

        Log::info('⚠️ No authenticated user - returning confirmed only');
        
        // Guest users see only confirmed, non-walk-in reservations
        $reservations = Reservation::where('status', 'confirmed')
            ->where('is_walkin', false)
            ->orderBy('date', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'data' => $reservations,
            'debug' => [
                'is_admin' => false,
                'authenticated' => false,
                'count' => $reservations->count()
            ]
        ]);
    }

    /**
     * Check daily booking count for a user
     */
    public function checkDaily(Request $request)
    {
        $user = $request->user('sanctum');
        
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized'
            ], 401);
        }
        
        $validated = $request->validate([
            'date' => 'required|date'
        ]);
        
        $count = Reservation::where('user_id', $user->id)
            ->where('date', $validated['date'])
            ->whereIn('status', ['pending', 'confirmed'])
            ->count();
        
        Log::info('Daily booking check:', [
            'user_id' => $user->id,
            'date' => $validated['date'],
            'count' => $count
        ]);
        
        return response()->json([
            'success' => true,
            'count' => $count,
            'date' => $validated['date']
        ]);
    }

    /**
     * Store a newly created reservation in storage.
     */
    public function store(Request $request)
    {
        Log::info('=== Reservation Store Called ===');
        Log::info('Request Data:', $request->all());

        $user = $request->user('sanctum');
        
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized. Please login to make a reservation.'
            ], 401);
        }
        
        // Check if user is admin
        $isAdmin = (isset($user->is_admin) && $user->is_admin) || 
                   (isset($user->role) && $user->role === 'admin');
        
        Log::info('User Info:', [
            'has_user' => true,
            'is_admin' => $isAdmin,
            'user_id' => $user->id
        ]);

        // For walk-ins, only admins can create them
        $isWalkin = $request->boolean('is_walkin', false);
        
        if ($isWalkin && !$isAdmin) {
            Log::warning('⚠️ Non-admin trying to create walk-in reservation');
            return response()->json([
                'success' => false,
                'error' => 'Unauthorized',
                'message' => 'Only administrators can create walk-in reservations.'
            ], 403);
        }

        // Validation rules
        $rules = [
            'name' => 'required|string|max:255',
            'email' => $isWalkin ? 'nullable|email|max:255' : 'required|email|max:255',
            'phone' => $isWalkin ? 'nullable|string|max:20' : 'required|string|max:20',
            'date' => 'required|date|after_or_equal:today',
            'time' => 'required|date_format:H:i',
            'guests' => 'required|integer|min:1|max:20',
            'table_number' => 'nullable|integer|min:1|max:38',
            'special_requests' => 'nullable|string|max:1000',
            'status' => 'sometimes|in:pending,confirmed,completed,cancelled',
            'is_walkin' => 'sometimes|boolean',
            'reservation_fee' => 'sometimes|numeric|min:0',
            'reservation_fee_paid' => 'sometimes|boolean',
            'payment_method' => 'nullable|string',
            'payment_reference' => 'nullable|string|max:255',
            'payment_receipt' => 'nullable|image|mimes:jpeg,jpg,png,gif|max:5120',
        ];

        $validated = $request->validate($rules);

        Log::info('Validated Data:', $validated);

        // Check daily booking limit (2 per day) for regular users
        if (!$isWalkin) {
            $dailyCount = Reservation::where('user_id', $user->id)
                ->where('date', $validated['date'])
                ->whereIn('status', ['pending', 'confirmed'])
                ->count();
            
            if ($dailyCount >= 2) {
                Log::warning('⚠️ Daily booking limit reached', [
                    'user_id' => $user->id,
                    'date' => $validated['date'],
                    'count' => $dailyCount
                ]);
                
                return response()->json([
                    'success' => false,
                    'error' => 'Daily limit reached',
                    'message' => 'You have reached the maximum of 2 reservations for this date. Please choose a different date.'
                ], 400);
            }
        }

        // Check if table is available (only if table_number is provided)
        if (isset($validated['table_number'])) {
            if (!Reservation::isTableAvailable($validated['table_number'], $validated['date'], $validated['time'])) {
                Log::warning('⚠️ Table not available', [
                    'table_number' => $validated['table_number'],
                    'date' => $validated['date'],
                    'time' => $validated['time']
                ]);
                
                return response()->json([
                    'success' => false,
                    'error' => 'Table not available',
                    'message' => 'Table #' . $validated['table_number'] . ' is already reserved for the selected date and time. Please choose another table.'
                ], 422);
            }
        }

        // Handle payment receipt upload
        if ($request->hasFile('payment_receipt')) {
            $file = $request->file('payment_receipt');
            $filename = time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();
            
            $uploadPath = public_path('uploads/payment_receipts');
            if (!file_exists($uploadPath)) {
                mkdir($uploadPath, 0755, true);
            }
            
            $file->move($uploadPath, $filename);
            $validated['payment_receipt'] = 'uploads/payment_receipts/' . $filename;
            
            Log::info('Payment receipt uploaded:', ['path' => $validated['payment_receipt']]);
        }

        // Add user_id
        $validated['user_id'] = $user->id;
        Log::info('User ID added:', ['user_id' => $user->id]);

        // Set default reservation fee if not provided
        if (!isset($validated['reservation_fee'])) {
            $validated['reservation_fee'] = 2000.00;
        }

        // Set default status
        if (!isset($validated['status'])) {
            if ($isWalkin) {
                $validated['status'] = 'confirmed';
                $validated['reservation_fee_paid'] = true;
            } else {
                $validated['status'] = 'pending';
                if (!isset($validated['reservation_fee_paid'])) {
                    $validated['reservation_fee_paid'] = false;
                }
            }
        }

        $validated['is_walkin'] = $isWalkin;

        Log::info('Final data before create:', $validated);

        $reservation = Reservation::create($validated);

        Log::info('✅ Reservation created:', [
            'id' => $reservation->id,
            'table_number' => $reservation->table_number,
            'is_walkin' => $reservation->is_walkin,
            'status' => $reservation->status,
            'fee_paid' => $reservation->reservation_fee_paid,
            'has_receipt' => !empty($reservation->payment_receipt)
        ]);

        return response()->json([
            'success' => true,
            'data' => $reservation,
            'message' => $isWalkin ? 'Walk-in customer added successfully' : 'Reservation created successfully. Please complete payment to confirm.'
        ], 201);
    }

    /**
     * Update the specified reservation in storage.
     */
    public function update(Request $request, Reservation $reservation)
    {
        $user = $request->user();
        
        $isAdmin = (isset($user->is_admin) && $user->is_admin) || 
                   (isset($user->role) && $user->role === 'admin');
        
        if (!$isAdmin) {
            if (!$reservation->user_id || $reservation->user_id !== $user->id) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthorized to update this reservation'
                ], 403);
            }
        }

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'email' => 'sometimes|email|max:255',
            'phone' => 'sometimes|string|max:20',
            'date' => 'sometimes|date|after_or_equal:today',
            'time' => 'sometimes|date_format:H:i',
            'guests' => 'sometimes|integer|min:1|max:20',
            'table_number' => 'nullable|integer|min:1|max:38',
            'special_requests' => 'nullable|string|max:1000',
            'status' => 'sometimes|in:pending,confirmed,completed,cancelled',
            'is_walkin' => 'sometimes|boolean',
            'reservation_fee_paid' => 'sometimes|boolean',
            'payment_method' => 'nullable|string|in:gcash,security_bank',
            'payment_reference' => 'nullable|string|max:255',
            'payment_receipt' => 'nullable|image|mimes:jpeg,jpg,png,gif|max:5120',
        ]);

        // If table_number, date, or time is being updated, check availability
        if (isset($validated['table_number']) && $validated['table_number']) {
            $tableNumber = $validated['table_number'];
            $date = $validated['date'] ?? $reservation->date->format('Y-m-d');
            $time = $validated['time'] ?? $reservation->time;
            
            if (!Reservation::isTableAvailable($tableNumber, $date, $time, $reservation->id)) {
                Log::warning('⚠️ Table not available for update', [
                    'table_number' => $tableNumber,
                    'date' => $date,
                    'time' => $time,
                    'reservation_id' => $reservation->id
                ]);
                
                return response()->json([
                    'success' => false,
                    'error' => 'Table not available',
                    'message' => 'Table #' . $tableNumber . ' is already reserved for the selected date and time. Please choose another table.'
                ], 422);
            }
        }

        // Handle payment receipt upload
        if ($request->hasFile('payment_receipt')) {
            if ($reservation->payment_receipt) {
                $oldPath = public_path($reservation->payment_receipt);
                if (file_exists($oldPath)) {
                    unlink($oldPath);
                }
            }
            
            $file = $request->file('payment_receipt');
            $filename = time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();
            
            $uploadPath = public_path('uploads/payment_receipts');
            if (!file_exists($uploadPath)) {
                mkdir($uploadPath, 0755, true);
            }
            
            $file->move($uploadPath, $filename);
            $validated['payment_receipt'] = 'uploads/payment_receipts/' . $filename;
            
            Log::info('Payment receipt updated:', ['path' => $validated['payment_receipt']]);
        }

        // Auto-confirm if payment is marked as paid
        if (isset($validated['reservation_fee_paid']) && $validated['reservation_fee_paid'] === true) {
            $validated['status'] = 'confirmed';
        }

        $reservation->update($validated);

        Log::info('✅ Reservation updated:', [
            'id' => $reservation->id,
            'table_number' => $reservation->table_number
        ]);

        return response()->json([
            'success' => true,
            'data' => $reservation,
            'message' => 'Reservation updated successfully'
        ]);
    }

    /**
     * Display the specified reservation.
     */
    public function show(Request $request, Reservation $reservation)
    {
        if ($request->user()) {
            if ($reservation->user_id && $reservation->user_id !== $request->user()->id) {
                $isAdmin = (isset($request->user()->is_admin) && $request->user()->is_admin) || 
                           (isset($request->user()->role) && $request->user()->role === 'admin');
                
                if (!$isAdmin) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Unauthorized to view this reservation'
                    ], 403);
                }
            }
        }

        return response()->json([
            'success' => true,
            'data' => $reservation
        ]);
    }

    /**
     * Remove the specified reservation from storage.
     */
    public function destroy(Request $request, $id)
    {
        try {
            $reservation = Reservation::findOrFail($id);
            
            $user = $request->user('sanctum');
            $isAdmin = false;
            
            if ($user) {
                $isAdmin = (isset($user->is_admin) && $user->is_admin) || 
                           (isset($user->role) && $user->role === 'admin');
            }
            
            if (!$isAdmin && (!$reservation->user_id || $reservation->user_id !== $user->id)) {
                return response()->json([
                    'success' => false,
                    'error' => 'Unauthorized',
                    'message' => 'You are not authorized to delete this reservation.'
                ], 403);
            }
            
            if ($reservation->payment_receipt) {
                $filePath = public_path($reservation->payment_receipt);
                if (file_exists($filePath)) {
                    unlink($filePath);
                }
            }
            
            $reservation->delete();
            
            Log::info('✅ Reservation deleted:', ['id' => $id]);
            
            return response()->json([
                'success' => true,
                'message' => 'Reservation deleted successfully'
            ], 200);
            
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'error' => 'Reservation not found',
                'message' => 'The reservation with ID ' . $id . ' does not exist.'
            ], 404);
            
        } catch (\Exception $e) {
            Log::error('❌ Error deleting reservation:', [
                'id' => $id,
                'error' => $e->getMessage()
            ]);
            
            return response()->json([
                'success' => false,
                'error' => 'Failed to delete reservation',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get user's upcoming reservations.
     */
    public function upcoming(Request $request)
    {
        $reservations = Reservation::where('user_id', $request->user()->id)
            ->upcoming()
            ->get();

        return response()->json([
            'success' => true,
            'data' => $reservations,
            'count' => $reservations->count()
        ]);
    }

    /**
     * Get user's past reservations.
     */
    public function past(Request $request)
    {
        $reservations = Reservation::where('user_id', $request->user()->id)
            ->past()
            ->get();

        return response()->json([
            'success' => true,
            'data' => $reservations,
            'count' => $reservations->count()
        ]);
    }
    
    /**
     * Get occupied tables for a specific date and time.
     */
    public function getOccupiedTables(Request $request)
    {
        try {
            $validated = $request->validate([
                'date' => 'required|date',
                'time' => 'required|date_format:H:i',
            ]);

            Log::info('=== Get Occupied Tables Request ===', [
                'date' => $validated['date'],
                'time' => $validated['time']
            ]);

            $occupiedTables = Reservation::where('date', $validated['date'])
                ->where('time', $validated['time'])
                ->whereIn('status', ['pending', 'confirmed'])
                ->whereNotNull('table_number')
                ->pluck('table_number')
                ->unique()
                ->values()
                ->toArray();

            Log::info('✅ Occupied tables retrieved:', [
                'tables' => $occupiedTables,
                'count' => count($occupiedTables)
            ]);

            return response()->json([
                'success' => true,
                'occupied_tables' => $occupiedTables,
                'date' => $validated['date'],
                'time' => $validated['time'],
                'count' => count($occupiedTables)
            ]);

        } catch (\Exception $e) {
            Log::error('❌ Error getting occupied tables:', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            return response()->json([
                'success' => false,
                'error' => 'Failed to get occupied tables',
                'message' => $e->getMessage()
            ], 500);
        }
    }
}