class InvitationMailer < ActionMailer::Base
  default from: "info@kirari.it"

  def invitation(invitation)
    @key = invitation.key
    @name = invitation.name
    mail to: invitation.email, subject: 'Kirari テストサイトへのご招待'
  end
end
