class DecksController < ApplicationController

  def index

    @deck = Deck.new
    @decks = Deck.where(user_id: current_user.user_id).paginate(page: params[:page])
           

  end
  def your_decks

    @deck = Deck.new
    @decks = Deck.where(user_id: current_user.user_id).paginate(page: params[:page])
           

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

        sid = Subject.find_by(name: @deck.subjectName).subject_id 
        @deck.subject_id = sid


        if !Course.find_by(courseNum: @deck.courseNum, subject_id: sid).nil?
            cid = Course.find_by(courseNum: @deck.courseNum, 
            subject_id: sid).course_id 
            @deck.course_id = cid
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