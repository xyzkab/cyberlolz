class PostsController < ApplicationController

  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end

  def create
    
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(update_params)
      flash[:success] = "Post updated!"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    
  end

  def edit
    @post = Post.find(params[:id])
    @categories = Category.all
    @status = PostStatus.all
  end

  def show
    @post = Post.find(params[:id])
  end
  
  private
  def update_params
    params.require(:post).permit(:description, :category_id, :post_status_id)
  end
end
