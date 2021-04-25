class AddHourToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :hour, :string
  end
end
