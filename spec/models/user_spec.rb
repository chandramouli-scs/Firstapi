require 'rails_helper'

RSpec.describe User, type: :model do
	describe "validations for user " do
		it "should not nil of email when user created " do 
			@user = create(:user)
			expect(@user).to be_valid
		end

		it "is invalid without email" do
			@user = build(:user, email: nil)
			@user.valid?
			expect(@user.errors[:email]).to eq(["can't be blank", "is invalid"])
		end

		it "is invalid without password" do
			@user = build(:user, password: nil)
			@user.valid?
			expect(@user.errors[:password]).to eq ["can't be blank"]
		end

		it "is invalid with doesn't match password with password_confirmation" do
			@user = build(:user, password_confirmation: "helloworld")
			@user.valid?
			expect(@user.errors[:password_confirmation]).to eq(["doesn't match Password"])
		end
	end

end
