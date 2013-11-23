class SearchController < ApplicationController

  autocomplete :course, :name, :full => true
  autocomplete :subject, :name, :full => true
  autocomplete :school, :name, :full => true


  def search
  	@subSearch = Deck.new
    @results = Result.all.paginate(page: params[:page])
    @result = Result.new
    @thing = Deck.new
    @resultcount = @results.size
    if user_signed_in?
      @userID = current_user.user_id
    else @userID = 0
    end
  end

  def index
    @subSearch = Deck.new
    @thing = Result.new
    @results = Result.all.paginate(page: params[:page])
    @userID = current_user.user_id
  end

  def show
    @thing = Result.new
    @subSearch = Deck.new
    @results = Result.all.paginate(page: params[:page])
    if user_signed_in?
      @userID = current_user.user_id
    else @userID = 0
    end
  end

  def sort
   if user_signed_in?
      @userID = current_user.user_id
    else @userID = 0
    end
    @subSearch = Deck.new
    @results = Result.all.paginate(page: params[:page])
    @result = Result.new
    length = subject_name.to_s.length
    length -= 20
    @value = subject_name.to_s[18,length]
    @results = Result.all
    if(@value == "Rating")
      @results = Result.order(percent: :desc).paginate(page: params[:page])
    elsif(@value == "Date Created")
      @results = Result.order(created_on: :desc).paginate(page: params[:page])
    elsif(@value == "Author A-Z")
      @results = Result.order(username: :desc).paginate(page: params[:page])
    elsif(@value == "Author Z-A")
      @results = Result.order(username: :asc).paginate(page: params[:page])
    elsif(@value == "School")
      @results = Result.order(school_name: :asc).paginate(page: params[:page])
    elsif(@value == "Professor")
      @results = Result.order(prof_name: :asc).paginate(page: params[:page])
    end
    @resultcount = @results.size
    @results.each do |r|
        @result = Result.create(:deck_id => (r.deck_id), :username => (r.username), :percent => r.percent, :created_on => r.created_on, 
        :school_name => (r.school_name), :prof_name => r.prof_name)
        @id = @result.id
        Result.where(:deck_id => (r.deck_id), :username => (r.username), :percent => r.percent).where.not(:id => @id).delete_all
        @result.save
      end
    redirect_to '/results'
  end

  

  def create
    @subSearch = Deck.new
    Result.delete_all
    @subject = subject_name
    subjectlength = @subject.to_s.length
    length = subjectlength-20
    @subjectString = @subject.to_s[18,length]
    length = course_name.to_s.length
    length -= 19
    @courseString = course_name.to_s[17,length]
    length = course_num.to_s.length
    length -= 18
    @nameString = course_num.to_s[16,length]
    length = school_name.to_s.length
    length -= 19
    @schoolString = school_name.to_s[17, length]
    length = prof_name.to_s.length
    length -= 17
    @profString = prof_name.to_s[15, length]
    @results = Deck.search(@subjectString, @courseString, @nameString, @schoolString, @profString)
    @resultcount = @results.size
    @results.each do |r|
      if Deckrating.where(deck_id: r.deck_id).empty?
        @percent = -1
      else
        @liked = Deckrating.where(deck_id: r.deck_id, liked: true).count 
        @total = Deckrating.where(deck_id: r.deck_id).count 
        @percent = (@liked * 100 / @total) 
      end
      if r.user_id != -1
        @username = User.find_by(:user_id => r.user_id).username
      end
      @result = Result.create(:deck_id => (r.deck_id), :username => (r.user_id), :percent => @percent, 
        :created_on => r.created_on, :school_name => (r.school_name), :prof_name => r.prof_name)
      @result.save
    end
    @results = Result.all.paginate(page: params[:page])
    if user_signed_in?
      @userID = current_user.user_id
    else @userID = 0
    end
    redirect_to '/results'
  end


  private 

  def subject_name
    params.require(:deck).permit(:subject_name)
  end
  def course_name
    params.require(:deck).permit(:course_name)
  end
  def course_num
    params.require(:deck).permit(:course_num)
  end
  def school_name
    params.require(:deck).permit(:school_name)
  end
  def prof_name
    params.require(:deck).permit(:prof_name)
  end
  def value
    params.require(:deck).permit(:value)
  end




end