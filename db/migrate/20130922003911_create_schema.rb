class CreateSchema < ActiveRecord::Migration
  def change
   create_table :users do |t|
    t.string   :username
    t.integer   :user_id,  default: 0, null: false
    t.string   :email, default: "",    null: false               
    t.integer   :decksMade, default: 0, null:false             
    t.boolean   :paid , default:false               
    t.boolean  :admin , default:false               


    t.datetime :created_at
    t.datetime :updated_at
    t.string   :password_digest
    t.string   :remember_token
    t.string   :encrypted_password, default: "",    null: false
    t.string   :reset_password_token
    t.datetime :reset_password_sent_at
    t.datetime :remember_created_at
    t.integer  :sign_in_count, default: 0,    null: false
    t.datetime :current_sign_in_at
    t.datetime :last_sign_in_at
    t.string   :current_sign_in_ip
    t.string   :last_sign_in_ip
  end

 
    create_table :decks do |t|
        t.integer   :deck_id, default:0
        t.string    :deckTitle
        t.integer   :uses, default:0
        t.integer   :user_id, default:0
        t.string     :courseName
        t.integer     :course_id
        t.string     :courseNum
        t.string     :subjectName
        t.integer     :subject_id, default:0
        t.string   :remember_token

       
    end

    create_table :cards do |t|
        t.integer   :card_id, default:0
        t.integer   :deck_id, default:0
        t.string    :qtext
        t.string    :atext
        t.boolean   :isUsed, default: false
        t.datetime  :lastUsed
    end

    create_table :ratings do |t|
        t.integer   :rating_id
        t.integer   :deck_id
        t.integer   :card_id
        t.integer   :user_id
        t.string    :comment
        t.string    :atext
        t.boolean   :liked, default: false
        t.datetime  :created_at

    end
    create_table :recent_decks do |t|
        t.integer   :user_id
        t.integer   :deck_id
        t.integer   :card_id
        t.datetime  :lastUsed

    end

    create_table :subjects  do |t|
        t.integer   :subject_id
        t.string    :name

    end
    create_table :courses do |t|
        t.integer   :subject_id
        t.integer   :course_id
        t.string   :courseNum
        t.string    :name

    end

    create_table :favorite_decks  do |t|
        t.integer   :user_id
        t.integer   :deck_id
        t.integer   :card_id
    end

    create_table :favorite_cards do |t|
        t.integer   :user_id
        t.integer   :card_id

    end
 end
end

