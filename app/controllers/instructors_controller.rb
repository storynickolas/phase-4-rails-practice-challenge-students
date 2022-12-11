class InstructorsController < ApplicationController

  def index
    instructors = Instructor.all
    render json: instructors
  end

  def show
    instructor = Instructor.find_by(id: params[:id])
    if instructor
      render json: instructor
    else
      render json: { error: "Instructor not found" }, status: :not_found
    end
  end

  def create
  instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    instructor = Instructor.find_by(id: params[:id])
    if instructor
      instructor.update(instructor_params)
      render json: instructor
    else
      render json: { error: "Instructor not found" }, status: :not_found
    end
  end

  private

  def instructor_params
    params.permit(:name)
  end

end
