require 'twilio-ruby'

class TwilioController < ApplicationController

  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

  #handles transcribed phone call message
  def voice
    reminder = Reminder.find(params[:id])
  	response = Twilio::TwiML::Response.new do |r|
      r.Say 'This is a reminder message from the Remmyo service.',:voice => 'alice'
  	  r.Say reminder.message, :voice => 'alice'
      r.Say 'End of message.',:voice => 'man'
        # r.Play 'http://linode.rabasa.com/cantina.mp3'
  	end

  	render_twiml response
  end
end