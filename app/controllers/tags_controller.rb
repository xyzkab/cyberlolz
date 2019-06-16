class TagsController < ApplicationController

  def index
    @tags = Tag.order(created_at: :desc).page(params[:page])
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(update_params)
    
    if @tag.save
      flash[:success] = "tag added!"
      redirect_to @tag
    else
      render 'new'
    end
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(update_params)
      flash[:success] = "tag updated!"
      redirect_to @tag
    else
      render 'edit'
    end
  end

  private
  def update_params
    params.require(:tag).permit(:name, :description)
  end
end
