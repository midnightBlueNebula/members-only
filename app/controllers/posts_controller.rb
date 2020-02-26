class PostsController < ApplicationController

  before_action :edit_auth_check, only: [:edit, :update]
  before_action :del_auth_check , only: [:destroy]
  before_action :set_post       , only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post sended."
      redirect_to @post
    else
      flash[:error] = "Failed to send post."
      render :new
    end
  end

  def show
    @user = User.find(@post.user_id)
    @comments = Post.comments.all 
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = "Post edited."
      redirect_to @post
    else
      flash[:error] = "Failed to edit post."
      redirect_to :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Post deleted."
      redirect_to root_path
    else
      flash[:error] = "Failed to delete post."
      redirect_to @post
    end
  end

  private

  def edit_auth_check
    redirect_to(root_url) unless current_user == User.find(@post.user_id)
  end

  def del_auth_check
    redirect_to(root_url) unless current_user.admin? || current_user == User.find(@post.user_id)
  end

  def set_post
    @post = Post.find[params[:id]]
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
