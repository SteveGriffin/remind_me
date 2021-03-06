class User < ActiveRecord::Base
  has_secure_password
  has_many :reminders
  validates_uniqueness_of :email


  #create user with credentials supplied by oauth
  def self.create_with_omniauth(auth)

    if auth["provider"] == 'github'
      create! do |user|
        user.provider = auth["provider"]
        #user.uid = auth["uid"]
        user.name = auth["info"]["nickname"]
        user.password = auth["uid"]
        user.email = auth["info"]["email"]
        user.active = true
        user.admin = false
      end

    elsif auth[:provider] == 'google_oauth2'
      create! do |user|
        user.provider = auth["provider"]
        #user.uid = auth["uid"]
        user.name = auth["info"]["name"]
        user.password = auth["uid"]
        user.email = auth["info"]["email"]
        user.active = true
        user.admin = false
      end
    end
  end

  #remove any non numeric elements from phone number
  def self.sanitize_phone(phone_number)
    phone = phone_number.gsub!(/[^0-9]/, "")
    phone
  end
end
