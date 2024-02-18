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

    public function index() {

        $constructionRequests = Construction_Request::with('user')->get();


        $constructionRequestsTransformed = $constructionRequests->map(function ($request) {
            return [
                //'id' => $request->id,
                //'user_id' => $request->user_id,
                'username' => $request->user ? $request->user->username : null,
                'description' => $request->description,
                'location' => $request->location,
                'land_upi_number' => $request->land_upi_number,
                'province' =>  $request->province,
                'district' =>  $request->district,
                'sector' => $request->sector,
                'cell' =>   $request->cell,
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


    
    public function show($id) {
        $construction_request = Construction_Request::with('user')->find($id);

        if (!$construction_request) {
            return response()->json([
                'message' => 'Construction request not found',
            ], 404);
        }

        $requestTransformed = [
            'id' => $construction_request->id,
            'user_id' => $construction_request->user_id,
            'username' => optional($construction_request->user)->username,
            'description' => $construction_request->description,
            'location' => $construction_request->location,
            'status' => $construction_request->status,
            'created_at' => optional($construction_request->created_at)->toDateTimeString(),
            'updated_at' => optional($construction_request->updated_at)->toDateTimeString(),
        ];

        return response()->json([
            'message' => 'Construction request retrieved successfully!',
            'constructionRequest' => $requestTransformed
        ]);
    }
}