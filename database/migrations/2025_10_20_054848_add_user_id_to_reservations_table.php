<?php
// STEP 1: Create this migration with:
// php artisan make:migration add_user_id_to_reservations_table
//
// STEP 2: Copy this code into the generated migration file
//
// STEP 3: Run the migration:
// php artisan migrate

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('reservations', function (Blueprint $table) {
            // Add user_id column (nullable for guest reservations)
            $table->foreignId('user_id')->nullable()->after('id')->constrained('users')->onDelete('cascade');
            
            // Add index for faster queries
            $table->index('user_id');
            $table->index(['user_id', 'date']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('reservations', function (Blueprint $table) {
            // Drop indexes first
            $table->dropIndex(['user_id', 'date']);
            $table->dropIndex(['user_id']);
            
            // Drop foreign key constraint
            $table->dropForeign(['user_id']);
            
            // Drop column
            $table->dropColumn('user_id');
        });
    }
};