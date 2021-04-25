class DropBookingsDate < ActiveRecord::Migration
  def change
  	remove_column :bookings, :date
  end
end
