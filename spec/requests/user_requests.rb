require 'rails_helper'

RSpec.describe "User -", type: :request do
	describe "User" do
		it "should sign up " do
			post '/registration', :params => { :user => { email: "hello1@gmail.cog", password: "password", password_confirmation: "password"} }
			expect(response.status).to eq(201) 
		end

		it "should confirm account" do 
			put '/confirmations/dusRXVuN3Rhw7qAXxMmts5Lj'
		end

		it "should in " do 
			post '/session', :params => { :session => { email: "hello1@gmail.cog", password:"password"}}
			expect(response.status).to eq(201) 
		end

		it "should invite others" do
			post '/invitations', :params => {:invitation => { email: "gapkya@gmail.com"}} 
			expect(response.status).to eq(201) 
		end

		
	end
end