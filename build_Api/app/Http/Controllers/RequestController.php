<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Construction_Request;

class RequestController extends Controller
{

    public function index()
    {
        $requests = Construction_Request::with('user')->get();
        return view('admin.dashboard.request', compact('requests'));
    }

    public function edit($id)
    {
        $request = Construction_Request::findOrFail($id);
        return view('admin.requests.edit', compact('request'));
    }



    public function updateStatus(Request $request, $id){
        $validated = $request->validate([
        'status' => 'required|in:approved,declined,pending',
    ]);

    $requestToUpdate = Construction_Request::findOrFail($id);
    $requestToUpdate->status = $validated['status'];
    $requestToUpdate->save();

    return redirect()->route('admin.dashboard')->with('success', 'Request status updated successfully.');
   }
}
