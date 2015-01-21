class SessionsController < ApplicationController

	def new
	end

	def create
	   user = User.find_by(email: params[:session][:email].downcase)
	   if user && user.authenticate(params[:session][:password])
	   	sign_in user
	   	redirect_back_or user

	   # elsif user = User.find_or_create_by_auth(auth)
	   # 	auth = request.env["omniauth.auth"]
    #    session[:user_id] = user.id
    #    redirect_back_or user

	   else
       flash.now[:error] = 'Invalid email/password combination'
	   render 'new'
	end
       
	end

	def destroy
		sign_out
		redirect_to root_url
	end
	

end
