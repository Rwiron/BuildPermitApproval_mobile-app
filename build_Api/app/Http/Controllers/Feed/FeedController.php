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
            'status' => 'pending',
            'land_upi_number' => $validated['land_upi_number'],
            'province' => $validated['province'],
            'district' => $validated['district'],
            'sector' => $validated['sector'],
            'cell' => $validated['cell'],
        ]);

        // Return a successful response
        return response()->json([
            'message' => 'Construction request submitted successfully!',
            // 'data' => $constructionRequest
        ], 201);

    }

    // public function index() {
    //     $constructionRequests = Construction_Request::all(); // Fetch all construction requests

    //     return response()->json([
    //         'message' => 'Construction requests retrieved successfully!',
    //         'constructionRequests' => $constructionRequests
    //     ]);

    // }

    public function index() {

        $constructionRequests = Construction_Request::with('user')->get();


        $constructionRequestsTransformed = $constructionRequests->map(function ($request) {
            return [
                //'id' => $request->id,
                //'user_id' => $request->user_id,
                'username' => $request->user ? $request->user->username : null,
                'description' => $request->description,
                'location' => $request->location,
                'status' => $request->status,
                'created_at' => $request->created_at,
                'updated_at' => $request->updated_at,
                // Include any other fields you need
            ];
        });

        return response()->json([
            'message' => 'Construction requests retrieved successfully!',
            'constructionRequests' => $constructionRequestsTransformed
        ]);
    }
}