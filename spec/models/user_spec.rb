require 'rails_helper'

RSpec.describe User, type: :model do
	describe "validations for user " do
		it "should not nil of email when user created " do 
			@user = User.create(email: "testing@gmail.com", password: "password", password_confirmation: "password")
			expect(@user).to be_valid
		end
	end

end
