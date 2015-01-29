class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :message
      t.datetime :reminder_time
      t.string :phone

      t.timestamps
    end
  end
end
