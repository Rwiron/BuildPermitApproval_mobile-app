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
    //   public function login(AdminLoginRequest $request) {
    //     $request->validated();

    //     $admin = Admin::where('name', $request->name)->first();

    //     if (!$admin || !Hash::check($request->password, $admin->password)) {
    //         return response([
    //             'message' => 'Invalid Credentials',
    //         ], 422);
    //     }
    //     $token = $admin->createToken('adminToken')->plainTextToken;
    //     return response([
    //         'admin' => $admin,
    //         'token' => $token
    //     ], 200);
    // }

    // public function login(Request $request){
    //     $request->validate([
    //         'name' => 'required|string',
    //         'password' => 'required|string',
    //     ]);

    //     $admin = Admin::where('name', $request->name)->first();

    //     if (!$admin || !Hash::check($request->password, $admin->password)) {
    //         throw ValidationException::withMessages([
    //             'name' => ['The provided credentials are incorrect.'],
    //         ]);
    //     }

    //     $token = $admin->createToken('adminToken')->plainTextToken;

    //     return response()->json(['token' => $token]);
    // }


    // public function login(Request $request)
    // {
    //     $credentials = $request->only('name', 'password');

    //     if (Auth::guard('admin')->attempt($credentials)) {
    //         // If login successful, redirect to an admin dashboard route
    //         return redirect()->intended(route('admin.dashboard'));
    //     }

    //     // If login fails, redirect back with input (except password) and an error message
    //     return back()->withInput($request->except('password'))->withErrors([
    //         'error' => 'The provided credentials do not match our records.',
    //     ]);
    // }


    public function dashboard(){
        return view('admin.dashboard.list');
    }

    public function login(Request $request){
    $request->validate([
        'name' => 'required|string',
        'password' => 'required|string',
    ]);

    $admin = Admin::where('name', $request->name)->first();

    if ($admin && Hash::check($request->password, $admin->password)) {
        Auth::guard('admin')->login($admin);

        return redirect()->intended('admin/dashboard')->with('success','Register successfully.');
    } else {
        return redirect()->back()->with('error','Please Enter the correct credentials');
    }
    
 }
}
