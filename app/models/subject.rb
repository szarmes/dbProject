class Subject < ActiveRecord::Base
		
        has_many  :courses, dependent: :destroy
 		after_create :do_setID

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:subject_id => newID)


    end
end