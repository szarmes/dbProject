class CardsController < ApplicationController

  def favorite

  end
  
  def new

  	@card = Card.new
  	@deck =  Deck.find(params[:deck])
  	@card.deck_id=@deck.deck_id

  end
  def index

    @card = Card.new
    @deck =  Deck.find(params[:deck])
    @cards = Card.where(deck_id: @deck.deck_id).paginate(page: params[:page])
    

  end

  def create
	if user_signed_in?
      @card = Card.new(card_params)
      if @card.save
          flash[:success] = "Card created!"
          redirect_to root_path
      else
          flash[:error] = "Please fill in all required fields."
          redirect_to root_path
      end
    
    end

  end




def destroy
    
    @card = Card.find_by(params[:id])
    @card.destroy
    flash[:success] = "Card deleted."
  end



   private
    
    def card_params
        params.require(:card).permit(:atext, :qtext, :deck_id)
    end


end