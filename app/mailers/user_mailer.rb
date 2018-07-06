class UserMailer < ApplicationMailer
  # Method to send account activation email to user upon signup
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end
  # Method to send a password reset email to the users email 
  # which is requesting a password reset
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end