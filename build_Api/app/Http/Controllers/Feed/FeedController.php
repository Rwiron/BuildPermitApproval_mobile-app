<?php

namespace App\Http\Controllers\Feed;
use App\Http\Requests\PostRequest;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Construction_Request;

class FeedController extends Controller
{
    public function store(PostRequest $request) {

        $validated = $request->validated();

        $constructionRequest = auth()->user()->constructionRequests()->create([
            'description' => $request->input('description'),
            'location' => $request->input('location'),
            'status' => 'pending', // You can set a default status or take it from the request
        ]);

        // Return a successful response
        return response()->json([
            'message' => 'Construction request submitted successfully!',
            // 'data' => $constructionRequest
        ], 201);

    }

    public function index() {
        $constructionRequests = Construction_Request::all(); // Fetch all construction requests

        return response()->json([
            'message' => 'Construction requests retrieved successfully!',
            'constructionRequests' => $constructionRequests
        ]);
    }
}



