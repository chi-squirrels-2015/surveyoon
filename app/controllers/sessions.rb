post '/sessions' do
  # sign in
  user = User.authenticate(params[:username], params[:password])

  if user
    session[:user_id] = user.id
    redirect "/surveys"
  else
    erb :login
  end
end

delete '/sessions/:id' do # Kevin Edit NOTE: This is invoked via AJAX
  # sign out
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
end
