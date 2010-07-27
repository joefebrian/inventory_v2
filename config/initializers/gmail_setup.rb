ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "monsterinc.com",
  :user_name => "rbudiharso@gmail.com",
  :password => "14mr3xuz",
  :authentication => :plain
} 
