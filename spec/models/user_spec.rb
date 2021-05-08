require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is valid with email, password and password_confirmation' do
    user = User.new
    user.password = '123456'
    user.password_confirmation = '123456'
    expect(user.save).to eq(false) #Precosa do emial
    user.email = 'admin@admin.com.br'
    expect(user.save).to eq(true)
  end

end
