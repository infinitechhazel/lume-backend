<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('reservations', function (Blueprint $table) {
            $table->decimal('reservation_fee', 10, 2)->default(2000.00)->after('special_requests');
            $table->boolean('reservation_fee_paid')->default(false)->after('reservation_fee');
            $table->string('payment_method')->nullable()->after('reservation_fee_paid'); // gcash or security_bank
            $table->string('payment_reference')->nullable()->after('payment_method'); // reference number or transaction ID
            $table->string('payment_screenshot')->nullable()->after('payment_reference'); // path to payment screenshot
        });
    }

    public function down(): void
    {
        Schema::table('reservations', function (Blueprint $table) {
            $table->dropColumn([
                'reservation_fee', 
                'reservation_fee_paid', 
                'payment_method', 
                'payment_reference',
                'payment_screenshot'
            ]);
        });
    }
};