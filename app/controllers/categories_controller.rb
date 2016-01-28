class CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new
    @category.update_attributes(permitted_params)
    if @category.valid?
      @category.save
      redirect_to categories_path, notice: "Category successfully created"
    else
      flash[:alert] = "Category doesn't created"
      render "new"
    end
  end

  def destroy
    @category = Category.find_by_id(params[:id])
    @category.destroy
    redirect_to categories_path, notice: "Category successfully deleted"
  end

  private
  def permitted_params
    params[:category].permit(:name, :funds)
  end
end
