class UserMailer < ActionMailer::Base
  default from: "info@kirari.it"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
    @url  = "http://kirari.it/users/#{user.activation_token}/activate"
    mail(:to => user.email,
         :subject => t('messages.activation_needed_mail.subject'))
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_success_email.subject
  #
  def activation_success_email(user)
    @user = user
    mail(:to => user.email,
         :subject => t('messages.activation_success_mail.subject'))
  end
end
