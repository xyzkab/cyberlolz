class CategoriesController < ApplicationController

  def index
    @categories = Category.order(created_at: :desc).page(params[:page])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(update_params)
    
    if @category.save
      flash[:success] = "category added!"
      redirect_to @category
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(update_params)
      flash[:success] = "category updated!"
      redirect_to @category
    else
      render 'edit'
    end
  end

  private
  def update_params
    params.require(:category).permit(:name, :description)
  end
end
