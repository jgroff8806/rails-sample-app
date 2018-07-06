class SessionsController < ApplicationController

  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Logs the user in if they've successfully activated 
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      # Redirects to the home page if the user has not activated their account
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    # Displays a warning message if the email or password entered is invalid
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  # Gets rid of the user session and logs them out if they're logged in
  # Redirects back to the home page
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end