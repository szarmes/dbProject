class Deck < ActiveRecord::Base

		belongs_to :user
    belongs_to :saved_deck
        has_many  :cards, dependent: :destroy
        has_one  :course 
        has_one  :subject
        has_one  :school
        has_many :deckratings, dependent: :destroy
        has_many :flagged_decks, dependent: :destroy
 	
    validates :deck_title, :subject_name, presence: true
    validates_length_of :deck_title, :maximum => 50
    validates_length_of :subject_name, :maximum => 40
    validates_length_of :course_name, :maximum => 70
    validates_length_of :course_num, :maximum => 5

 	after_create :do_setID


  def self.search(subject, name, number, school, prof)
    query_obj = Deck.all
    query_obj = query_obj.where('subject_name like ?', "%#{subject}%") unless subject.blank?
    query_obj = query_obj.where('course_name like ?', "%#{name}%") unless name.blank?
    query_obj = query_obj.where('course_num like ?', "%#{number}%") unless number.blank?
    query_obj = query_obj.where('school_name like ?', "%#{school}%") unless school.blank?
    query_obj = query_obj.where('prof_name like ?', "%#{prof}%") unless prof.blank?
    query_obj
  end

  private
    def do_setID
      
      newID = self.id
      self.update_attributes(:deck_id => newID)


    end
end