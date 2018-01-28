class ExercisesController < ApplicationController
	def index
	end

	def new
		@exercise = current_user.exercises.build
	end

	def create
		@exercise = current_user.exercises.build(exercise_params)
		if @exercise.save
			flash[:notice] = "Workout has been created"
			redirect_to [current_user, @exercise]
		else
			render :new
		end
	end

	def show
		@exercise = current_user.exercises.find(params[:id])
	end

	private

		def exercise_params
			params.require(:exercise).permit(:duration_in_min, :workout, :workout_date)
		end
end