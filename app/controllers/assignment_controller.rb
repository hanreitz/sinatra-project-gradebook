class AssignmentController < ApplicationController

  get '/courses/:id/assignments' do
    @course = Course.find_by(id: params[:id])
    redirect to "/courses/#{@course.id}"
  end

  get '/courses/:id/assignments/new' do
    @course = Course.find_by(id: params[:id])
    erb :'assignments/new'
  end

  get '/courses/:course_id/assignments/:id' do
    @course = Course.find_by(id: params[:course_id])
    @assignment = Assignment.find_by(id: params[:id])
    erb :'assignments/show'
  end

  get '/courses/:course_id/assignments/:id/edit' do
    @course = Course.find_by(id: params[:course_id])
    @assignment = Assignment.find_by(id: params[:id])
    erb :'assignments/edit'
  end

  post '/courses/:id/assignments' do
    @course = Course.find_by(id: params[:assignment][:course_id])
    if !params[:assignment][:name].empty?
      @assignment = Assignment.create(params[:assignment])
      @assignment.course = @course
      redirect to "/courses/#{@course.id}"
    else
      flash[:message] = "ASSIGNMENT NOT CREATED. Name is required."
      redirect to "/courses/#{@course.id}"
    end
  end

  patch '/courses/:course_id/assignments/:id' do
    @course = Course.find_by(id: params[:course_id])
    @assignment = Assignment.find_by(id: params[:id])
    if @assignment.update(params[:assignment])
      @assignment.update(params[:assignment])
      @course.students.each do |student|
        if !params[:student][:grade].empty?
          student.student_assignments.find_by(assignment_id: @assignment.id).grade.update(params[:student][:grade])
        end
      end
      flash[:message] = "Assignment successfully updated!"
      redirect to "/courses/#{@course.id}"
    else
      flash[:message] = "Assignment must have a name."
      redirect to "/courses/#{@course.id}/assignments/#{@assignment.id}"
    end
  end

  delete '/courses/:course_id/assignments/:id' do
    @course = Course.find_by(id: params[:course_id])
    @assignment = Assignment.find_by(id: params[:id])
    if @course.teacher_id == session[:user_id]
      @assignment.destroy
      flash[:message] = "Assignment successfully removed."
      redirect "/courses/#{@course.id}"
    else
      flash[:message] = "You do not have access to this function."
      redirect '/courses'
    end
  end

end