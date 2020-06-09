require 'rails_helper'

RSpec.describe Article, type: :model do
	describe "validations for articles" do 
		it "should have article name " do 
			@article = Article.create!(name: nil, description: "this book is very good and inspiring")
			expect(@article).to be_valid
		end
	end

end


