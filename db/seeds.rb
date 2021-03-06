# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command (or created
# alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' },
#     { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

nus = University.create(name: 'National University of Singapore')
smrt = University.create(name: 'SMRT')

tiffany = User.create(name: 'Tiffany',
                      password: '123456',
                      email: 'sciffany@gmail.com',
                      university: nus)
julius = User.create(name: 'Julius',
                     password: '123456',
                     email: 'test@test.com',
                     university: nus)
User.create(name: 'Jeffrey',
            password: 'han hock',
            email: 'jeffrey@smrt.sg',
            university: smrt)

cs1101s = Course.create(code: 'CS1101S', university: nus)
Course.create(code: 'MA1101R', university: nus)
Course.create(code: 'ABCDE', university: smrt)
semester = Semester.create(start_year: 2017,
                           end_year: 2018,
                           number: 1,
                           course: cs1101s)
paper = Paper.create(name: 'Finals', semester: semester)
question1 = Question.create(name: 'Essence of Recursion', number: 1, paper: paper)
_question2 = Question.create(name: 'Vim vs emacs', number: 2, paper: paper)

answer1 = Answer.create(content: 'make_fact',
                        imgur: 'www.google.com',
                        question: question1,
                        user: tiffany)
_answer2 = Answer.create(content: 'make_fact(make_fact)'\
                                  ' // This answer is so obvious anyone should have '\
                                  'been able to see it. Doloroajd nodzsfnoadnfboiajf boiajfobijaw'\
                                  'jvn, ajknreva rvkajrbv akjvb aekrhjvb aekjrhbv akehrv aerjkhv',
                         imgur: 'www.google.com',
                         question: question1,
                         user: julius)
Comment.create(content: 'y combinator', answer: answer1, user: julius)
