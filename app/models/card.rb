class Card < ActiveRecord::Base

	

		belongs_to :deck
		belongs_to :recent_deck
		belongs_to :saved_deck
		
		has_many :cardratings, dependent: :destroy

		has_one  :deck
		validates :atext, :qtext, presence: true
 
        
 	after_create :do_setID

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:card_id => newID)
	end
end