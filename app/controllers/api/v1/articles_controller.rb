module Api
	module V1
		class ArticlesController < ApplicationController
			def index
				articles = Article.all
				render json: {status: 'SUCCESS', message: 'Articles are loaded', data:articles}, status: :ok 
			end

			def show
				article = Article.find(params[:id])
				render json: {status: 'SUCCESS', message: 'loaded Article', data:article}, status: :ok
			end

			def create
				article = Article.new(articles_params)
				if article.save
					render json: {status: 'SUCCESS', message: 'Article created', data:article}, status: :ok
				else
					render json: {status: 'ERROR', message: 'Article not saved', data:article.errors}, status: :unprocessble_entity
				end

			end

			def update
				article = Article.find(params[:id])
				if article.update(articles_params)
					render json: {status: 'SUCCESS', message: 'Article Updated', data:article}, status: :ok
				else
					render json: {status: 'ERROR', message: 'Article not updated', data:article.errors}, status: :unprocessble_entity
				end
			end

			def destroy
				article = Article.find(params[:id])
				article.destroy
					render json: {status: 'SUCCESS', message: 'Article Deleted', data:article}, status: :ok
			end

			private

			def articles_params
				params.require(:article).permit(:text, :description)
			end

		end
	end
end