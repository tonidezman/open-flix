class ApplicationMailer < ActionMailer::Base
  default from: 'openflix.heroku.com'
  layout 'mailer'
end
