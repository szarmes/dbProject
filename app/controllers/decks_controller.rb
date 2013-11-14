class DecksController < ApplicationController

  def index

    @deck = Deck.new
    @decks = Deck.where(user_id: current_user.user_id).paginate(page: params[:page])
    @cards = Card.where(deck_id: @deck.deck_id).paginate(page: params[:page])
    if user_signed_in?
      @userID = current_user.user_id
    end

  end

  def show
    if params[:count].nil?
    else
      @count= params[:count].to_i
    end
      @rating = Deckrating.new
      @deck =  Deck.find(params[:id])
    
      @cards = Card.where(deck_id: @deck.deck_id)
  
      if user_signed_in?
        @userID = current_user.user_id
        @recents = RecentDeck.where(user_id: current_user.user_id)
        #code to add deck to recent deck
        @check = RecentDeck.find_by(user_id: current_user.user_id,
              deck_id: @deck.deck_id)

        if  @check.nil?
          if  RecentDeck.count('deck_id', :distinct => true) <= 4            
          @recent = RecentDeck.create(user_id: current_user.user_id, 
          deck_id: @deck.deck_id, lastUsed: DateTime.now, card_id: 0)
          @recent.save
        else
          @earliest = RecentDeck.order(lastUsed: :asc).first
          @earliest.destroy
          @recent = RecentDeck.create(user_id: current_user.user_id, 
            deck_id: @deck.deck_id, lastUsed: DateTime.now, card_id: 0)
          @recent.save
          end
        else
          @check.lastUsed = DateTime.now
          @check.save
        end
      end
      
      #increment uses
      @deck.uses=@deck.uses+1
      @deck.save
  end
  def your_decks

    @deck = Deck.new
    @decks = Deck.where(user_id: current_user.user_id).paginate(page: params[:page])
    @cards = Card.where(deck_id: @deck.deck_id).paginate(page: params[:page])
           

  end
  def recent
    @recent = RecentDeck.new
    @recents = RecentDeck.where(user_id: current_user.user_id).order(lastUsed: :desc).order(lastUsed: :desc).paginate(page: params[:page])
  end

  def unrate

    @oldrating = Deckrating.find_by(deck_id: params[:deckID], user_id: params[:userID])
    @oldrating.destroy
    flash[:success] = "Rating removed"
    redirect_to deck_path(params[:deckID], :count => params[:count])

  end

  def rate
    @rating = Deckrating.new

    if !Deckrating.find_by(deck_id: params[:deckID], user_id: params[:userID]).nil?
      @oldrating = Deckrating.find_by(deck_id: params[:deckID], user_id: params[:userID])
      @oldrating.destroy
    end

    @rating.deck_id= params[:deckID]
    @rating.user_id = params[:userID]
    @rating.deckrating_id = 0
    @rating.liked = params[:liked]
    @rating.created_at = DateTime.now
     
    if @rating.save
      if @rating.liked == true
        flash[:success] = 'Deck liked'
      else
        flash[:error] = 'Deck disliked'
      end
      redirect_to deck_path(@rating.deck_id, :count => params[:count])
    else
      redirect_to deck_path(@rating.deck_id, :count => params[:count])
    end

  end



  def favorite

  @favorite = SavedDeck.new
  @favorites = SavedDeck.where(user_id: current_user.user_id).paginate(page: params[:page])

  end
  def addfavorite

    @deck = Deck.find(params[:favid])
    @user = User.find(params[:userID])
    if !SavedDeck.find_by(user_id: @user.user_id, deck_id: @deck.deck_id).nil?
      flash[:error] = "Deck already saved."
      redirect_to deck_path(@deck.deck_id)

    else
  
      @favorite = SavedDeck.create(user_id: @user.user_id, deck_id: @deck.deck_id, 
                                      card_id:0, fav_id:0)
      @favorite.save
      flash[:success] = "Deck saved."
      redirect_to '/saved_decks'
    end
  end

  def removefavorite
    @deck = Deck.find(params[:favid])
    @userID = current_user.user_id
    @favorite = SavedDeck.find_by(user_id: @userID, deck_id: @deck.deck_id)
    if @favorite.nil?
      flash[:error] = "Cannot find deck in saved decks"
    else
      @favorite.delete
      flash[:success] = "Deck un-saved."
    end
    redirect_to '/saved_decks'
  end

  def edit
    @deck = Deck.find(params[:id])  
  end

  def update
    @deck = Deck.find(params[:id])
    if @deck.update_attributes(deck_params)

      @course = Course.find_by(course_id: @deck.course_id)
      if (!@course.nil? and @course.name != @deck.courseName )
        if !Course.find_by(name: @deck.courseName, subject_id: @deck.subject_id, course_id: @deck.course_id).nil?
          @newCourse = Course.find_by(name: @deck.courseName, subject_id: @deck.subject_id, course_id: @deck.course_id)
          @deck.course_id = @newCourse.course_id
          @deck.courseName = @newCourse.name
          @deck.save
        end
      else 
          @newCourse = Course.create(subject_id: @deck.subject_id, 
                        course_id:0, courseNum: @deck.courseNum, name: @deck.courseName)
          @deck.course_id = @newCourse.course_id
          @deck.courseName = @newCourse.name
          @deck.save
          @newCourse.save
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

        sid = Subject.find_by(name: @deck.subjectname).subject_id 
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
          @deck.created_on = DateTime.now
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
    @deck = Deck.find(params[:id])
    @deck.destroy
    flash[:success] = "Deck deleted."
    redirect_to '/your_decks'
  end



   private
    
    def deck_params
        params.require(:deck).permit(:deckTitle, :courseNum, :courseName, :subjectname)
    end

  
end