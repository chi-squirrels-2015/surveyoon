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

get "/surveys/:survey_id" do # Kevin Edited
  # ensure_logged_in
  # @user = User.find(session[:user_id])
  @survey = Survey.find(params[:survey_id])
  erb :"surveys/view"
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
