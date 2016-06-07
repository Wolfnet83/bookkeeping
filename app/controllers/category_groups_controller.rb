class CategoryGroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @category_groups = CategoryGroup.all
  end

  def new
    @category_group = CategoryGroup.new
  end

  def create
    @category_group = CategoryGroup.new(permitted_params)
    if @category_group.valid?
      @category_group.save
      redirect_to category_groups_path, notice: t('category.created')
    else
      flash[:alert] = t('category.not_created')
      render "new"
    end
  end

  def edit
    @category_group = CategoryGroup.find_by_id(params[:id])
  end

  def update
    @category_group = CategoryGroup.find_by_id(params[:id])
    @category_group.set_default_category if params[:default_category]
    if @category_group.update_attributes(permitted_params)
      redirect_to category_groups_path, notice: t('category.updated')
    else
      flash[:alert] = t('category.not_updated')
      render 'edit'
    end
  end

  def destroy
    @category_group = CategoryGroup.find_by_id(params[:id])
    @category_group.destroy
    redirect_to category_groups_path, notice: t('category.deleted')
  end

  private
  def permitted_params
    params[:category_group].permit(:name)
  end
end
