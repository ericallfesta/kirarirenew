class SendMail
  @queue = :send_mail

  def self.perform(contact)
    sleep 3
    path = File.expand_path("log/send_mail.log", Rails.root)
    File.open(path, 'a') do |f|
      f.puts "Sent mails"
      f.puts Time.now
      f.puts contact.subject
      f.puts contact.body
      f.puts
    end

    contact.deliver
  end
end
