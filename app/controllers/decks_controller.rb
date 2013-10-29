class DecksController < ApplicationController

  def index

    @deck = Deck.new
           

  end
  def recent

  end
  def favorite

  end

  def create

  	if user_signed_in?
            @deck = Deck.new(deck_params)
            if @deck.save

        		@deck.user_id = current_user.user_id
                @deck.course_id = Course.find_by(name: @deck.courseName).course_id 
            	@deck.subject_id = Subject.find_by(name: @deck.subjectName).subject_id
            	@deck.save

                flash[:success] = "Deck created!"
                redirect_to '/your_decks'
                else
                flash[:error] = "Try again :("
                redirect_to root_path
            end
        end


  end



   private
    
    def deck_params
        params.require(:deck).permit(:deckTitle, :courseName, :subjectName)
    end

  
end