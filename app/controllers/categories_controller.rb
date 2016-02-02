class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories.order(category_type: :desc)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.new(permitted_params)
    params[:category][:category_type] == '1' ? @category.category_type = INCOME : @category.category_type = EXPENSE
    if @category.valid?
      @category.save
      redirect_to categories_path, notice: "Category successfully created"
    else
      flash[:alert] = "Category doesn't created"
      render "new"
    end
  end

  def edit
    @category = current_user.categories.find_by_id(params[:id])
  end

  def update
    @category = current_user.categories.find_by_id(params[:id])
    if @category.update_attributes(permitted_params)
      redirect_to categories_path, notice: "Category successfully updated"
    else
      flash[:alert] = "Category doesn't updated"
      render 'edit'
    end
  end

  def destroy
    @category = current_user.categories.find_by_id(params[:id])
    @category.destroy
    redirect_to categories_path, notice: "Category successfully deleted"
  end

  private
  def permitted_params
    params[:category].permit(:name, :category_type)
  end
end
