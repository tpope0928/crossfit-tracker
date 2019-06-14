class CreateCrossfitWorkouts < ActiveRecord::Migration
  def change
    create_table :crossfit_workouts do |t|
      t.string :workout_name
      t.string :content
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
