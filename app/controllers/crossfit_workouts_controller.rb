class CrossfitWorkoutsController < ApplicationController

  get '/crossfit_workouts' do
    @crossfit_workouts = CrossfitWorkout.all
    erb :'crossfit_workouts/index'
  end

  # get journal_entries/new to render a form to create new entry
  get '/crossfit_workouts/new' do
    redirect_if_not_logged_in
    erb :'/crossfit_workouts/new'
  end

  # post crossfit_workouts to create a new workout
  post '/crossfit_workouts' do
    #binding.pry
    redirect_if_not_logged_in
    # I want to create a new workout and save it to the DB
    # I also only want to create a workout if a user is logged in
    # I only want to save the workout if it has some content
    if params[:content] != ""
      # create a new workout
      @crossfit_workouts = CrossfitWorkout.create(content: params[:content], user_id: current_user.id, workout_name: params[:workout_name])
      flash[:message] = "Crossfit workout successfully tracked. Great work!" if @crossfit_workouts.id
      redirect "/crossfit_workouts/#{@crossfit_workout.id}"
    else
      flash[:errors] = "Something went wrong - you must provide workout information."
      redirect '/crossfit_workouts/new'
    end
  end

  # show route for a workout
  get '/crossfit_workouts/:id' do
    set_crossfit_workout
    erb :'/crossfit_workouts/show'
  end

  get '/crossfit_workouts/:id/edit' do
    redirect_if_not_logged_in
    set_crossfit_workout
    if authorized_to_edit?(@crossfit_workout)
      erb :'/crossfit_workouts/edit'
    else
      redirect "users/#{current_user.id}"
    end
  end


  patch '/crossfit_workouts/:id' do
    redirect_if_not_logged_in
    # 1. find the workout
    set_crossfit_workout
    if @crossfit_workout.user == current_user && params[:content] != ""
    # 2. modify (update) the workout entry
      @crossfit_workout.update(content: params[:content])
      # 3. redirect to show page
      redirect "/crossfit_workouts/#{@crossfit_workout.id}"
    else
      redirect "users/#{current_user.id}"
    end
  end

  delete '/crossfit_workouts/:id' do
    set_crossfit_workout
    if authorized_to_edit?(@crossfit_workout)
      @crossfit_workout.destroy
      flash[:message] = "Successfully deleted workout."
      redirect '/crossfit_workouts'
    else
      redirect '/crossfit_workouts'
    end
  end
  # index route for all workouts

  private

  def set_crossfit_workout
    @crossfit_workout = CrossfitWorkout.find(params[:id])
  end
end
