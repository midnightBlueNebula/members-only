class CommentsController < ApplicationController
  
  before_action :set_comment , except: [:create]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def create
    redirect_to(root_url) unless logged_in?
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment sended."
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Failed to send Comment."
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    render template: "shared/_comment-form.html.erb", :locals => { id_post: @comment.post_id }
  end

  def update
    @comment.update_attributes(comment_params)
    if @comment.save
      flash[:success] = "Comment sended."
      redirect_to post_path(@comment.post_id) 
    else
      flash[:error] = "Failed to send Comment."
      redirect_to post_path(@comment.post_id) 
    end
  end 

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def correct_user
    redirect_to(root_url) unless logged_in? && (current_user.id == @comment.user_id || current_user.admin?)
  end

end
