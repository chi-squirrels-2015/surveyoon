get "/surveys" do
  ensure_logged_in

  @user = User.find(session[:user_id])
  @surveys = Survey.where(creator_id: session[:user_id])

  erb :"surveys/index"
end

get "/surveys/new" do
  ensure_logged_in

  @user = User.find(session[:user_id])

  erb :"surveys/new"
end

post "/surveys" do
  @survey = Survey.create(title: params[:title], creator_id: session[:user_id])
  session[:survey_id] = @survey.id
  content_type :json
  { title: @survey.title }.to_json
  # erb :"surveys/new"
end

post "/questions" do
  @question = Question.create(survey_id: session[:survey_id], query: params[:query])
  params[:answer].each do |answer|
    @question.answers << Answer.create(answer)
  end

  if request.xhr?
    @survey = Survey.find(session[:survey_id])
    erb :"surveys/new"
    # erb :"surveys/_saved_question", locals: { survey: @survey, question: @question }, layout: false
    # previous form will disappear and be replaced by text/partial << will be in the same div
    # append new form
  else
    erb :"surveys/new"
  end

  # We want append a new form (but we can render this in the JS app file using jQuery)
  # We want to send the Question and the Question Choices
  # {question: question.query, choices: question.answers }.to_json
  # question.answers == [[id: 1, choice: , timestamp ...], [id: 2, choice: , timestamp: ...], ....]

end

get "/surveys/:survey_id" do
  @survey = Survey.find(params[:survey_id])
  erb :"surveys/survey_view"
end

def ensure_logged_in
  if session[:user_id].nil?
    session.delete(:user_id)
    redirect "/"
  end
end




  # <input type="text" name="answer[:choice] placeholder="Put your choice here">
  # <input type="text" name="answer[:choice] placeholder="Put your choice here">
  # <input type="text" name="answer[:choice] placeholder="Put your choice here">
  # params[:answer]
  # question = Question.create(params[:question])
  # question.answers << params[:answers] << inherits the question id through shovel
  # question.answer = []
  #  =====
  # params[:query].each do |query|
  #   question = survey.question.create(query: query)
  #   params[:choice].each do |choice|
  # survey.question.answer.create(question_id: question.id, choice: params[:choice])
