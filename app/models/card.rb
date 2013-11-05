class Card < ActiveRecord::Base

	

		belongs_to :deck
		belongs_to :recent_deck
		belongs_to :saved_deck
		
		

		has_one  :deck
		validates :atext, :qtext, presence: true
		validates_length_of :atext, :qtext, :maximum => 255
 
        
 	after_create :do_setID

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:card_id => newID)
	end
end