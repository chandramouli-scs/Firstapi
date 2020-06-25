require 'rails_helper'

RSpec.describe Article, type: :model do
	describe "Articles" do 


		it "should not have nil values  " do 
			@article = create(:article)
			expect(@article).to be_valid
		end


		it "should have article name " do 
			@article = build(:article, name: nil)
			@article.valid?
			expect(@article.errors[:name]).to eq(["can't be blank"])
		end


		it "should have article description " do 
			@article = build(:article, description: nil)
			@article.valid?
			expect(@article.errors[:description]).to eq(["can't be blank"])
		end

	end

end


