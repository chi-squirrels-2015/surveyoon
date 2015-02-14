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

get "/surveys/:survey_id" do # Kevin Edited
  # ensure_logged_in
  # @user = User.find(session[:user_id])
  @survey = Survey.find(params[:survey_id])
  erb :"surveys/view"
end


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


get "/surveys/:survey_id/stats" do
  @current_survey = Survey.find(params[:survey_id])
  @responses = @current_survey.responses
  erb :"surveys/stats"
end

get "/surveys/:survey_id/edit" do
  @current_survey = Survey.find(params[:survey_id])
  erb :"surveys/edit"
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
