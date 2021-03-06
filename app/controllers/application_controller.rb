require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "our_crossfit_workout_tracker_app"
    register Sinatra::Flash
  end

  get "/" do
    redirect_if_logged_in
    erb :welcome
  end

  helpers do

    def logged_in?
      # true if user is logged in, otherwise false
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def authorized_to_edit?(crossfit_workout)
      crossfit_workout.user == current_user
    end

    # use this helper method to protect controller actions where user must be logged in to proceed
    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in to view the page you tried to view."
        redirect '/'
      end
    end

    # use this helper method to avoid showing welcome, login, or signup page to a user that's already logged in
    def redirect_if_logged_in
      if logged_in?
        redirect "/users/#{current_user.id}"
      end
    end

    def redirect_if_blank_content
      if params[:content] == "" || params[:workout_name] == ""
        flash[:errors] = "Something went wrong - you must provide workout information."
        redirect '/crossfit_workouts/new'
      end
    end

  end

end
