<?php

namespace App\Http\Controllers;

use App\Models\Reservation;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ReservationController extends Controller
{
    public function index()
    {
        $reservations = Reservation::orderBy('date', 'desc')
            ->orderBy('time', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'data' => $reservations,
        ]);
    }

    public function checkDaily(Request $request)
    {
        $user = $request->user('sanctum');

        if (!$user) {
            return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
        }

        $validated = $request->validate([
            'date' => 'required|date',
        ]);

        $count = Reservation::where('user_id', $user->id)
            ->where('date', $validated['date'])
            ->whereIn('reservation_status', ['pending', 'confirmed'])
            ->count();

        return response()->json([
            'success' => true,
            'count' => $count,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'phone' => 'required|string|max:20',
            'date' => 'required|date|after_or_equal:today',
            'time' => 'required|date_format:H:i',
            'guests' => 'required|integer|min:1|max:100',
            'package' => 'nullable|string|max:255',
            'occasion' => 'nullable|string|max:255',
            'dining_preference' => 'nullable|string|max:255',
            'special_requests' => 'nullable|string|max:1000',
            'down_payment' => 'nullable|numeric|min:0',
            'payment_method' => 'nullable|string',
            'payment_reference' => 'nullable|string|max:255',
            'payment_receipt' => 'required|image|mimes:jpg,jpeg,png|max:5120',
        ]);

        if ($request->hasFile('payment_receipt')) {
            $file = $request->file('payment_receipt');
            $path = $file->store('receipts', 'public');
            $validated['payment_receipt'] = 'storage/' . $path;
        }

        $packagePrices = [
            "Skyline Social" => 5500,
            "Golden Hour" => 4000,
            "Neon Nights" => 8500,
            "Midnight Luxe" => 6500,
        ];

        $reservationFee = $packagePrices[$validated['package']] ?? 0;
        $downPayment = $validated['down_payment'] ?? 0;

        $serviceCharge = $reservationFee * 0.10;
        $remaining = max($reservationFee - $downPayment, 0);
        $finalTotal = $remaining + $serviceCharge;

        $validated['reservation_fee'] = $reservationFee;
        $validated['service_charge'] = $serviceCharge;
        $validated['remaining_balance'] = $remaining;
        $validated['total_fee'] = $finalTotal;

        $validated['reservation_status'] = 'pending';
        $validated['is_walkin'] = false;

        // reservation number
        $today = now()->format('Ymd');

        $last = Reservation::whereDate('created_at', now()->toDateString())
            ->orderByDesc('id')
            ->first();

        $next = 1;

        if ($last && $last->reservation_number) {
            $next = ((int) substr($last->reservation_number, -4)) + 1;
        }

        $validated['reservation_number'] =
            'RES-' . $today . '-' . str_pad($next, 4, '0', STR_PAD_LEFT);

        $reservation = Reservation::create($validated);

        return response()->json([
            'success' => true,
            'data' => $reservation,
        ], 201);
    }

    public function update(Request $request, Reservation $reservation)
    {
        $user = $request->user();

        $isAdmin = $user && (
            ($user->is_admin ?? false) ||
            ($user->role ?? null) === 'admin'
        );

        if (!$isAdmin && $reservation->user_id !== $user?->id) {
            return response()->json(['success' => false, 'message' => 'Unauthorized'], 403);
        }

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'email' => 'sometimes|email|max:255',
            'phone' => 'sometimes|string|max:20',
            'date' => 'sometimes|date|after_or_equal:today',
            'time' => 'sometimes|date_format:H:i',
            'guests' => 'sometimes|integer|min:1|max:100',
            'package' => 'nullable|string|max:255',
            'occasion' => 'nullable|string|max:255',
            'dining_preference' => 'nullable|string|max:255',
            'special_requests' => 'nullable|string|max:1000',
            'reservation_status' => 'sometimes|in:pending,confirmed,completed,cancelled',
            'down_payment' => 'nullable|numeric|min:0',
            'payment_receipt' => 'required|image|mimes:jpg,jpeg,png|max:5120',
        ]);

        if ($request->hasFile('payment_receipt')) {
            $file = $request->file('payment_receipt');
            $path = $file->store('receipts', 'public');
            $validated['payment_receipt'] = 'storage/' . $path;
        }

        $reservationFee = $validated['reservation_fee'] ?? $reservation->reservation_fee;
        $downPayment = $validated['down_payment'] ?? $reservation->down_payment;

        $serviceCharge = $reservationFee * 0.10;
        $remaining = max($reservationFee - $downPayment, 0);
        $finalTotal = $remaining + $serviceCharge;

        $validated['service_charge'] = $serviceCharge;
        $validated['remaining_balance'] = $remaining;
        $validated['total_fee'] = $finalTotal;

        if ($remaining <= 0) {
            $validated['reservation_status'] = 'confirmed';
        }

        $reservation->update($validated);

        return response()->json([
            'success' => true,
            'data' => $reservation,
        ]);
    }

    public function show(Reservation $reservation)
    {
        return response()->json([
            'success' => true,
            'data' => $reservation,
        ]);
    }

    public function destroy(Request $request, $id)
    {
        try {
            $reservation = Reservation::findOrFail($id);

            $user = $request->user('sanctum');

            $isAdmin = $user && (
                ($user->is_admin ?? false) ||
                ($user->role ?? null) === 'admin'
            );

            if (!$isAdmin && $reservation->user_id !== $user?->id) {
                return response()->json(['success' => false, 'message' => 'Unauthorized'], 403);
            }

            $reservation->delete();

            return response()->json([
                'success' => true,
                'message' => 'Deleted successfully',
            ]);
        } catch (ModelNotFoundException $e) {
            return response()->json(['success' => false, 'message' => 'Not found'], 404);
        }
    }
}
