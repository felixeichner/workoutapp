class ExercisesController < ApplicationController
	before_action :authenticate_user!, except: [:index]
	before_action :set_exercise, except: [:index, :new, :create]

	def index
		@friendships = User.find(params[:user_id]).friendships
		@exercises = User.find(params[:user_id]).exercises.where("workout_date >= ?", Date.today-7)
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
	end

	def edit
	end

	def update
		if @exercise.update(exercise_params)
			flash[:notice] = "Workout has been updated"
			redirect_to [current_user, @exercise]
		else
			render :edit
		end
	end

	def destroy
		if @exercise.destroy
			flash[:notice] = "Workout has been deleted"
			redirect_to user_exercises_path(current_user)
		end
	end

	private

		def set_exercise
			@exercise = current_user.exercises.find(params[:id])
		end

		def exercise_params
			params.require(:exercise).permit(:duration_in_min, :workout, :workout_date)
		end
end