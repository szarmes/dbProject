class School < ActiveRecord::Base
		
        has_many  :courses
        has_many  :decks
 		after_create :do_setID

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:school_id => newID)


    end
end