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

return new class extends Migration {
    public function up(): void
    {
        Schema::table('reservations', function (Blueprint $table) {
            $table->foreignId('user_id')
                ->nullable()
                ->after('id')
                ->constrained('users')
                ->cascadeOnDelete();

            $table->index('user_id', 'reservations_user_id_index');
            $table->index(['user_id', 'date'], 'reservations_user_date_index');
        });
    }

    public function down(): void
    {
        Schema::table('reservations', function (Blueprint $table) {
            $table->dropIndex('reservations_user_date_index');
            $table->dropIndex('reservations_user_id_index');

            $table->dropForeign(['user_id']);
            $table->dropColumn('user_id');
        });
    }

};