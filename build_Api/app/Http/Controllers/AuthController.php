<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login()
    {
       return view ('auth.login');
    }

    //User Registration View
    public function register(Request $request) {
        // echo "Testing registration page ";
        return view ('auth.register');
    }

    public function forgot (Request $request ){
        return view ('auth.forgot');
    }

    public function register_post(Request $request) {
        // echo "Testing registration page ";
        //return view ('auth.register');
        // to make remember token
        //dd($request->all());
        $user = request ()->validate([
            'name' =>'required',
            'email' =>'required|unique:users',
            'password' => 'required|min:6',
        ]);


        $user = new User;
        $user->name            = trim ($request->name);
        $user->last_name       = trim ($request->last_name);
        $user->email           = trim ($request->email);
        $user->password        = Hash::make($request->password);
        $user->remember_token  = Str::random(50);
        $user->save();

        return redirect('/')->with('success','Register successfully.');
    }


    public function login_post (Request $request) {
        //dd($request->all());
        if(Auth::attempt(['email' => $request->email, 'password' => $request->password],true)){
            if (Auth::User()->is_role == '1'){
                return redirect()->intended ('admin/dashboard');
            }else if (Auth::User()->is_role == '0'){
                return redirect()->intended ('staff/dashboard');
            }else {
                return redirect()->back()->with('error','Please Enter the correct credentials');
            }
        }else {
            return redirect()->back()->with('error','Please Enter the correct credentials');
        }
    }

    public function logout() {
        Auth::logout();
        return redirect(url('/'));
    }
}