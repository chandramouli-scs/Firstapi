require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do
	describe "Articles" do
		before(:each) { request.headers['auth_token'] = "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1OTIzOTMzNDQsImlzcyI6IlJhaWxzSnd0QXV0aCIsImF1dGhfdG9rZW4iOiIzU3FNUm5kcmlYNjNvdTg5R0h5c1djRFcifQ.QdanFvdrVZ1FFSNfmxOel77V1yfH8fHcE9s5wN1qaRs" }

	it "should check authroized" do
	get :index
	expect(response.status).to eq(200) 
	# request.headers['Authorization'] = "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1OTIyMjQwNzUsImlzcyI6IlJhaWxzSnd0QXV0aCIsImF1dGhfdG9rZW4iOiJkSHNIcUJVOFRBVWVITFpXSEdKQ1V3QWYifQ.c4iCkfamr-NNsuRs8gEarqVwVy4DjfyibRCPLNXWkt0" 
	end

	



	
	# it "should create article" do
	# 	article = Article.new(name: "lets see", description: "hello world").save
	# 	get :create
	# 	expect(response.status).to eq(200) 
	# end
end
end