class Rating < ActiveRecord::Base

        belongs_to :user

        after_create :do_setID

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:rating_id => newID)


    end
        
 
end