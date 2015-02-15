pizzalover = User.create!(username: "pizzalover", email: "jane@mail.com", password: "password")

colors = Survey.create!(title: "Colors", creator_id: 1, random_code: SecureRandom.urlsafe_base64)

q1 = Question.create!(survey: colors, query: "What's your favorite color?")

Answer.create!(question: q1, choice: "yellow")
Answer.create(question: q1, choice: "red")
Answer.create(question: q1, choice: "blue")
Answer.create(question: q1, choice: "white")
Answer.create(question: q1, choice: "none of the above")

q2 = Question.create!(survey: colors, query: "What's your least favorite color?")

Answer.create(question: q2, choice: "yellow")
Answer.create(question: q2, choice: "red")
Answer.create(question: q2, choice: "blue")
Answer.create(question: q2, choice: "white")
Answer.create(question: q2, choice: "none of the above")

q3 = Question.create!(survey: colors, query: "What color is your shirt?")

Answer.create(question: q3, choice: "yellow")
Answer.create(question: q3, choice: "red")
Answer.create(question: q3, choice: "blue")
Answer.create(question: q3, choice: "white")
Answer.create(question: q3, choice: "none of the above")

q4 = Question.create!(survey: colors, query: "What color are your pants?")

Answer.create(question: q4, choice: "yellow")
Answer.create(question: q4, choice: "red")
Answer.create(question: q4, choice: "blue")
Answer.create(question: q4, choice: "white")
Answer.create(question: q4, choice: "none of the above")

q5 = Question.create!(survey: colors, query: "Do you like this survey?")

Answer.create(question: q5, choice: "yellow")
Answer.create(question: q5, choice: "red")
Answer.create(question: q5, choice: "blue")
Answer.create(question: q5, choice: "white")
Answer.create(question: q5, choice: "none of the above")
