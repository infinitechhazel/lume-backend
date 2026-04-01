<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Chef extends Model
{
    protected $fillable = [
        'name',
        'position',
        'specialty',
        'experience_years',
        'bio',
        'image_url',
        'rating',
    ];
}