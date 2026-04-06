<?php

namespace App\Http\Controllers;

use App\Models\BlogPost;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class BlogPostController extends Controller
{
    /**
     * Store a new blog post with direct file uploads
     */
    public function store(Request $request)
    {
        try {
            Log::info('Blog post store request received', [
                'has_image_file' => $request->hasFile('image'),
            ]);

            $validated = $request->validate([
                'title' => 'required|string',
                'excerpt' => 'required|string',
                'content' => 'required|string',
                'author' => 'required|string',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:20480',
            ]);

            if ($request->hasFile('image')) {
                $file = $request->file('image');
                $filename = time().'_'.$file->getClientOriginalName();
                $file->move(public_path('images/blog'), $filename);

                $validated['image_url'] = '/images/blog/'.$filename;

                Log::info('Image uploaded', [
                    'path' => $validated['image_url'],
                ]);
            }

            Log::info('Creating blog post with data', $validated);

            $blogPost = BlogPost::create($validated);

            return response()->json($blogPost, 201);

        } catch (ValidationException $e) {
            Log::error('Validation error', ['errors' => $e->errors()]);

            return response()->json([
                'error' => 'Validation failed',
                'errors' => $e->errors(),
            ], 422);

        } catch (\Exception $e) {
            Log::error('Blog post creation error: '.$e->getMessage(), [
                'trace' => $e->getTraceAsString(),
            ]);

            return response()->json([
                'error' => 'Failed to create blog post',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Get all blog posts
     */
    public function index()
    {
        return BlogPost::latest()->get();
    }

    /**
     * Show single blog post
     */
    public function show(BlogPost $blogPost)
    {
        return $blogPost;
    }

    /**
     * Update existing blog post
     */
    public function update(Request $request, BlogPost $blogPost)
    {
        try {
            $validated = $request->validate([
                'title' => 'string',
                'excerpt' => 'string',
                'content' => 'string',
                'author' => 'string',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:20480',
            ]);

            if ($request->hasFile('image')) {
                // delete old image if exists
                if ($blogPost->image_url && file_exists(public_path($blogPost->image_url))) {
                    unlink(public_path($blogPost->image_url));
                }

                $file = $request->file('image');
                $filename = time().'_'.$file->getClientOriginalName();
                $file->move(public_path('images/blog'), $filename);

                $validated['image_url'] = '/images/blog/'.$filename;
            }

            $blogPost->update($validated);

            return response()->json($blogPost);

        } catch (\Exception $e) {
            Log::error('Blog post update error: '.$e->getMessage());

            return response()->json([
                'error' => 'Failed to update blog post',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Delete blog post
     */
    public function destroy(BlogPost $blogPost)
    {
        // Delete image if exists
        if ($blogPost->image_url && file_exists(public_path($blogPost->image_url))) {
            unlink(public_path($blogPost->image_url));
        }

        // Delete DB record
        $blogPost->delete();

        return response()->json(['message' => 'Blog post deleted successfully']);
    }
}
