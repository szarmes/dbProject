class StaticPagesController < ApplicationController

  def home

  	if user_signed_in?
  		redirect_to '/your_decks'
  	end

  end
  
end