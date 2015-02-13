get "/surveys" do
  ensure_logged_in

  @user = User.find(session[:user_id])
  @surveys = Survey.where(creator_id: session[:user_id])

  erb :"surveys/view"
end

get "/surveys/new" do
  ensure_logged_in

  erb :"surveys/new"
end

post "/survey" do

  survey = Survey.create(title: params[:title])
  # This is just for one question
  question = survey.question.create(query: params[:query])
  survey.question.answer.create(question_id: question.id, choice: params[:choice])

  redirect "/surveys"
end

def ensure_logged_in
  if session[:user_id].nil?
    session.delete(:user_id)
    redirect "/"
  end
end
