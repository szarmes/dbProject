class SearchController < ApplicationController

  def search
  	@subSearch = Deck.new
    @results = Result.all.paginate(page: params[:page])
    @result = Result.new
    @thing = Deck.new
  end

  def index
    @subSearch = Deck.new
    @thing = Result.new
    @results = Result.all.paginate(page: params[:page])
  end

  def show
    @thing = Result.new
    @subSearch = Deck.new
    @results = Result.all.paginate(page: params[:page])
  end

  def sort
    @subSearch = Deck.new
    @results = Result.all.paginate(page: params[:page])
    @result = Result.new
    length = subject_name.to_s.length
    length -= 19
    @value = subject_name.to_s[17,length]
    if(@value == "Rating")
      @results = Result.order(percent: :desc).paginate(page: params[:page])
    elsif(@value == "Date Created")
      @results = Result.order(created_on: :desc).paginate(page: params[:page])
    elsif(@value == "Author A-Z")
      @results = Result.order(username: :desc).paginate(page: params[:page])
    elsif(@value == "Author Z-A")
      @results = Result.order(username: :asc).paginate(page: params[:page])
    end
    @results.each do |r|
        @result = Result.create(:deck_id => (r.deck_id), :username => (r.username), :percent => r.percent, :created_on => r.created_on)
        @id = @result.id
        Result.where(:deck_id => (r.deck_id), :username => (r.username), :percent => r.percent).where.not(:id => @id).delete_all
        @result.save
      end
    redirect_to '/index'
  end

  

  def create
    @subSearch = Deck.new
    Result.delete_all
    @subject = subject_name
    subjectlength = @subject.to_s.length
    length = subjectlength-19
    @subjectString = @subject.to_s[17,length]
    length = course_name.to_s.length
    length -= 18
    @courseString = course_name.to_s[16,length]
    length = course_num.to_s.length
    length -= 17
    @nameString = course_num.to_s[15,length]
    @results = Deck.search(@subjectString, @courseString, @nameString)
    @results.each do |r|
      if Deckrating.where(deck_id: r.deck_id).empty?
        @percent = 0
      else
        @liked = Deckrating.where(deck_id: r.deck_id, liked: true).count 
        @total = Deckrating.where(deck_id: r.deck_id).count 
        @percent = (@liked * 100 / @total) 
      end
      @username = User.find_by(:user_id => r.user_id).username
      @result = Result.create(:deck_id => (r.deck_id), :username => (r.user_id), :percent => @percent, :created_on => r.created_on)
      @result.save
    end
    @results = Result.all.paginate(page: params[:page])
    redirect_to '/index'
  end


  private 

  def subject_name
    params.require(:deck).permit(:subjectName)
  end
  def course_name
    params.require(:deck).permit(:courseName)
  end
  def course_num
    params.require(:deck).permit(:courseNum)
  end
  def value
    params.require(:deck).permit(:value)
  end




end