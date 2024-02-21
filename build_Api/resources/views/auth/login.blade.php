@extends('layouts.app')

@section('content')
    {{-- section login start --}}
    <div class="card mb-3">
        <div class="card-body">
            <div class="pt-4 pb-2">
                @include('_message')
                <h5 class="card-title text-center pb-0 fs-4">Login to Your Account</h5>
                <p class="text-center small">Enter your Email & password to login</p>
            </div>
            <form class="row g-3 needs-validation" novalidate method="post" action="{{ route('admin.login') }}">
                {{-- //<form class="row g-3 needs-validation" novalidate method="post" action="{{ route('admin.login') }}"> --}}
                {{ csrf_field() }}
                <div class="col-12">
                    <label for="yourUsername" class="form-label">Username</label>
                    <div class="input-group has-validation">
                        {{-- <span class="input-group-text" id="inputGroupPrepend">@</span> --}}
                        <input type="text" name="name" class="form-control" id="yourUsername"
                            value="{{ old('name') }}" required>
                        <div class="invalid-feedback">Please enter your Credintials.</div>
                    </div>
                </div>
                <div class="col-12">
                    <label for="yourPassword" class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" id="yourPassword" required>
                    <div class="invalid-feedback">Please enter your Credintials</div>
                </div>
                <div class="col-12">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="remember" value="true" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">Remember me</label>
                    </div>
                </div>
                <div class="col-12">
                    <button class="btn btn-primary w-100" type="submit">Login</button>
                </div>
                <div class="col-12">
                </div>
            </form>
        </div>
    </div>
    {{-- section login end --}}
@endsection
