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
        'table_number',
        'special_requests',
        'status',
        'is_walkin',
        'reservation_fee',
        'reservation_fee_paid',
        'payment_method',
        'payment_reference',
        'payment_screenshot',
    ];

    protected $casts = [
        'date' => 'date',
        'guests' => 'integer',
        'table_number' => 'integer',
        'is_walkin' => 'boolean',
        'reservation_fee' => 'decimal:2',
        'reservation_fee_paid' => 'boolean',
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
        if (!$this->payment_screenshot) {
            return null;
        }
        
        return url($this->payment_screenshot);
    }

    /**
     * Check if payment screenshot exists
     */
    public function hasPaymentScreenshot(): bool
    {
        return !empty($this->payment_screenshot) && file_exists(public_path($this->payment_screenshot));
    }

    /**
     * Scope a query to only include upcoming reservations.
     */
    public function scopeUpcoming($query)
    {
        return $query->where('date', '>=', now()->toDateString())
                     ->whereIn('status', ['pending', 'confirmed'])
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
              ->orWhere('status', 'completed')
              ->orWhere('status', 'cancelled');
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
        return $query->where('reservation_fee_paid', true);
    }

    /**
     * Scope for unpaid reservations
     */
    public function scopeUnpaid($query)
    {
        return $query->where('reservation_fee_paid', false)
                     ->where('is_walkin', false);
    }

    /**
     * Scope for reservations with payment screenshots
     */
    public function scopeWithPaymentProof($query)
    {
        return $query->whereNotNull('payment_screenshot');
    }

    /**
     * Scope for reservations without payment screenshots
     */
    public function scopeWithoutPaymentProof($query)
    {
        return $query->whereNull('payment_screenshot')
                     ->where('is_walkin', false);
    }
    
    /**
     * Check if a table is available for a specific date and time
     * Only pending and confirmed reservations occupy tables
     * Completed and cancelled reservations free up the table
     */
    public static function isTableAvailable($tableNumber, $date, $time, $excludeReservationId = null)
    {
        $query = static::where('table_number', $tableNumber)
            ->where('date', $date)
            ->where('time', $time)
            ->whereIn('status', ['pending', 'confirmed']); // Only these statuses occupy tables
            
        if ($excludeReservationId) {
            $query->where('id', '!=', $excludeReservationId);
        }
        
        return $query->count() === 0;
    }
}