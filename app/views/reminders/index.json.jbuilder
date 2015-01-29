json.array!(@reminders) do |reminder|
  json.extract! reminder, :id, :message, :reminder_time, :phone
  json.url reminder_url(reminder, format: :json)
end
