<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Reservation extends Model
{
    protected $fillable = [
        'user_id',
        'name',
        'email',
        'phone',
        'date',
        'time',
        'guests',
        'occasion',
        'dining_preference',
        'special_requests',
        'reservation_fee',
        'reservation_fee_paid',
        'payment_method',
        'payment_reference',
        'payment_receipt',
        'payment_status',       
        'reservation_status',   
        'is_walkin',
    ];

    protected $casts = [
        'date' => 'date',
        'time' => 'string',
        'guests' => 'integer',
        'is_walkin' => 'boolean',
        'reservation_fee' => 'decimal:2',
        'reservation_fee_paid' => 'decimal:2',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    /**
     * Get the user that owns the reservation.
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get the full URL for the payment screenshot
     */
    public function getPaymentScreenshotUrlAttribute(): ?string
    {
        if (!$this->payment_receipt) {
            return null;
        }

        return url($this->payment_receipt);
    }

    /**
     * Check if payment screenshot exists
     */
    public function hasPaymentScreenshot(): bool
    {
        return !empty($this->payment_receipt) && file_exists(public_path($this->payment_receipt));
    }

    /**
     * Scope a query to only include upcoming reservations.
     */
    public function scopeUpcoming($query)
    {
        return $query->where('date', '>=', now()->toDateString())
                     ->whereIn('reservation_status', ['pending', 'confirmed'])
                     ->orderBy('date', 'asc')
                     ->orderBy('time', 'asc');
    }

    /**
     * Scope a query to only include past reservations.
     */
    public function scopePast($query)
    {
        return $query->where(function ($q) {
            $q->where('date', '<', now()->toDateString())
              ->orWhereIn('reservation_status', ['completed', 'cancelled', 'noshow']);
        })->orderBy('date', 'desc')
          ->orderBy('time', 'desc');
    }

    /**
     * Scope a query to only include reservations for a specific user.
     */
    public function scopeForUser($query, $userId)
    {
        return $query->where('user_id', $userId);
    }

    /**
     * Scope for paid reservations only
     */
    public function scopePaid($query)
    {
        return $query->where('payment_status', 'paid');
    }

    /**
     * Scope for unpaid reservations
     */
    public function scopeUnpaid($query)
    {
        return $query->where('payment_status', 'pending')
                     ->where('is_walkin', false);
    }

    /**
     * Scope for reservations with payment screenshots
     */
    public function scopeWithPaymentProof($query)
    {
        return $query->whereNotNull('payment_receipt');
    }

    /**
     * Scope for reservations without payment screenshots
     */
    public function scopeWithoutPaymentProof($query)
    {
        return $query->whereNull('payment_receipt')
                     ->where('is_walkin', false);
    }
}