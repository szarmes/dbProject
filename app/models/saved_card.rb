class SavedCard < ActiveRecord::Base

        has_one :card
        belongs_to :user
        
        after_create :do_setID

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:fav_id => newID)


    end
 
end