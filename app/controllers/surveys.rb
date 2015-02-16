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

delete "/surveys/:survey_id" do
  @survey = Survey.find(params[:survey_id])
  @survey.destroy
  redirect "/surveys"
end


post "/surveys" do
  @survey = Survey.create(title: params[:title], creator_id: session[:user_id])
  @survey.generate_code
  session[:survey_id] = @survey.id
  content_type :json
  { title: @survey.title, unique_url: @survey.random_code }.to_json
end


get "/surveys/:survey_id" do
  ensure_logged_in
  @user = User.find(session[:user_id])
  @survey = Survey.find(params[:survey_id])
  erb :"surveys/view"
end

# Kevin Sunday Edits: Added where they can change the title of the survey (For now...)
put "/surveys/:survey_id" do
  @survey = Survey.update(params[:survey_id], title: params[:title])

  content_type :json
  { title: @survey.title }.to_json
end
# end edits

get "/surveys/:survey_id/share" do
  @survey = Survey.find(params[:survey_id])
  # Kevin Sunday Edits
  puts 'THERE SHOULD BE TWO THINGS BELOW THIS LINE'
  puts params[:survey_key] # This is not showing up for some reason
  puts @survey.random_code
  # end edits
  if params[:survey_key] == @survey.random_code
    erb :"surveys/view"
  else
    redirect "/"
  end
end


get "/surveys/:survey_id/stats" do
  @current_survey = Survey.find(params[:survey_id])

  if @current_survey.responses.empty?
    erb :"surveys/_empty_stats", locals: { current_survey: @current_survey }
  else
    erb :"surveys/stats"
  end
end


get "/surveys/:survey_id/edit" do
  ensure_logged_in # Kevin Sunday Edit: just added this line
  @current_survey = Survey.find(params[:survey_id])
  erb :"surveys/edit"
end


def ensure_logged_in
  if session[:user_id].nil?
    session.delete(:user_id)
    redirect "/"
  end
end

