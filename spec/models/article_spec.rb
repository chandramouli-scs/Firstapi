require 'rails_helper'

RSpec.describe Article, type: :model do
	describe "Articles" do 


		it "should not have nil values  " do 
			@article = Article.create(name: nil, description: "nil")
			expect(@article).to be_valid
		end


		it "should have article name " do 
			@article = Article.new(description: "this book is awesome").save
			# expect(@article).to be_valid
			expect(@article).to eq(false)
		end


		it "should have article description " do 
			@article = Article.new(name: "something").save
			# expect(@article).to be_valid
			expect(@article).to eq(false)
		end


		# it "should have transaction  action" do
		# post :status
		# end
	end

end


