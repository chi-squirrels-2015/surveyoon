post '/sessions' do
  # sign in
  @username = params[:username]
  user = User.authenticate(@username, params[:password]) # need to check with model of User to figure out if this is in there
  if user
    session[:user_id] = user.id
    redirect "/surveys"
  else
    erb :index
  end
end

delete '/sessions/:id' do
  # sign out
  return 401 unless params[:id] == session[:user_id]
  session.clear
  200
end
