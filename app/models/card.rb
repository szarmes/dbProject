class Card < ActiveRecord::Base

		belongs_to :deck
		belongs_to :recent_deck
		belongs_to :favorite_deck


		 has_one  :deck, dependent: :destroy
 
        
 
end