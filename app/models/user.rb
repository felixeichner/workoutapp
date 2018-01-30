class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :exercises
  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User"

  validates_presence_of :name
  self.per_page = 10

  default_scope { order(created_at: :desc) }

  def self.search_by_name(name)
  	if name
	  	names_array = name.split(" ")

	  	if names_array.size == 1
	  		where("name LIKE ?", "%#{names_array[0]}%")
	  	else
	  		where("name LIKE ? or name LIKE ?", "%#{names_array[0]}%", "%#{names_array[1]}%")
	  	end
  	else
  		all
	  end
  end

  def follows_or_same?(new_friend)
    self == new_friend || friendships.map(&:friend).include?(new_friend)
  end

end
