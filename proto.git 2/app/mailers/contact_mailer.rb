class ContactMailer < ActionMailer::Base
  default from: "info@kirari.it"

  def contact contact
    @body = contact.body
    mail(to: contact.address, subject: contact.subject)
  end
end
