require 'rails_helper'

RSpec.describe "User -", type: :request do

	describe "User" do
		it "should sign up but not with already exists email " do
			post '/registration', :params => { :user => { email: "hello1@gmail.cog", password: "password", password_confirmation: "password"} }
			expect(response.status).to eq(422) 
		end

		it "should confirm account" do 
			put '/confirmations/dusRXVuN3Rhw7qAXxMmts5Lj'
		end


		describe "User" do

			before :each do 
				post '/session', :params => { :session => { email: "hello1@gmail.cog", password:"password"}}
				@result =JSON.parse(response.body)["session"]
			end

			it "should in " do 
				expect(response.body).to match("hello1@gmail.cog")
			end

			it "should send invitation to other email" do
				send_email = "test@gmail.com"
				post '/invitations', :params => {:invitation => {email: send_email }}, :headers =>{ Authorization: @result["jwt"] }
				expect(response.body).to match("Invitation successfully sent")
				
			end
			
			it "should signout" do
				delete '/session', :headers => { Authorization: @result["jwt"] }
				expect(response.body).to match("Logout successfully")
			end

		end 

		

		
	end
end