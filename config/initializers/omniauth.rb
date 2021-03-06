# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["REMINDME_CLIENT_ID"], ENV["REMINDME_CLIENT_SECRET"], {
    :scope => 'email,profile'
  }

  provider :github, ENV['REMIND_GITHUB_KEY'], ENV['REMIND_GITHUB_SECRET'], scope: "user:email", provider_ignores_state: :true 

end
