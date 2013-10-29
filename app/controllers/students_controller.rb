class StudentsController < ApplicationController

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to students_path, alert: 'New student successfully registered!'
    else
      render action: "new"
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    @student.update_attributes student_params
    redirect_to student_path, alert: 'Student information updated!'
  end

  def show
    @student = Student.find(params[:id])
  end

  def student_params
     params.require(:student).permit(:first_name, :last_name, :email, :group_id, :picture, :twitter)
  end

end
