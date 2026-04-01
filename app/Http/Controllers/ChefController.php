<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Chef;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\File;

class ChefController extends Controller
{
    public function index()
    {
        return Chef::latest()->get();
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string',
            'position' => 'required|string',
            'specialty' => 'required|string',
            'experience_years' => 'required|integer|min:0',
            'bio' => 'required|string',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'rating' => 'nullable|numeric|min:0|max:5',
        ]);

        // Handle image upload to public path
        if ($request->hasFile('image')) {
            // Create directory if it doesn't exist
            $directory = public_path('images/chefs');
            if (!File::exists($directory)) {
                File::makeDirectory($directory, 0755, true);
            }

            $file = $request->file('image');
            $filename = time() . '_' . $file->getClientOriginalName();
            $file->move($directory, $filename);
            $validated['image_url'] = '/images/chefs/' . $filename;
        }

        return Chef::create($validated);
    }

    public function show(Chef $chef)
    {
        return $chef;
    }

    public function update(Request $request, Chef $chef)
    {
        $validated = $request->validate([
            'name' => 'string',
            'position' => 'string',
            'specialty' => 'string',
            'experience_years' => 'integer|min:0',
            'bio' => 'string',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'rating' => 'numeric|min:0|max:5',
        ]);

        // Handle image upload to public path
        if ($request->hasFile('image')) {
            // Delete old image if exists
            if ($chef->image_url && file_exists(public_path($chef->image_url))) {
                unlink(public_path($chef->image_url));
            }

            // Create directory if it doesn't exist
            $directory = public_path('images/chefs');
            if (!File::exists($directory)) {
                File::makeDirectory($directory, 0755, true);
            }

            $file = $request->file('image');
            $filename = time() . '_' . $file->getClientOriginalName();
            $file->move($directory, $filename);
            $validated['image_url'] = '/images/chefs/' . $filename;
        }

        $chef->update($validated);
        return $chef;
    }

    public function destroy(Chef $chef)
    {
        if ($chef->image_url && file_exists(public_path($chef->image_url))) {
            unlink(public_path($chef->image_url));
        }

        $chef->delete();
        return response()->json(['message' => 'Chef deleted']);
    }
}