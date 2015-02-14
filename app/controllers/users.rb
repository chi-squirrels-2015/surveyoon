# Kevin Edit

get '/users/new' do #Not sure this is needed. Probably not.
  @user = User.new
  erb :login
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect "/surveys"
  else
    erb :login
  end
end
