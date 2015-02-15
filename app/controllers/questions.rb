post "/questions" do
  @question = Question.create(survey_id: session[:survey_id], query: params[:query])
  params[:answer].each do |answer|
    @question.answers << Answer.create(choice: answer)
  end

  if request.xhr?
    @survey = Survey.find(session[:survey_id])
    erb :"surveys/_saved_question", locals: { survey: @survey, question: @question }, layout: false
  else
    erb :"surveys/new"
  end

end

put "/questions/:question_id" do
  ensure_logged_in

  @question = Question.update(params[:question_id], query: params[:query])
  # Another way to get around this line?
  Answer.where(question_id: params[:question_id]).delete_all

  params[:answer].each do |answer|
    @question.answers << Answer.create(choice: answer)
  end

  puts
  if request.xhr?
    erb :"surveys/_saved_question", locals: { question: @question }, layout: false
  else
    erb :"surveys/edit"
  end
end

def ensure_logged_in
  if session[:user_id].nil?
    session.delete(:user_id)
    redirect "/"
  end
end