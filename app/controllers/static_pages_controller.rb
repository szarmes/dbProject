class StaticPagesController < ApplicationController

  def home
    @thing = Result.new
    @subSearch = Deck.new
    @results = Result.all.paginate(page: params[:page])
    if user_signed_in?
      @userID = current_user.user_id
      @user = current_user
    else @userID = 0
    end
  end


  def about
    if user_signed_in?
      @userID = current_user.user_id
      @user = current_user
    else @userID = 0
    end
  end

  def contact
    if user_signed_in?
      @userID = current_user.user_id
      @user = current_user
    else @userID = 0
    end
  end

  def resources
    if user_signed_in?
      @userID = current_user.user_id
      @user = current_user
    else @userID = 0
    end
  end
  
end