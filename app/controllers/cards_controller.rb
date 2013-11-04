class CardsController < ApplicationController



  def show
    @card = Card.find(params[:id]) 
     @userID = current_user.user_id
  end

  def edit
    @card = Card.find(params[:id])  
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
      if @card.save
          flash[:success] = "Card created!"
          redirect_to new_card_path(:deck =>@card.deck_id)
      else
          flash[:error] = "Please fill in all required fields."
          redirect_to new_card_path(:deck =>@card.deck_id)
      end
    
    end

  end




def destroy
    
    @card = Card.find_by(params[:id])
    @deckID = @card.deck_id
    @card.destroy
    flash[:success] = "Card deleted."
    redirect_to new_card_path(:deck =>@deckID)
end

def favorite

  @favorite = SavedCard.new
  @favorites = SavedCard.where(user_id: current_user.user_id).paginate(page: params[:page])

  end
  def addfavorite

    @card = Card.find(params[:favid])
    @user = User.find(params[:userID])
    if !SavedCard.find_by(user_id: @user.user_id, card_id: @card.card_id).nil?
      flash[:error] = "Card already saved."
      redirect_to card_path(@card.card_id)

    else
  
      @favorite = SavedCard.create(user_id: @user.user_id, card_id: @card.card_id, 
                                     fav_id:0)
      @favorite.save
      flash[:success] = "Card saved."
      redirect_to '/saved_cards'
    end
  end

  def removefavorite
    @card = Card.find(params[:favid])
    @userID = current_user.user_id
    @favorite = SavedCard.find_by(user_id: @userID, card_id: @card.card_id)
    if @favorite.nil?
      flash[:error] = "uh-Oh3"
    else
      @favorite.delete
      flash[:success] = "Card un-saved."
    end
    redirect_to '/saved_cards'
  end

  


   private
    
    def card_params
        params.require(:card).permit(:atext, :qtext, :deck_id)
    end


end