class ArticlesController < ApplicationController
    before_action :set_article, only:[:show, :edit, :update, :destroy]
    before_action :require_user, except:[:show, :index]
    before_action :require_same_user, only:[:edit, :update, :destroy]

    def show
        #@article = Article.find(params[:id])
    end

    def index
        #adding @ will turn a variable into instance variable that could be used on other pages
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user

        if @article.save
            flash[:notice] = "New article was created successfully."
            redirect_to article_path(@article)

        else
            render 'new'
        end

    end

    def edit
        #@article = Article.find(params[:id])
    end

    def update
        #@article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:notice] = "Article was updated successfully."
            redirect_to @article

        else
            render 'edit'
        end

    end

    def destroy
        #@article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

    #anything below private is a private method, which is avaialble in this controller only
    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        #Strong parameters - whitelisting of data (values associated with attributes) that are received through the params hash. 
        #During this process for articles you had to 'whitelist' the data coming through for the title and description fields.
        params.require(:article).permit(:title, :description, category_ids: [])
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end

end