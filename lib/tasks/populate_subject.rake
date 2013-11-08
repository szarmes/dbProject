


namespace :db do
  desc "Fill database with Hardcoded Subject"
  task populate: :environment do
    
    Subject.create!(subject_id: 0, name: 'Agroecology')
    Subject.create!(subject_id: 0, name: 'Anthropology')
    Subject.create!(subject_id: 0, name: 'Applied Science')
    Subject.create!(subject_id: 0, name: 'Arts Co-Op')
    Subject.create!(subject_id: 0, name: 'Art History and Visual Culture')
    Subject.create!(subject_id: 0, name: 'Astronomy')
    Subject.create!(subject_id: 0, name: 'Biochemistry')
    Subject.create!(subject_id: 0, name: 'Biology')
    Subject.create!(subject_id: 0, name: 'Creative abd Critical Studies')
    Subject.create!(subject_id: 0, name: 'Chemistry')
    Subject.create!(subject_id: 0, name: 'Computer Science')
    Subject.create!(subject_id: 0, name: 'Creative Writing')
    Subject.create!(subject_id: 0, name: 'Cultural Studies')
    Subject.create!(subject_id: 0, name: 'Curriculum Studies')
    Subject.create!(subject_id: 0, name: 'Digital Humanities')
    Subject.create!(subject_id: 0, name: 'Educational Administration')
     Subject.create!(subject_id: 0, name: 'Educational Studies')
    Subject.create!(subject_id: 0, name: 'English for Academic Purposes')
    Subject.create!(subject_id: 0, name: 'Early Childhood Education')
    Subject.create!(subject_id: 0, name: 'Economics')
    Subject.create!(subject_id: 0, name: 'Engineering')
    Subject.create!(subject_id: 0, name: 'Environmental Science')
    Subject.create!(subject_id: 0, name: 'Educational Psychology and Special Education')
    Subject.create!(subject_id: 0, name: 'Educational Technology')
    Subject.create!(subject_id: 0, name: 'Exchange Programs')
    Subject.create!(subject_id: 0, name: 'Film')
    Subject.create!(subject_id: 0, name: 'French')
    Subject.create!(subject_id: 0, name: 'Geography')
   	Subject.create!(subject_id: 0, name: 'German')
   	Subject.create!(subject_id: 0, name: 'Gerontology')
   	Subject.create!(subject_id: 0, name: 'Greek')
   	Subject.create!(subject_id: 0, name: 'Gender and Womens Studies')
   	Subject.create!(subject_id: 0, name: 'Health Studies')
   	Subject.create!(subject_id: 0, name: 'Hebrew')
   	Subject.create!(subject_id: 0, name: 'Health-Interprofessional')
   	Subject.create!(subject_id: 0, name: 'History')
   	Subject.create!(subject_id: 0, name: 'Human Kinetics')
   	Subject.create!(subject_id: 0, name: 'Interdisciplinary Graduate Studies')
   	Subject.create!(subject_id: 0, name: 'Indigenous Studies')
   	Subject.create!(subject_id: 0, name: 'Japanese Studies')
   	Subject.create!(subject_id: 0, name: 'Latin')
   	Subject.create!(subject_id: 0, name: 'Language and Literacy Education')
   	Subject.create!(subject_id: 0, name: 'Mathematics')
   	Subject.create!(subject_id: 0, name: 'Management Co-Op')
   	Subject.create!(subject_id: 0, name: 'Management')
   	Subject.create!(subject_id: 0, name: 'Music')
   	Subject.create!(subject_id: 0, name: 'Nursing')
   	Subject.create!(subject_id: 0, name: 'Philosophy')
   	Subject.create!(subject_id: 0, name: 'Physics')
   	Subject.create!(subject_id: 0, name: 'Political Science')
   	Subject.create!(subject_id: 0, name: 'Psychology')
   	Subject.create!(subject_id: 0, name: 'Science Co-Op')
   	Subject.create!(subject_id: 0, name: 'Sociology')
   	Subject.create!(subject_id: 0, name: 'Social Work')
   	Subject.create!(subject_id: 0, name: 'Spanish')
   	Subject.create!(subject_id: 0, name: 'Statistics')
   	Subject.create!(subject_id: 0, name: 'Sustainability')
   	Subject.create!(subject_id: 0, name: 'Theater')
   	Subject.create!(subject_id: 0, name: 'Visiting Graduate Students')
   	Subject.create!(subject_id: 0, name: 'Visual Arts')
   	Subject.create!(subject_id: 0, name: 'Visiting Undergraduate Research Students')


    User.create!(email: 'test@test.com', username: 'test', password: 'testtest', password_confirmation: 'testtest')

    Course.create(course_id: 1, subject_id:11, name:"Intro to Databases", courseNum: 304)

    Deck.create(deck_id: 1, deckTitle: "Cosc", uses:0, user_id: 1, 
      courseName: "Intro to Databases", courseNum: 304, subjectName: "Computer Science", subject_id:11 )
    Deck.create(deck_id: 2, deckTitle: "Chem", uses:0, user_id: 1, 
      courseName: "Basic Chemistry", courseNum: 101, subjectName: "Chemistry", subject_id:10 )
    Deck.create(deck_id: 3, deckTitle: "French", uses:0, user_id: 1, 
      courseName: "Tu-parles francais?", courseNum: 133, subjectName: "French", subject_id:27 )
    Deck.create(deck_id: 4, deckTitle: "Calc", uses:0, user_id: 1, 
      courseName: "Calculus I", courseNum: 100, subjectName: "Mathematics", subject_id:43 )
     Deck.create(deck_id: 5, deckTitle: "Music", uses:0, user_id: 1, 
      courseName: "Theory of Music", courseNum: 151, subjectName: "Music", subject_id:46 )
    
    
    #Deck.create(deck_id: 6, deckTitle: "test6", uses:0, user_id: 1, courseNum: 100, subjectName: "Biology", subject_id:8 )
    #Deck.create(deck_id: 7, deckTitle: "test7", uses:0, user_id: 1, courseNum: 100, subjectName: "Biology", subject_id:8 )
    #Deck.create(deck_id: 8, deckTitle: "test8", uses:0, user_id: 1, courseNum: 100, subjectName: "Biology", subject_id:8 )
    #Deck.create(deck_id: 9, deckTitle: "test9", uses:0, user_id: 1, courseNum: 100, subjectName: "Biology", subject_id:8 )
    #Deck.create(deck_id: 10, deckTitle: "test10", uses:0, user_id: 1, courseNum: 100, subjectName: "Biology", subject_id:8 )
    #Deck.create(deck_id: 11, deckTitle: "test11", uses:0, user_id: 1, courseNum: 100, subjectName: "Biology", subject_id:8 )

    Card.create(card_id: 1, deck_id: 1, qtext: "What does DBMS stand for?", atext: "Database Management System")
    Card.create(card_id: 2, deck_id: 1, qtext: "What is a tuple?", atext: "A row in a relation") 
    Card.create(card_id: 3, deck_id: 1, qtext: "Who invented the ER diagram and when?", atext: "Patrick Chen, 1976") 
    Card.create(card_id: 4, deck_id: 1, qtext: "Explain entity integrity constraint", atext: "All values of primary keys must be unique and not null") 
    Card.create(card_id: 5, deck_id: 1, qtext: "Return a list of all employees", atext: "Select * from Employee") 

    Card.create(card_id: 1, deck_id: 2, qtext: "What is Chemistry?", atext: "The study of matter") 
    Card.create(card_id: 1, deck_id: 2, qtext: "Define matter", atext: "Anything that has mass and occupies space")
    Card.create(card_id: 3, deck_id: 2, qtext: "What is an element", atext: "Pure chemical substance composed of 1 type of atom") 
    Card.create(card_id: 4, deck_id: 2, qtext: "What is the element with atomic number 6?", atext: "Carbon") 
    Card.create(card_id: 5, deck_id: 2, qtext: "Explain Bohr's theory", atext: "Rings around nucleus with electrons") 

    Card.create(card_id: 1, deck_id: 3, qtext: "Tu-parles francais?", atext: "Oui, un peu")
    Card.create(card_id: 2, deck_id: 3, qtext: "We are (in french)", atext: "Nous sommes") 
    Card.create(card_id: 3, deck_id: 3, qtext: "You are fat (in french)", atext: "Tu es gros") 
    Card.create(card_id: 4, deck_id: 3, qtext: "I am (in french)", atext: "test4") 
    Card.create(card_id: 5, deck_id: 3, qtext: "May I drink water? (in french)", atext: "Puis-je boire de l'eau?") 

    Card.create(card_id: 1, deck_id: 4, qtext: "d/dx x^2", atext: "2x")
    Card.create(card_id: 2, deck_id: 4, qtext: "d/dx ln(x)", atext: "1/x") 
    Card.create(card_id: 3, deck_id: 4, qtext: "What is the formula for linear approximation?", atext: "f(x) ≈ f(a)+f'(a)(x-a) = L(x)") 
    Card.create(card_id: 4, deck_id: 4, qtext: "d/dx sin(x)", atext: "cos(x)") 
    Card.create(card_id: 5, deck_id: 4, qtext: "Countinuous Function", atext: "No breaks in the graph duh") 

    Card.create(card_id: 1, deck_id: 5, qtext: "What is music?", atext: "The universal language of emotions communicated through intelligently ordered sounds consisting of rhythm and pitch")
    Card.create(card_id: 2, deck_id: 5, qtext: "How does music affect our moral character?", atext: "It affects our emotions") 
    Card.create(card_id: 3, deck_id: 5, qtext: "How is music universal?", atext: "It is understood by everyone everywhere, through all time") 
    Card.create(card_id: 4, deck_id: 5, qtext: "Neoclassicism", atext: "Music which exemplifies a return to classical values such as symmetry and balance 
while upholding contemporary tonal material.") 
    Card.create(card_id: 5, deck_id: 5, qtext: "Shifted Tonality", atext: "Sudden tonality change without modulation according to common practice 
standards.")   

  end
end
