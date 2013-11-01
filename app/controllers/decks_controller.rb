class DecksController < ApplicationController

  def index

    @deck = Deck.new
    @decks = Deck.where(user_id: current_user.user_id).paginate(page: params[:page])
    @cards = Card.where(deck_id: @deck.deck_id).paginate(page: params[:page])
           

  end

  def show

    @deck =  Deck.find(params[:id])
    @cards = Card.where(deck_id: @deck.deck_id).paginate(page: params[:page])
    @userID = current_user.user_id

  end
  def your_decks

    @deck = Deck.new
    @decks = Deck.where(user_id: current_user.user_id).paginate(page: params[:page])
    @cards = Card.where(deck_id: @deck.deck_id).paginate(page: params[:page])
           

  end
  def recent

  end
  def favorite

  @favorite = FavoriteDeck.new
  @favorites = FavoriteDeck.where(user_id: current_user.user_id).paginate(page: params[:page])

  end
  def addfavorite

    @deck = Deck.find(params[:favid])
    @user = User.find(params[:userID])
    if !FavoriteDeck.find_by(user_id: @user.user_id, deck_id: @deck.deck_id).nil?
      flash[:error] = "Deck already in favorites."
      redirect_to deck_path(@deck.deck_id)

    else
  
      @favorite = FavoriteDeck.create(user_id: @user.user_id,deck_id: @deck.deck_id,card_id:0)
      @favorite.save
      flash[:success] = "Deck added to favorites."
      redirect_to '/favorite_decks'
    end
  end

  def destroyfavorite

    @deck = FavoriteDeck.find_by(params[:id])
    @deck.destroy
    flash[:success] = "Deck removed from favorites."
    redirect_to '/favorite_decks'
  end

  def edit
    @deck = Deck.find(params[:id])  
  end

  def update
    @deck = Deck.find(params[:id])
    if @deck.update_attributes(deck_params)

      @course = Course.find_by(course_id: @deck.course_id)
      if @course.name != @deck.courseName
        if !Course.find_by(name: @deck.courseName, subject_id: @deck.subject_id, course_id: @deck.course_id).nil?
          @newCourse = Course.find_by(name: @deck.courseName, subject_id: @deck.subject_id, course_id: @deck.course_id)
          @deck.course_id = @newCourse.course_id
          @deck.save
        else 
          @newCourse = Course.create(subject_id: @deck.subject_id, 
                        course_id:0, courseNum: @deck.courseNum, name: @deck.courseName)
          @deck.course_id = @newCourse.course_id
          @deck.save
          @newCourse.save
        end

          
      end
      flash[:success] = "Changes saved"

      redirect_to '/your_decks'         
    
    else
      flash[:error] = "Changes not saved. Try again."
      redirect_to new_card_path(:deck =>@card.deck_id)                       
    end
  end


  def create

  	if user_signed_in?
      @deck = Deck.new(deck_params)
      if @deck.save

        @deck.user_id = current_user.user_id

        sid = Subject.find_by(name: @deck.subjectName).subject_id 
        @deck.subject_id = sid


        if @deck.courseName.nil?

          if !Course.find_by(courseNum: @deck.courseNum, subject_id: sid).nil?
            cid = Course.find_by(courseNum: @deck.courseNum,
            subject_id: sid).course_id 
            @deck.course_id = cid
          end
        else
          if !Course.find_by(courseNum: @deck.courseNum, subject_id: sid, 
            name: @deck.courseName).nil?
            cid = Course.find_by(courseNum: @deck.courseNum,
            subject_id: sid, name: @deck.courseName).course_id 
            @deck.course_id = cid
          end


        end
        
         if cid.nil?

            @newCourse = Course.create(subject_id: sid, 
                        course_id:0, courseNum: @deck.courseNum, name: @deck.courseName)
            @newCourse.save

            @deck.course_id = @newCourse.course_id
          end
          @deck.save

          flash[:success] = "Deck created!"
          redirect_to '/your_decks'
      else
          flash[:error] = "Please fill in all required fields."
          redirect_to '/decks'
      end
    
    end
  end

  def destroy
    
    @deck = Deck.find_by(params[:id])
    @deck.destroy
    flash[:success] = "Deck deleted."
    redirect_to '/your_decks'
  end



   private
    
    def deck_params
        params.require(:deck).permit(:deckTitle, :courseNum, :courseName, :subjectName)
    end

  
end