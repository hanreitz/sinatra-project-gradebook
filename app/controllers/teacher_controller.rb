class TeacherController < ApplicationController

  get '/teachers/:id/edit' do
    erb :'teachers/edit'
  end

  patch '/teachers/:id' do

  end

  delete '/teachers/:id' do
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    session.clear
    redirect to '/'
  end

end