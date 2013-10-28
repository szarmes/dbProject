class User < ActiveRecord::Base

        has_many  :decks, dependent: :destroy
        has_many  :ratings, dependent: :destroy
        has_many  :cards, dependent: :destroy
        has_many  :recent_decks, dependent: :destroy
        has_many  :favorite_cards, dependent: :destroy
        has_many  :favorite_decks, dependent: :destroy



  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :user_id, presence: true

  validates :username, :fname, :lname, :password, 
                          :password_confirmation, presence:  true
  validates_inclusion_of :employee, :employer, :admin, :in => [true, false]
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: true }
end