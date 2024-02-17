<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Construction_Request extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'description',
        'location',
        'status',
        'land_upi_number',
        'province',
        'district',
        'sector',
        'cell'
    ];

    public function user(): BelongsTo {
        return $this->belongsTo(User::class);
    }
}