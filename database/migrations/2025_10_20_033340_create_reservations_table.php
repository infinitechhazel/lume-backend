<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('reservations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained('users')->onDelete('cascade');
            $table->string('reservation_number')->unique();
            $table->string('name');
            $table->string('email');
            $table->string('phone');
            $table->date('date');
            $table->time('time');
            $table->integer('guests');
            $table->string('package')->nullable();
            $table->string('occasion')->nullable();
            $table->string('dining_preference')->nullable();
            $table->text('special_requests')->nullable();

            // Reservation fee & payment
            $table->decimal('reservation_fee', 10, 2)->default(2000.00);
            $table->decimal('reservation_fee_paid', 10, 2)->default(0.00);
            $table->string('payment_method')->nullable(); // gcash, security_bank, etc.
            $table->string('payment_reference')->nullable(); // reference number or transaction ID
            $table->string('payment_receipt')->nullable();
            $table->enum('payment_status', ['pending', 'paid', 'failed'])->default('pending');

            // Reservation status
            $table->enum('reservation_status', ['pending', 'confirmed', 'cancelled', 'completed', 'noshow'])->default('pending');

            // Walk-in flag
            $table->boolean('is_walkin')->default(false);

            $table->timestamps();

            // Indexes for faster queries
            $table->index('user_id');
            $table->index(['user_id', 'date']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reservations');
    }
};
