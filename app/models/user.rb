class User < ActiveRecord::Base

        has_many  :decks, dependent: :destroy
        has_many  :deckratings, dependent: :destroy
        has_many  :recent_decks, dependent: :destroy
        has_many  :saved_decks, dependent: :destroy
        has_many :flagged_decks, dependent: :destroy



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 
  validates :username, uniqueness: true

  validates :username, :decks_made,  presence:  true
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

    def self.find_for_database_authentication(conditions={})
      self.where("username = ?", conditions[:email]).limit(1).first ||
      self.where("email = ?", conditions[:email]).limit(1).first
    end
end