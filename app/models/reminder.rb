class Reminder < ActiveRecord::Base
  validates :message, :phone, presence: true
  
  belongs_to :user

  def self.check_reminders
    active = Reminder.all.where(active: :true)

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

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.account.messages.create({
                                      :from => '+19787889381',
                                      :to => reminder.phone,
                                      :body => reminder.message
    })

  end



  def self.test
    puts ENV['ACCOUNT_SID']
    puts ENV['AUTH_TOKEN']
  end

end
