module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end
		


	def current_user=(user)
		@current_user = user
	end	

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in." 
      # これではエラーになった　→　redirect_to(signin_path), notice: "Please sign in." 
      # 第2引数を取らない場合は、signin_url(可)、signin_path(可)、(signin_url)(可)、(signin_path)(可)
      # 第2引数を取る場合は、signin_url(可)、signin_path(可)、(signin_url)(不可)、(signin_path)(不可)
      
      

     end
    end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
	end

end
