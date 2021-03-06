require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    register Sinatra::ActiveRecordExtension
    set :public_folder, 'public'
    set :views, 'app/views'
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
    if params[:email] == "" || params[:password] == "" || params[:first_name] == "" || params[:last_name] == ""
      flash[:message] = "Signup failed. All fields are required."
      redirect to '/signup'
    else
      teacher = Teacher.create(params)
      flash[:message] = "Signup succesful! Please login to continue."
      redirect to '/login'
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

  # get '/account' do
  #   @teacher = Teacher.find_by(id: session[:user_id])
  #   erb :account
  # end

  get '/logout' do
    session.clear
    redirect "/"
  end

end