class Cardrating < ActiveRecord::Base

        belongs_to :card

        after_create :do_setID

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:cardrating_id => newID)


    end
        
 
end