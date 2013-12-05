# Load the Rails application.
require File.expand_path('../application', __FILE__)

#config.action_mailer.default_url_options = { :host => 'localhost:3000' }
# Initialize the Rails application.
First_Website::Application.initialize!


ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}