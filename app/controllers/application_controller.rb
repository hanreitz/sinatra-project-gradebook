require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    register Sinatra::ActiveRecordExtension
    set :public_folder, 'public'
    set :views, 'app/views/'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:user_id] != nil
      @teacher = Teacher.find_by(id: session[:user_id])
      redirect to '/courses'
    else
      erb :signup
    end
  end

  post '/signup' do
    teacher = Teacher.new(params)
    if teacher.save
      teacher.save
      flash[:message] = "Signup succesful! Please login to continue."
      redirect to '/login'
    else
      flash[:message] = "Signup failed. All fields are required."
      redirect to '/signup'
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    teacher = Teacher.find_by(email: params[:email])
    if teacher && teacher.authenticate(params[:password])
      session[:user_id] = teacher.id
      redirect to '/courses'
    else
      flash[:message] = "Login failed. Enter email and password to log in."
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    flash[:message] = "You have successfully logged out."
    redirect "/"
  end

  get '/:id' do
    redirect to '/'
  end

  get '/:id/edit' do
    @teacher = Teacher.find_by(id: params[:id])
    if @teacher
      if AuthenticationHelper.current_user(session).id != @teacher.id
        flash[:message] = "You are not authorized to make changes to another teacher's account."
        redirect '/'
      else
        erb :edit
      end
    else
      flash[:message] = "No such teacher."
      redirect '/'
    end
  end

  patch '/:id' do
    @teacher = Teacher.find_by(id: params[:id])
    if @teacher.update(params[:teacher])
      @teacher.update(params[:teacher])
      flash[:message] = "Account succesfully updated!"
      redirect to '/'
    else
      flash[:message] = "EDIT FAILED: All fields are required and email address must be valid."
      redirect to '/'
    end
  end

  delete '/:id' do
    @teacher = Teacher.find_by(id: params[:id])
    if @teacher.id == session[:user_id]
      @teacher.destroy
      session.clear
      flash[:message] = "Account successfully removed."
      redirect '/'
    else
      flash[:message] = "You do not have access to this function."
      redirect '/'
    end
  end

end