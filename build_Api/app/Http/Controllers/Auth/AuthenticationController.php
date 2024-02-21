<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\RegisterRequest;
use App\Http\Requests\LoginRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;



class AuthenticationController extends Controller
{
    public function register(RegisterRequest $request) {
       $request->validated();

       $userData = [
        'name' => $request->name,
        'username' => $request->username,
        'email' => $request->email,
        'password' => Hash::make($request->password),
       ];

       $user  = User::create($userData);
       $token = $user->createToken('buildapp')->plainTextToken;

       return response([
        'user' => $user,
        'token' => $token
       ],201);
    }

    public function login(LoginRequest $request) {
        $request->validated();

        $user = User::whereUsername($request->username)->first();
        //dd($user);
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response([
                'message' => 'Invalid Credentials',
            ], 422);
        }
        $token = $user->createToken('buildapp')->plainTextToken;
        return response([
            'user' => $user,
            'token' => $token
           ],200);
    }


    public function updateProfile(Request $request) {
        $user = auth()->user();

        // Validate the request data
        $request->validate([
            'name' => 'sometimes|string|max:255',
            'username' => 'sometimes|string|max:255|unique:users,username,' . $user->id,
            'email' => 'sometimes|email|max:255|unique:users,email,' . $user->id,
            'password' => 'sometimes|min:6',
        ]);

        // Update user information
        if ($request->has('name')) {
            $user->name = $request->name;
        }
        if ($request->has('username')) {
            $user->username = $request->username;
        }
        if ($request->has('email')) {
            $user->email = $request->email;
        }
        if ($request->has('password')) {
            $user->password = Hash::make($request->password);
        }

        $user->save();

        return response()->json([
            'message' => 'Profile updated successfully.',
            'user' => $user
        ], 200);
    }

}