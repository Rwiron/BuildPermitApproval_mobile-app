<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\Admin\AdminController;
use App\Http\Controllers\RequestController;


/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::get('/',[AuthController::class,'login']);
Route::post('login_post',[AuthController::class,'login_post']);

//Register routes
Route::get('register',[AuthController::class,'register']);
Route::post('register_post',[AuthController::class,'register_post']);
Route::get('forgot',[AuthController::class,'forgot']);
Route::get('logout',[AuthController::class,'logout']);

//Admin rout

// Web Routes
Route::post('/admin/login', [AdminController::class, 'login'])->name('admin.login');
Route::get('/admin/dashboard', [AdminController::class, 'dashboard'])->name('admin.dashboard');
Route::get('/admin/dashboard', [DashboardController::class, 'index'])->name('admin.dashboard')->middleware('auth:admin');
//Route::get('/admin/users', [DashboardController::class, 'showUsers'])->name('admin.users');

Route::get('admin/request/',[RequestController::class,'index']);


//Staff Routes
Route::group(['middleware' => 'staff'], function () {
    Route::get('staff/dashboard',[DashboardController::class,'index']);
});



Route::post('/requests/update-status/{id}', [RequestController::class, 'updateStatus'])->name('requests.updateStatus');


Route::middleware(['auth:admin'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/request', [RequestController::class, 'index'])->name('dashboard');
    Route::get('/requests/edit/{id}', [RequestController::class, 'edit'])->name('requests.edit');
    //Route::patch('/requests/{id}/status', [RequestController::class, 'updateStatus'])->name('requests.updateStatus');
   // Route::post('/requests/update-status/{id}', [RequestController::class, 'updateStatus'])->name('requests.updateStatus');

});



Route::get('/dashboard', [DashboardController::class, 'index']);