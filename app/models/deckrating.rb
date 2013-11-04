class Deckrating < ActiveRecord::Base

        belongs_to :deck

        after_create :do_setID

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:deckrating_id => newID)


    end
        
 
end