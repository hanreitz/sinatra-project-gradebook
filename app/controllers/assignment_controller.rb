class AssignmentController < ApplicationController

  get '/assignment/new' do
    erb :'assignments/new'
  end

  get '/assignment/:id' do
    @assignment = Assignment.find_by(params[:id])
    erb :'assignments/show'
  end

  get '/assignments/:id/edit' do
    @assignment = Assignment.find_by(params[:id])
    erb :'assignments/edit'
  end

  post '/assignments' do
    @assignment = Assignment.create(params[:course])
    @course.teacher = Teacher.find_by(id: session[:user_id])
    student = Student.new(params[:student])
    if student.save
      @course.students << student
      @course.save
      redirect to "/courses/#{@course.id}"
    else
      flash[:message] = "New student(s) could not be saved. Name field is required."
      redirect to '/courses/new'
    end
  end

end