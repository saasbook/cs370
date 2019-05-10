ActionMailer::Base.smtp_settings = { 
  :address              => 'smtp.gmail.com',
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => 'non.reply.bear.email@gmail.com',
  :password             => '#goBears',
  :authentication       => :plain,
  :openssl_verify_mode  => 'none'
} 