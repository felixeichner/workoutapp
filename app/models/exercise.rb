class Exercise < ApplicationRecord
  belongs_to :user

  validates_presence_of :duration_in_min, :workout, :workout_date
end
