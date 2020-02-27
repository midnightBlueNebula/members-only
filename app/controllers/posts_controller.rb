class PostsController < ApplicationController

  before_action :edit_auth_check, only: [:edit, :update]
  before_action :del_auth_check , only: [:destroy]
  before_action :set_post       , only: [:show]

  def new
    @post = current_user.posts.build
  end

  def create
    redirect_to(root_url) unless logged_in?
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
    @comments = @post.comments.all 
    @comment  = current_user.comments.build if logged_in?
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
    set_post
    redirect_to(root_url) unless logged_in? && current_user == User.find(@post.user_id)
  end

  def del_auth_check
    set_post
    redirect_to(root_url) unless logged_in? && (current_user.admin? || 
                                                current_user == User.find(@post.user_id))
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
