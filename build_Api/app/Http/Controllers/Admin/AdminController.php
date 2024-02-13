<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\AdminLoginRequest;
use App\Http\Requests\AdminRegisterRequest;
use App\Models\Admin;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AdminController extends Controller
{
    public function register(AdminRegisterRequest $request) {

        $adminData = [
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ];

        $admin = Admin::create($adminData);
        $token = $admin->createToken('adminToken')->plainTextToken;

        return response([
            'admin' => $admin,
            'token' => $token
        ], 201);
    }

      // Admin login
      public function login(AdminLoginRequest $request) {
        $request->validated();

        $admin = Admin::where('name', $request->name)->first();

        if (!$admin || !Hash::check($request->password, $admin->password)) {
            return response([
                'message' => 'Invalid Credentials',
            ], 422);
        }
        $token = $admin->createToken('adminToken')->plainTextToken;
        return response([
            'admin' => $admin,
            'token' => $token
        ], 200);
    }
}
