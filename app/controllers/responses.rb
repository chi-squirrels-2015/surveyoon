post "/responses" do
  survey_id = params.first.first.to_i
  current_survey = Survey.find(survey_id)
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