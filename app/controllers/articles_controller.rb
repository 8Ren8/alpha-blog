class ArticlesController < ApplicationController
    def show
        #adding @ will turn a variable into instance variable that could be used on other pages
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def create
        #Strong parameters - whitelisting of data (values associated with attributes) that are received through the params hash. 
        #During this process for articles you had to 'whitelist' the data coming through for the title and description fields.
        @article = Article.new(params.require(:article).permit(:title, :description))

        if @article.save
            flash[:notice] = "New article was created successfully."
            redirect_to article_path(@article)

        else
            render 'new'
        end

    end

    def new
        @article = Article.new
    end

end