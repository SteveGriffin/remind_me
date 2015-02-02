class AddColumnsToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :call, :boolean, :default => :false
    add_column :reminders, :sms, :boolean, :default => :false
  end
end
