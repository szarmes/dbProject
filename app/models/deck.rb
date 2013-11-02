class Deck < ActiveRecord::Base

		belongs_to :user
    belongs_to :favorite_deck
        has_many  :cards, dependent: :destroy
        has_one  :course 
        has_one  :subject
 	
    validates :deckTitle, :courseNum, :subjectName, presence: true

 	after_create :do_setID

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:deck_id => newID)


    end
end