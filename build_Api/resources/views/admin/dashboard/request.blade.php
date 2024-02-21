@extends('admin.layouts.app')

@section('content')
    <div class="container mt-5">
        <h2>Construction Requests</h2>
        @if (session('success'))
            <div class="alert alert-success">
                {{ session('success') }}
            </div>
        @endif
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Description</th>
                        <th>Location</th>
                        <th>Land_UPI</th>
                        <th>Province</th>
                        <th>Discrit</th>
                        <th>Sector</th>
                        <th>Cell</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($requests as $request)
                        <tr>

                            <td>{{ $request->description }}</td>
                            <td>{{ $request->location }}</td>
                            <td>{{ $request->land_upi_number }}</td>
                            <td>{{ $request->province }}</td>
                            <td>{{ $request->district }}</td>
                            <td>{{ $request->sector }}</td>
                            <td>{{ $request->cell }}</td>
                            <td>{{ $request->status }}</td>

                            <td>
                                <form action="{{ route('requests.updateStatus', $request->id) }}" method="POST"
                                    style="display: inline;">
                                    @csrf
                                    <input type="hidden" name="status" value="approved">
                                    <button type="submit" class="btn btn-success btn-sm">Approve</button>
                                </form>
                                <form action="{{ route('requests.updateStatus', $request->id) }}" method="POST"
                                    style="display: inline;">
                                    @csrf
                                    <input type="hidden" name="status" value="declined">
                                    <button type="submit" class="btn btn-danger btn-sm">Decline</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
@endsection
