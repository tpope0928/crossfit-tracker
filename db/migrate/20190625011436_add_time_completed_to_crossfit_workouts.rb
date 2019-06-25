class AddTimeCompletedToCrossfitWorkouts < ActiveRecord::Migration
  def change
    add_column :crossfit_workouts, :time_completed, :string
  end
end
