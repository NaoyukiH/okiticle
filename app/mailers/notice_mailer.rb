class NoticeMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #
  def sendmail_confirm(contact)
    @contact = contact

    mail(to: @contact.email, subject: "Thank you for your contact!")
  end
end
