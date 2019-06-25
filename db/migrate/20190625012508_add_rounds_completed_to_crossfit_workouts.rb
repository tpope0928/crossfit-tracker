class AddRoundsCompletedToCrossfitWorkouts < ActiveRecord::Migration
  def change
    add_column :crossfit_workouts, :rounds_completed, :integer
  end
end
