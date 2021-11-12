class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]

    def new
        @user = User.new
    end

    def show
        #set up before_action method so no need repeat again in other methods
        #@user = User.find(params[:id])
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def index
        @user = User.paginate(page: params[:page], per_page: 5)
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome #{@user.username}, You have signed up successfully."
            redirect_to @user
        else
            render 'new'
        end
    end

    def edit
        #@user = User.find(params[:id])
    end

    def update
        #@user = User.find(params[:id])
        if  @user.update(user_params)
            flash[:notice] = "Your profile had been updated successfully."
            redirect_to @user
        else
            render 'edit'
        end
    end

    private 
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end
end