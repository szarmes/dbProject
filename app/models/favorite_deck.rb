class FavoriteDeck < ActiveRecord::Base

        belongs_to :user
        belongs_to :deck

        has_one :card, depentent: :destroy
        

 
end