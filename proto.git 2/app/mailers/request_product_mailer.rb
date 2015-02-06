class RequestProductMailer < ActionMailer::Base
  default from: "info@kirari.it"

  def notify_created
    User.where(role: 'admin').each do |user|
      mail(to: user.email, subject: 'Kirari 商品登録申請通知').deliver
    end
  end

  def notify_product_info request
    @request = request
    mail(to: request.user.email, subject: 'Kirari（キラリ） 商品登録完了のお知らせ').deliver
  end
end
