<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Construction_Request extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'description',
        'location',
        'status'
    ];

    public function user():belongsTo {
        return $this->belongsTo(User::class);
    }
}
