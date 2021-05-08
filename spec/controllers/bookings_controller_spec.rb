require 'rails_helper'

RSpec.describe BookingsController, type: :controller do

	context 'Not Authorizated' do

		it 'index' do
			get :index
		  expect(response).to_not be_success
		end

	end


	context 'Logged User' do

	  before do
	   User.create!(email: 'maria@esl.com.br', password: '123456', password_confirmation: '123456')
	  end

	  it 'responds a 200 response' do
	  	 user = User.last
	  	 sign_in user
	  	 get :index
	  	 expect(response).to have_http_status(200)
	  end

	  it 'render a :index template' do
	  	 user = User.last
	  	 sign_in user
	  	 get :index
	  	 expect(response).to render_template(:index)
	  end

	end
end
