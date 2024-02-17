<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PostRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        return [
            'description' => 'required|min:10|max:1000',
            'location' => 'required|string|max:255',
            'land_upi_number' => 'required|string|max:255', // Assuming UPI number is required and has a string format
            'province' => 'required|string|max:255',
            'district' => 'required|string|max:255',
            'sector' => 'required|string|max:255',
            'cell' => 'required|string|max:255',
        ];
    }
}