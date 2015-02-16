post "/responses" do
  puts "LOOK HERE FOR PUTSSSS"
  puts params
  puts params.first.first.to_i
  question_id = params.first.first.to_i
  reference_question = Question.find(question_id)
  current_survey = reference_question.survey
  current_survey.times_taken += 1
  current_survey.save

  params.each do |q,a|
    Response.create(question_id: q.to_i, answer_id: a.to_i, survey_id: current_survey.id)
  end

  erb :"surveys/_message"
end

def ensure_logged_in
  if session[:user_id].nil?
    session.delete(:user_id)
    redirect "/"
  end
end
