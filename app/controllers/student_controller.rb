class StudentController < ApplicationController

  get '' do
    erb :'students/index'
  end

  get '/new' do
    erb :'students/new'
  end

  get '/:id' do
    @student = Student.find_by(id: params[:id])
    erb :'students/show'
  end

  get '/:id/edit' do
    @student = Student.find_by(id: params[:id])
    erb :'students/edit'
  end

  post '' do
    student = Student.new(params[:student])
    if student.save
      student.save
      flash[:message] = "Student successfully created!"
      redirect '/students'
    else
      flash[:message] = "Could not create new student. Name is required."
      redirect '/students'
    end
  end

end