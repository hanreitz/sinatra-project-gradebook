class CourseController < ApplicationController

  get '/courses' do
    erb :'courses/index'
  end

  get '/courses/new' do
    erb :'courses/new'
  end

  get '/courses/:id' do
    @course = Course.find_by(id: params[:id])
    if AuthenticationHelper.current_user(session).courses.include?(@course)
      erb :'courses/show'
    else
      flash[:message] = "You may not view courses you do not own."
      redirect '/courses'
    end
  end

  get '/courses/:id/edit' do
    @course = Course.find_by(id: params[:id])
    if AuthenticationHelper.current_user(session).courses.include?(@course)
      erb :'courses/edit'
    else
      flash[:message] = "You may not edit courses you do not own."
      redirect '/courses'
    end
  end

  post '/courses' do
    @course = Course.new(params[:course])
    if @course.save
      @course.teacher = Teacher.find_by(id: session[:user_id])
      student = Student.new(params[:student])
      if student.save
        @course.students << student
        @course.save
        flash[:message] = "Course and new students created successfully!"
        redirect to "/courses/#{@course.id}"
      else
        @course.save
        flash[:message] = "Course created!"
        redirect to "/courses/#{@course.id}"
      end
    else
      flash[:message] = "COURSE NOT CREATED. Name field is required."
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