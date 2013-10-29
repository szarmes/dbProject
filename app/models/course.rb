class Course < ActiveRecord::Base

	belongs_to :subject

    after_create :do_setID

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:course_id => newID)


    end
 
end