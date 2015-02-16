get "/" do
  if session[:user_id]
    redirect "/surveys"
  else
    erb :login
  end
end