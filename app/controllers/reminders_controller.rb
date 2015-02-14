class RemindersController < ApplicationController
  before_action :set_reminder, only: [:show, :edit, :update, :destroy]
  before_action :authenticate

  # GET /reminders
  # GET /reminders.json
  def index
    admin?
    @reminders = Reminder.all
  end

  # GET /reminders/1
  # GET /reminders/1.json
  def show
  end

  # GET /reminders/new
  def new
    @reminder = Reminder.new
  end

  # GET /reminders/1/edit
  def edit
  end

  #mass message
  #sends an immediate reminder out to the list of numbers
  def mass_message
    #binding.pry
    #take numbers and split up into array
    numbers = params[:mass_message][:numbers]
    numbers = numbers.split

    #check if there are actual numbers to send the message to
    #if not, return error message
    if numbers.count > 0

      #restrict amount of messages to be sent to a total of 5
      if numbers.count > 5
        redirect_to dashboard_path(current_user.id), notice: 'Maximum of 5 numbers allowed for mass messages.' and return
      end

      #get message
      message = params[:mass_message][:message]

      #send message to each number, TBD
      numbers.each do |number|
        reminder = Reminder.create(message: message, phone: number, reminder_time: Time.now - 1.day , user_id: current_user.id, sms: true)
        #Reminder.generate_reminder(reminder)
        reminder.save
      end

      render plain:  "Reminders Sent"
    else
      redirect_to dashboard_path(current_user.id), notice: 'You must include at least one number for a mass message.'
    end


  end


  # POST /reminders
  # POST /reminders.json
  def create
    @reminder = Reminder.new(reminder_params)

    respond_to do |format|
      if @reminder.save
        #Reminder.generate_reminder(@reminder)
        format.html { redirect_to dashboard_path(current_user.id), notice: 'Reminder was successfully created.' }
        format.json { render :show, status: :created, location: @reminder }
      else
        format.html { redirect_to dashboard_path(current_user.id), notice: 'All fields must be filled out correctly' }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reminders/1
  # PATCH/PUT /reminders/1.json
  def update
    respond_to do |format|
      if @reminder.update(reminder_params)
        format.html { redirect_to @reminder, notice: 'Reminder was successfully updated.' }
        format.json { render :show, status: :ok, location: @reminder }
      else
        format.html { render :edit }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.json
  def destroy
    @reminder.destroy
    respond_to do |format|
      format.html { redirect_to reminders_url, notice: 'Reminder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_reminder
    @reminder = Reminder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reminder_params
    params.require(:reminder).permit(:message, :reminder_time, :phone, :default, :user_id, :call, :sms)
  end
end
