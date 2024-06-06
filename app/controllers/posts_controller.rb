class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update]
    before_action :authorize_admin!, only: [:destroy]
  
    def index
      @posts = Post.all
    end
  
    def new
      @post = Post.new
      Rails.logger.debug "Initialized @post: #{@post.inspect}"
    end
  
    def show
    end
  
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @post.destroy
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to posts_path, alert: "Post not found"
    end
  
    def authorize_user!
      redirect_to posts_path, alert: "You are not authorized to perform this action." unless @post.user == current_user
    end
  
    def authorize_admin!
      redirect_to posts_path, alert: "You are not authorized to perform this action." unless current_user.admin?
    end
  
    def post_params
      params.require(:post).permit(:title, :body)
    end
  end
  