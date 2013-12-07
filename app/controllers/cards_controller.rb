class CardsController < ApplicationController



  def show
    @card = Card.find(params[:id]) 
     @userID = current_user.user_id
  end

  def edit
    @card = Card.find(params[:id]) 
    @userID = current_user.user_id 
    @deck =  Deck.find_by(deck_id: @card.deck_id)
  end

  def update
  @card = Card.find(params[:id])
  if @card.update_attributes(card_params)


    flash[:success] = "Changes saved"

    redirect_to new_card_path(:deck =>@card.deck_id)         
  
  else
    flash[:error] = "Changes not saved. Try again."
    redirect_to new_card_path(:deck =>@card.deck_id)                       
  end
  
end
  
  def new
    @userID = current_user.user_id 
  	@card = Card.new

  	@deck =  Deck.find(params[:deck])
  	@card.deck_id=@deck.deck_id
    @cards = Card.where(deck_id: @deck.deck_id).paginate(page: params[:page])
    @userID = current_user.user_id

  end
  def index

    @card = Card.new
    @deck =  Deck.find(params[:deck])
    @cards = Card.where(deck_id: @deck.deck_id).paginate(page: params[:page])
    

  end

  def create
	if user_signed_in?
      @card = Card.new(card_params)
      if @card.qtext.to_s.length < 4000 &&  @card.atext.to_s.length < 4000
        if @card.save
            flash[:success] = "Card created!"
            redirect_to new_card_path(:deck =>@card.deck_id)
        else
            flash[:error] = "Please fill in all required fields."
            redirect_to new_card_path(:deck =>@card.deck_id)
        end
      else
        flash[:error] = "Too much formatting"
        redirect_to new_card_path(:deck =>@card.deck_id)
      end
    end
  end




def destroy
    
    @card = Card.find(params[:id])
    @deckID = @card.deck_id
    @card.destroy
   

    flash[:success] = "Card deleted."
    redirect_to new_card_path(:deck =>@deckID)
  
end


   private
    
    def card_params
        params.require(:card).permit(:atext, :qtext, :deck_id)
    end


end