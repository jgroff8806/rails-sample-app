class AccountActivationsController < ApplicationController
  # Activates a user via their email
  # A success message is displayed if activated, invalid message displayed if not
  # Redirects to the users page if activated, or back to the home page if invalid
  def edit
    user = User.find_by(email: params[:email])
    # Checks to see if the user found by their email has been activated or not yet
    # If successful, user account is activated and logs the user in
    # Displays account activation message and redirects to the user's page
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    # Displays warning message if the activation link is invalid
    # Redirects back to the home page
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end