class SearchController < ApplicationController

  def search
  	@subSearch = Deck.new
    @results = Result.all.paginate(page: params[:page])
    @result = Result.new
  end

  def index
    @subSearch = Deck.new
    @results = Result.all.paginate(page: params[:page])
    @result = Result.new
  end

  def show
    @subSearch = Deck.new
    @results = Result.all.paginate(page: params[:page])
    @result = Result.new
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
      @result = Result.create(:deck_id => (r.deck_id))
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




end