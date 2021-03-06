class CourseController < ApplicationController

  get '/courses' do
    erb :'courses/index'
  end

  post '/courses' do
    @course = Course.create(params[:course])
    @course.teacher = Teacher.find_by(id: session[:user_id])
    if !params[:student][:name].empty?
      @course.students << Student.create(params[:student])
    end
    @course.save
    redirect to "/courses/#{@course.id}"
  end

  get '/courses/new' do
    erb :'courses/new'
  end

  get '/courses/:id' do
    @course = Course.find_by(id: params[:id])
    erb :'courses/show'
  end
  
end