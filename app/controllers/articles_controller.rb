class ArticlesController < ApplicationController
    def show
        #adding @ will turn a variable into instance variable that could be used on other pages
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end
    
end