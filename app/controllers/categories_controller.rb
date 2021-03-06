class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories.order('category_type DESC, name')
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.new(permitted_params)
    params[:category][:category_type] == '1' ? @category.category_type = INCOME : @category.category_type = EXPENSE
    if @category.valid?
      @category.save
      redirect_to categories_path, notice: t('category.created')
    else
      flash[:alert] = t('category.not_created')
      render "new"
    end
  end

  def edit
    @category = current_user.categories.find_by_id(params[:id])
  end

  def update
    @category = current_user.categories.find_by_id(params[:id])
    if @category.update_attributes(permitted_params)
      redirect_to categories_path, notice: t('category.updated')
    else
      flash[:alert] = t('category.not_updated')
      render 'edit'
    end
  end

  def destroy
    @category = current_user.categories.find_by_id(params[:id])
    @category.destroy
    redirect_to categories_path, notice: t('category.deleted')
  end

  private
  def permitted_params
    params[:category].permit(:name, :category_type, :category_group_id)
  end
end
