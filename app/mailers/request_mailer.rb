class RequestMailer < ApplicationMailer
  default from: 'no-reply@timeguard.com'

  def approval_email(request)
    @request = request
    mail(to: @request.user.email, subject: 'Your Request Has Been Approved')
  end

  def rejection_email(request)
    @request = request
    mail(to: @request.user.email, subject: 'Your Request Has Been Rejected')
  end
end
