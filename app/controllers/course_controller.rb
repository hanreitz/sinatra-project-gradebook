class CourseController < ApplicationController

  get '/courses' do
    erb :'courses/index'
  end

  get '/courses/new' do
    erb :'courses/new'
  end

  get '/courses/:id' do
    @course = Course.find_by(id: params[:id])
    erb :'courses/show'
  end

  get '/courses/:id/edit' do
    @course = Course.find_by(id: params[:id])
    erb :'courses/edit'
  end

  post '/courses' do
    @course = Course.create(params[:course])
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

  patch '/courses/:id' do
    if !params[:course].keys.include?("student_ids")
      params[:course]["student_ids"] = []
    end
    @course = Course.find_by(id: params[:id])
    if @course.update(params[:course])
      @course.update(params[:course])
      if !params[:student][:name].empty?
        student = Student.create(params[:student])
        @course.students << student
      end
      flash[:message] = "Course successfully updated!"
      redirect to "/courses/#{@course.id}"
    else
      flash[:message] = "Course must have a name."
      redirect to "/courses/#{@course.id}"
    end
  end

  delete '/courses/:id' do
    @course = Course.find_by(id: params[:id])
    if @course.teacher_id == session[:user_id]
      @course.destroy
      flash[:message] = "Course successfully removed."
      redirect '/courses'
    else
      flash[:message] = "You do not have access to this function."
      redirect '/courses'
    end
  end
  
end