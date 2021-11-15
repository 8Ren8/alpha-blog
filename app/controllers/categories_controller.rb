class CategoriesController < ApplicationController

    def new
        @category = Category.new
    end

    def index
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "New category was created successfully"
            redirect_to @category
        else
            render 'new'
        end
    end

    def show
    end

    private
    def category_params
        params.require(:category).permit(:name)
    end
end