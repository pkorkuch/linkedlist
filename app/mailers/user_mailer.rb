class UserMailer < ApplicationMailer
  default from: email_address_with_name('noreply@linkedlist.korkuch.dev', 'linkedList')
  def account_activation
    @user = params[:user]
    mail to: @user.email, subject: 'Activate your linkedList account.'
  end
end
