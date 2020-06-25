require 'rails_helper'

RSpec.describe "Article", type: :request do
	describe "is Authenticating using jwt token header " do
		before :each do
			#signing_up
			user_options = {email: "hellooooaya@gmail.com", password: "password", password_confirmation: "password"}
			post '/registration', :params => {:user => user_options}
			user_details = User.where(email: "#{user_options[:email]}").first
			#confirming user
			put "/confirmations/#{user_details.confirmation_token}"
			#sign-in user
			post '/session', :params => {:session => {email: "moulkdsjhfdjlijaya@gmail.com", password: "password"}}
			#jwt token
			@result =JSON.parse(response.body)["session"]["jwt"]
		end

		it "should create article"do 
			post '/api/v1/articles',:params => { :article => attributes_for(:article, description: "this is testing")}, :headers => { Authorization: @result}
			json = JSON.parse(response.body)
			expect(json["data"]["description"]).to eq("this is testing")
		end

		it "should get all articles" do 
			get '/api/v1/articles', :headers => { Authorization: @result}
			json = JSON.parse(response.body)
			expect(json["message"]).to eq "All articles are loaded"
		end

		it "should update article" do 
			@article = create(:article, name: "mouli")
			put "/api/v1/articles/#{@article.id}", :params => { :article => attributes_for(:article, name: "vamsi")}, :headers => { Authorization: @result }
			@article.reload
			expect(@article.name).to eq "vamsi"
			json = JSON.parse(response.body)
			expect(json["message"]).to eq "Article Updated"
		end

		it "should delete article" do 
			@article = create(:article)
			expect{delete "/api/v1/articles/#{@article.id}", :headers => { Authorization: @result }}.to change{Article.count}.by(-1)
			json = JSON.parse(response.body)
			expect(json["message"]).to eq "Article Deleted"

		end

	end
end