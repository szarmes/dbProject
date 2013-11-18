class DecksController < ApplicationController

  def index

    @deck = Deck.new
    @decks = Deck.where(user_id: current_user.user_id).paginate(page: params[:page])
    @cards = Card.where(deck_id: @deck.deck_id).paginate(page: params[:page])
    if user_signed_in?
      @userID = current_user.user_id
      @user = current_user
      @school_name = @user.school_name
    end

  end
  def thier_decks
    @deck = Deck.new
    @user = User.find_by(:username => params[:username])
    @decks = Deck.where(user_id: @user.user_id).paginate(page: params[:page])
    if user_signed_in?
      @userID = current_user.user_id
      @school_name = @user.school_name
    end
    @cards = Card.where(deck_id: @deck.deck_id).paginate(page: params[:page])

  end
  def show
    if params[:count].nil?
    else
      @count= params[:count].to_i
    end
      @rating = Deckrating.new
      @deck =  Deck.find(params[:id])
    
      @cards = Card.where(deck_id: @deck.deck_id)
      @owner = User.find_by(user_id: @deck.user_id)
      @username = @owner.username
      if user_signed_in?
        @userID = current_user.user_id
        @recents = RecentDeck.where(user_id: current_user.user_id)
        #code to add deck to recent deck
        @check = RecentDeck.find_by(user_id: current_user.user_id,
              deck_id: @deck.deck_id)

        if  @check.nil?
          if  RecentDeck.count('deck_id', :distinct => true) <= 4            
          @recent = RecentDeck.create(user_id: current_user.user_id, 
          deck_id: @deck.deck_id, last_used: DateTime.now, card_id: 0)
          @recent.save
        else
          @earliest = RecentDeck.order(last_used: :asc).first
          @earliest.destroy
          @recent = RecentDeck.create(user_id: current_user.user_id, 
            deck_id: @deck.deck_id, last_used: DateTime.now, card_id: 0)
          @recent.save
          end
        else
          @check.last_used = DateTime.now
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
    @user = current_user
    @userID = @user.user_id

    if user_signed_in?
      if current_user.sign_in_count == 1
        if session[:display_welcome].nil?
          flash.now[:notice] = "Welcome, " + current_user.username + "!"
          session[:display_welcome] = true
        end
      else 
        if session[:display_welcome].nil?
          flash.now[:notice] = "Welcome back, " + current_user.username + "!"
          session[:display_welcome] = true
        end
      end 
    end
           

  end
  def recent
    @recent = RecentDeck.new
    @recents = RecentDeck.where(user_id: current_user.user_id).order(last_used: :desc).order(last_used: :desc).paginate(page: params[:page])
    @deck = Deck.new
  end

  def unrate

    @oldrating = Deckrating.find_by(deck_id: params[:deckID], user_id: params[:userID])
    if !@oldrating.nil?
      @oldrating.destroy
      flash[:success] = "Rating removed"
    end
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
    @count = params[:count].to_i
    if !SavedDeck.find_by(user_id: @user.user_id, deck_id: @deck.deck_id).nil?
      redirect_to deck_path(@deck.deck_id, :count => @count)
    else  
      @favorite = SavedDeck.create(user_id: @user.user_id, deck_id: @deck.deck_id, 
                                      card_id:0, fav_id:0)
      @favorite.save
      redirect_to '/saved_decks'
    end
  end

  def removefavorite
    @deck = Deck.find(params[:favid])
    @userID = current_user.user_id
    if params[:count].nil?
      @favorite = SavedDeck.find_by(user_id: @userID, deck_id: @deck.deck_id)
      if @favorite.nil?
      else
        @favorite.destroy
        flash[:success] = "Deck un-saved."
      end
      redirect_to '/saved_decks'
    else
      @count = params[:count].to_i
      @favorite = SavedDeck.find_by(user_id: @userID, deck_id: @deck.deck_id)
      if @favorite.nil?
      else
        @favorite.destroy
        flash[:success] = "Deck un-saved."
      end
      redirect_to deck_path(@deck.deck_id, :count => @count)
    end
  end

  def edit
    @deck = Deck.find(params[:id])  
  end

  def update
    @deck = Deck.find(params[:id])
    if @deck.update_attributes(deck_params)

      if !@deck.course_name.blank? #set up course info
          @check = Course.find_by(name: @deck.course_name)
          if @check.nil?    #create a new course
            @newCourse = Course.create(subject_id: 0, 
                        course_id:0, course_num: @deck.course_num, name: @deck.course_name)
            @newCourse.save

            @deck.course_id = @newCourse.course_id
          else #match the course id
            @deck.course_id = @check.course_id
          end
        end

        if !@deck.subject_name.blank? #set up subject info
          @check = Subject.find_by(name: @deck.subject_name)
          if @check.nil? #create a new subject
            @newSubject = Subject.create(subject_id: 0, name: @deck.subject_name)
            @newSubject.save

            @deck.subject_id = @newSubject.subject_id
          else  #match the subject id
            @deck.subject_id = @check.subject_id
          end

        end

        if !@deck.school_name.blank? #set up school info
          @check = School.find_by(name: @deck.school_name)
          if @check.nil? #create a new school
            @newSchool = School.create(school_id: 0, name: @deck.school_name)
            @newSchool.save
          else 
            @deck.school_id = @check.school_id
          end
        else
          @deck.school_name = "~N/A~"
        end
      @deck.save

          
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

        
        if !@deck.course_name.blank? #set up course info
          @check = Course.find_by(name: @deck.course_name)
          if @check.nil?    #create a new course
            @newCourse = Course.create(subject_id: 0, 
                        course_id:0, course_num: @deck.course_num, name: @deck.course_name)
            @newCourse.save

            @deck.course_id = @newCourse.course_id
          else #match the course id
            @deck.course_id = @check.course_id
          end
        end

        if !@deck.subject_name.blank? #set up subject info
          @check = Subject.find_by(name: @deck.subject_name)
          if @check.nil? #create a new subject
            @newSubject = Subject.create(subject_id: 0, name: @deck.subject_name)
            @newSubject.save

            @deck.subject_id = @newSubject.subject_id
          else  #match the subject id
            @deck.subject_id = @check.subject_id
          end

        end

        if !@deck.school_name.blank? #set up school info
          @check = School.find_by(name: @deck.school_name)
          if @check.nil? #create a new school
            @newSchool = School.create(school_id: 0, name: @deck.school_name)
            @newSchool.save
          else 
            @deck.school_id = @check.school_id
          end
        else
          @deck.school_name = "~N/A~"
        end


        @deck.created_on = DateTime.now
        @deck.save
        @user = current_user
        @user.decks_made +=1
        @user.save

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

  def flag

    if FlaggedDeck.find_by(:user_id => params[:userID], :deck_id => params[:deckID], :card_id => params[:cardID]).nil?
    @flag = FlaggedDeck.create(:user_id => params[:userID], :deck_id => params[:deckID], :card_id => params[:cardID])
    end

    flash[:success] = "Deck flagged. Thank you."
    redirect_to deck_path(params[:deckID], :count => params[:count])

  end



   private
    
    def deck_params
        params.require(:deck).permit(:deck_title, :course_num, :course_name, :subject_name, :school_name, :prof_name)
    end

  
end