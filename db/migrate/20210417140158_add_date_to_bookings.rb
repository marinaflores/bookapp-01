class AddDateToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :date, :date
  end
end
