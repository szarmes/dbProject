class Deck < ActiveRecord::Base

		belongs_to :user
        has_many  :cards, dependent: :destroy
        has_one  :course, dependent: :destroy
 
end