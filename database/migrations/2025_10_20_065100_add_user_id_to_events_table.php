<?php

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
        Schema::table('events', function (Blueprint $table) {
            // Add the user_id foreign key column
            $table->foreignId('user_id')
                  ->after('id')  // Specify where to place the column in the table
                  ->constrained('users')  // Reference the 'users' table
                  ->onDelete('cascade');  // Delete events when user is deleted
        });
    }

    /**
     * Rollback the migrations.
     */
    public function down(): void
    {
        Schema::table('events', function (Blueprint $table) {
            // Remove the foreign key relationship
            $table->dropForeignIdFor('user_id');
        });
    }
};
