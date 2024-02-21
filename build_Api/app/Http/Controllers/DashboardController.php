<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use App\Models\User;

class DashboardController extends Controller
{
    public function index(){
        $totalUsers = User::count();
        $totalRequests = \App\Models\Construction_Request::count();
        $pendingRequests = \App\Models\Construction_Request::where('status', 'pending')->count();
        $approvedRequests =\App\Models\Construction_Request::where('status', 'approved')->count();
        $declinedRequests = \App\Models\Construction_Request::where('status', 'declined')->count();
        $users = $this->getAllUsers();
        return view('admin.dashboard.list', compact('totalUsers','totalRequests','pendingRequests','approvedRequests','declinedRequests','users'));
        //return view('admin.dashboard.list');
    }



    public function getAllUsers() {
        $users1 = User::all(); // Fetches all users from the database
        return $users1;
    }
}
