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
  @survey.generate_code
  session[:survey_id] = @survey.id
  content_type :json
  { title: @survey.title, unique_url: @survey.random_code }.to_json
end

<<<<<<< HEAD
=======

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


>>>>>>> able to generate unique and safe URL for people to take survey without logging in
get "/surveys/:survey_id" do # Kevin Edited
  ensure_logged_in
  @user = User.find(session[:user_id])
  @survey = Survey.find(params[:survey_id])
  erb :"surveys/view"
end

<<<<<<< HEAD
=======

get "/surveys/:survey_id/share" do
  @survey = Survey.find(params[:survey_id])
  if params[:survey_key] == @survey.random_code
    erb :"surveys/view"
  else
    redirect "/"
  end
end


post "/responses" do
  survey_id = params.first.first.to_i
  current_survey = Survey.find(survey_id)
  current_survey.times_taken += 1
  current_survey.save

  params.each do |q,a|
    Response.create(question_id:q.to_i, answer_id:a.to_i, survey_id: current_survey.id)
  end

  erb :"surveys/_message"
end


>>>>>>> able to generate unique and safe URL for people to take survey without logging in
get "/surveys/:survey_id/stats" do
  @current_survey = Survey.find(params[:survey_id])
  @responses = @current_survey.responses
  erb :"surveys/stats"
end

<<<<<<< HEAD
get "/surveys/:survey_id/edit" do
  @current_survey = Survey.find(params[:survey_id])
  erb :"surveys/edit"
end
=======
>>>>>>> able to generate unique and safe URL for people to take survey without logging in

def ensure_logged_in
  if session[:user_id].nil?
    session.delete(:user_id)
    redirect "/"
  end
end
<<<<<<< HEAD
=======


>>>>>>> able to generate unique and safe URL for people to take survey without logging in
