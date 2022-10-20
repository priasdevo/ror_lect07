class MainController < ApplicationController
	def login
		session[:authen] = false
	end

	def relay
		id = params[:userid]
		pass = params[:password]
		users = User.find(id)
		if(users.authenticate(pass))
			session[:userid] = id
			session[:authen] = true
			redirect_to :controller=>'students',:action=>'index'
		else
			redirect_to :controller=>'main',:action=>'login'
		end
	end

end
