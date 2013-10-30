class RecentDeck < ActiveRecord::Base

        belongs_to :user
        belongs_to :deck

       has_one :card, dependent: :destroy

 
end