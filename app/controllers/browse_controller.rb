class BrowseController < ApplicationController

  def index
  	@cnumSearch = Deck.new
  	@cnameSearch = Deck.new
  	@subSearch = Deck.new

  end

  

  def search

  	if !@subSearch.nil?
  		@results = Deck.where('subjectName like ?', @subSearch.subjectName).paginate(page: params[:page])
  		
  	elsif !@cnameSearch.nil?
  		@results = Deck.where('courseName like ?', @cnameSearch.courseName).paginate(page: params[:page])
  		
  	elsif !@cnameSearch.nil?
  		@results = Deck.where('courseNum like ?', @cnumSearch.courseNum).paginate(page: params[:page])
  		
  	end

  	@cnumSearch = Deck.new
  	@cnameSearch = Deck.new
  	@subSearch = Deck.new


  end




end