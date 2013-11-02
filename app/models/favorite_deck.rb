class FavoriteDeck < ActiveRecord::Base

        belongs_to :user
        has_one :deck

        has_one :card
        after_create :do_setID

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:fav_id => newID)


    end

 
end