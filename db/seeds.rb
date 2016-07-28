# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(user_name: "Lee")
User.create!(user_name: "Susie")
User.create!(user_name: "Bess")
User.create!(user_name: "George")


Poll.create!(title: "Presidential Canditates 2016", author_id: 1)
Poll.create!(title: "Favorite City", author_id: 2)

Question.create!(poll_id: 1, text: "Who do you support for president in 2016?")
Question.create!(poll_id: 2, text: "Do you prefer San Francisco or Los Angeles?")

AnswerChoice.create!(question_id: 1, text: "Hillary Clinton")
AnswerChoice.create!(question_id: 1, text: "Donald Trump")
AnswerChoice.create!(question_id: 1, text: "Gary Johnson")

AnswerChoice.create!(question_id: 2, text: "San Francisco")
AnswerChoice.create!(question_id: 2, text: "Los Angeles")
AnswerChoice.create!(question_id: 2, text: "Fremont")

Response.create!(user_id: 3, answer_choice_id: 3)
Response.create!(user_id: 4, answer_choice_id: 2)
Response.create!(user_id: 2, answer_choice_id: 1)
Response.create!(user_id: 1, answer_choice_id: 4)
Response.create!(user_id: 3, answer_choice_id: 4)
Response.create!(user_id: 4, answer_choice_id: 5)
