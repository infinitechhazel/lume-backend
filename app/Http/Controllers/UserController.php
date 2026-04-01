<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Get all users with optional filtering
     */
    public function index(Request $request)
{
    $query = User::query();

    // Filter by status (default to active)
    $status = $request->get('status', 'active');
    $query->where('status', $status);

    // Filter by role
    if ($request->has('role')) {
        $query->where('role', $request->role);
    }

    // Search by name or email
    if ($request->has('search') && $request->search) {
        $search = $request->search;
        $query->where(function ($q) use ($search) {
            $q->where('name', 'like', "%{$search}%")
              ->orWhere('email', 'like', "%{$search}%");
        });
    }

    // Pagination
    $perPage = $request->get('per_page', 50);
    $users = $query->orderBy('created_at', 'desc')->paginate($perPage);

    return response()->json([
        'success' => true,
        'data' => $users->items(),
        'meta' => [
            'current_page' => $users->currentPage(),
            'last_page' => $users->lastPage(),
            'per_page' => $users->perPage(),
            'total' => $users->total(),
        ],
    ]);
}

public function update(Request $request, $id)
{
    $user = User::findOrFail($id);

    $validated = $request->validate([
        'role' => 'sometimes|in:customer,admin',
        'status' => 'sometimes|in:active,deactivated', // Add this line
        'name' => 'sometimes|string|max:255',
        'email' => 'sometimes|email|unique:users,email,' . $id,
    ]);

    $user->update($validated);

    return response()->json([
        'success' => true,
        'message' => 'User updated successfully',
        'data' => $user,
    ]);
}

    /**
     * Get a single user by ID
     */
    public function show($id)
    {
        $user = User::findOrFail($id);

        return response()->json([
            'success' => true,
            'data' => $user,
        ]);
    }

    /**
     * Update user role or status
     */
    
    /**
     * Delete a user
     */
    public function destroy($id)
    {
        $user = User::findOrFail($id);
        $user->delete();

        return response()->json([
            'success' => true,
            'message' => 'User deleted successfully',
        ]);
    }
}
