<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthenticationController;
use App\Http\Controllers\Feed\FeedController;
use App\Http\Controllers\Admin\AdminController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::get('/test', function () {
    return response([
        'message' => 'Api is working!',
    ],200);
});

//user
Route::post('register', [AuthenticationController::class, 'register']);
Route::post('login', [AuthenticationController::class, 'login']);
Route::middleware('auth:sanctum')->put('/user/update-profile', [AuthenticationController::class, 'updateProfile']);


//Admin
Route::post('/admin/register', [AdminController::class, 'register']);
//Route::post('/admin/login', [AdminController::class, 'login']);
//Route::post('/admin/login', [AdminController::class, 'login'])->name('admin.login');

//Route::post('/admin/login', [AdminController::class, 'login'])->middleware('auth:sanctum')->name('admin.login');;

Route::get('/user/construction-requests', [FeedController::class, 'userRequests'])->middleware('auth:sanctum');


//request
Route::post('/feed/store',[FeedController::class,'store'])->middleware('auth:sanctum');
Route::get('/construction-requests', [FeedController::class, 'index'])->middleware('auth:sanctum');
Route::get('/construction-requests/{construction_request}', [FeedController::class, 'show'])->middleware('auth:sanctum');
