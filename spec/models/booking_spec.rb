require 'rails_helper'

RSpec.describe Booking, type: :model do

	present_date = Time.current.strftime('%d/%m/%Y')
	past_date = (Time.current - 2.days).strftime('%d/%m/%Y')

  def create_booking(date)
    Booking.create!(
      date: date,
      hour: '08:00',
      description: 'Reunião teste',
      user: User.last
    )
  end

  before(:each) do
   User.create!(email: 'maria@esl.com.br', password: '123456', password_confirmation: '123456')
   User.create!(email: 'joao@esl.com.br', password: '123456', password_confirmation: '123456')
  end

  context 'Create' do

    context 'Validations' do
      it 'is valid with date, hour and user' do
        booking = Booking.new
        booking.date = present_date
        booking.hour = '10:00'
        #booking.description = 'Reunião Teste'
        booking.user = User.last
        expect(booking.save).to eq(true)
      end

      it 'is not valid without date' do
        booking = Booking.new
        #booking.date = present_date
        booking.hour = '10:00'
        booking.description = 'Reunião Teste'
        booking.user = User.last
        expect(booking.save).to eq(false)
      end

      it 'is not valid without hour' do
        booking = Booking.new
        booking.date = present_date
        #booking.hour = '10:00'
        booking.description = 'Reunião Teste'
        booking.user = User.last
        expect(booking.save).to eq(false)
      end
  	end

  	it 'is valid if present date' do
      booking = Booking.new
      booking.date = present_date
      booking.hour = '10:00'
      booking.description = 'Reunião Data Presente'
      booking.user = User.last
      expect(booking.save).to eq(true)
    end

    it 'is not valid if past date' do
      booking = Booking.new
      booking.date = past_date
      booking.hour = '10:00'
      booking.description = 'Reunião Data Passada'
      booking.user = User.last
      expect(booking.save).to eq(false)
    end

    it 'the reservation can not collide with the other' do
      booking1= create_booking(present_date)
      booking1.update_attribute(:hour, '08:00')

      booking = Booking.new
      booking.date = present_date
      booking.hour = '08:00'
      booking.description = 'Reunião Teste'
      booking.user = User.last

      expect(booking.save).to eq(false)
    end
  end

  context 'Update' do
    it 'the reservation edit can only be done by the created user ' do
      create_booking(present_date)
      x = Booking.last
      x.description = 'Reunião Teste - Editado'
      expect(x.save).to eq(false)
    end

    it 'the reservation edit can only be done before date passes' do
      booking = create_booking(present_date)
      booking.update_attribute(:date, past_date)

      expect(booking.save).to eq(false)
    end
  end

  context 'Destroy' do
    # Não conseguir fazar a validação no model
  end
end
