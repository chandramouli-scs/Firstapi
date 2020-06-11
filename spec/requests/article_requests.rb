require 'rails_helper'

RSpec.describe "Article", type: :request do
	describe "Requests" do
		it "should get articles" do
			get '/api/v1/articles',headers: { "Authorization" => "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1OTIzOTMzNDQsImlzcyI6IlJhaWxzSnd0QXV0aCIsImF1dGhfdG9rZW4iOiIzU3FNUm5kcmlYNjNvdTg5R0h5c1djRFcifQ.QdanFvdrVZ1FFSNfmxOel77V1yfH8fHcE9s5wN1qaRs" }
			# expect(response.content_type).to eq("application/json")
			expect(response.status).to eq(200)
		end
	end
end
