class Reminder < ActiveRecord::Base
  validates :message, :phone, presence: true

  belongs_to :user

  def self.check_reminders
    active = Reminder.where(active: true)

    if active.count < 1
      puts "No Reminders To Be Sent"
    else
      #check active records and if the reminder time has elapsed,
      #send the twilio message and mark the reminder as inactive
      active.each do |reminder|
        if reminder.reminder_time < Time.now
          generate_reminder(reminder)
          reminder.active = false
          reminder.save
        end
      end
    end


  end

  #takes reminder object and sends message based on its parameters
  def self.generate_reminder(reminder)
    account_sid = ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']
    #binding.pry

    if reminder.sms == true
      # set up a client to talk to the Twilio REST API
      @client = Twilio::REST::Client.new account_sid, auth_token

      @client.account.messages.create({
                                        :from => '+19787889381',
                                        :to => reminder.phone,
                                        :body => 'RemindMe Service Reminder: ' << reminder.message
      })
    end

    #send a phone notification if reminder has phone call notification
    if reminder.call == true
      #binding.pry
      # set up a client to talk to the Twilio REST API
      @client = Twilio::REST::Client.new account_sid, auth_token

      #use different url for testing and production
      if Rails.env.development?
              #setup custom xml document for notification - TBD
      @call = @client.account.calls.create({
                                             :url => 'http://b7b6c37.ngrok.com/twilio/voice/' << reminder.id.to_s,
                                             :from => '+19787889381',
                                             :to =>  reminder.phone,
                                             :IfMachine => 'Continue'
      })

      else
              #setup custom xml document for notification - TBD
      @call = @client.account.calls.create({
                                             :url => 'http://futuretide.net/twilio/voice/' << reminder.id.to_s,
                                             :from => '+19787889381',
                                             :to =>  reminder.phone,
                                             :IfMachine => 'Continue'
      })
      end

    end

  end





  # def self.test
  #   puts ENV['ACCOUNT_SID']
  #   puts ENV['AUTH_TOKEN']
  #   account_sid = ENV['ACCOUNT_SID']
  #   auth_token = ENV['AUTH_TOKEN']
  #   # set up a client to talk to the Twilio REST API
  #   @client = Twilio::REST::Client.new account_sid, auth_token

  #   #setup custom xml document for notification - TBD
  #   @call = @client.account.calls.create({
  #                                          :url => 'http://507b6c6f.ngrok.com/twilio/voice',
  #                                          :from => '+19787889381',
  #                                          :to =>  '6037038270'
  #   })

  # end

end
