<?php

namespace App\Http\Controllers;

use App\Models\BlogPost;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class BlogPostController extends Controller
{
    /**
     * Store a new blog post with direct file uploads
     */
    public function store(Request $request)
    {
        try {
            Log::info('Blog post store request received', [
                'has_video_file' => $request->hasFile('video'),
                'has_thumbnail_file' => $request->hasFile('thumbnail'),
            ]);

            $validated = $request->validate([
                'title' => 'required|string',
                'excerpt' => 'required|string',
                'content' => 'required|string',
                'author' => 'required|string',
                'video' => 'nullable|mimes:mp4,webm,ogg|max:102400',
                'thumbnail' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:20480',
            ]);

            if ($request->hasFile('video')) {
                $file = $request->file('video');
                $filename = time() . '_' . $file->getClientOriginalName();
                $file->move(public_path('videos/blog'), $filename);
                $validated['video_url'] = '/videos/blog/' . $filename;
                Log::info('Video uploaded', ['path' => $validated['video_url']]);
            }

            if ($request->hasFile('thumbnail')) {
                $file = $request->file('thumbnail');
                $filename = time() . '_thumbnail_' . $file->getClientOriginalName();
                $file->move(public_path('images/thumbnails'), $filename);
                $validated['thumbnail_url'] = '/images/thumbnails/' . $filename;
                Log::info('Thumbnail uploaded', ['path' => $validated['thumbnail_url']]);
            }

            Log::info('Creating blog post with data', $validated);

            $blogPost = BlogPost::create($validated);

            return response()->json($blogPost, 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            Log::error('Validation error', ['errors' => $e->errors()]);
            return response()->json([
                'error' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('Blog post creation error: ' . $e->getMessage(), [
                'trace' => $e->getTraceAsString()
            ]);
            return response()->json([
                'error' => 'Failed to create blog post',
                'message' => $e->getMessage()
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
                'video' => 'nullable|mimes:mp4,webm,ogg|max:102400',
                'thumbnail' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:20480',
            ]);

            if ($request->hasFile('video')) {
                if ($blogPost->video_url && file_exists(public_path($blogPost->video_url))) {
                    unlink(public_path($blogPost->video_url));
                }

                $file = $request->file('video');
                $filename = time() . '_' . $file->getClientOriginalName();
                $file->move(public_path('videos/blog'), $filename);
                $validated['video_url'] = '/videos/blog/' . $filename;
            }

            if ($request->hasFile('thumbnail')) {
                if ($blogPost->thumbnail_url && file_exists(public_path($blogPost->thumbnail_url))) {
                    unlink(public_path($blogPost->thumbnail_url));
                }

                $file = $request->file('thumbnail');
                $filename = time() . '_thumbnail_' . $file->getClientOriginalName();
                $file->move(public_path('images/thumbnails'), $filename);
                $validated['thumbnail_url'] = '/images/thumbnails/' . $filename;
            }

            $blogPost->update($validated);
            return $blogPost;
        } catch (\Exception $e) {
            Log::error('Blog post update error: ' . $e->getMessage());
            return response()->json([
                'error' => 'Failed to update blog post',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Delete blog post
     */
    public function destroy(BlogPost $blogPost)
    {
        // Delete video if exists
        if ($blogPost->video_url && file_exists(public_path($blogPost->video_url))) {
            unlink(public_path($blogPost->video_url));
        }

        // Delete thumbnail if exists
        if ($blogPost->thumbnail_url && file_exists(public_path($blogPost->thumbnail_url))) {
            unlink(public_path($blogPost->thumbnail_url));
        }

        $blogPost->delete();

        return response()->json(['message' => 'Blog post deleted successfully']);
    }
}
