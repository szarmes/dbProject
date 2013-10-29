class User < ActiveRecord::Base

        has_many  :decks, dependent: :destroy
        has_many  :ratings, dependent: :destroy
        has_many  :cards, dependent: :destroy
        has_many  :recent_decks, dependent: :destroy
        has_many  :favorite_cards, dependent: :destroy
        has_many  :favorite_decks, dependent: :destroy



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 
  validates :username, uniqueness: true

  validates :username, :decksMade,  presence:  true
  validates_inclusion_of  :admin, :in => [true, false]
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: true }

  after_create :do_setID

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:user_id => newID)


    end
end