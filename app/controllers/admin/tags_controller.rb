class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "タグを投稿しました。"
      @tags = Tag.all
      redirect_to admin_tags_path
    else
      flash[:notice] = "タグの投稿に失敗しました。"
      @tags = Tag.all
      render :index
    end
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      flash[:notice] = "タグを編集しました。"
      redirect_to admin_tags_path
    else
      flash[:notice] = "タグの編集に失敗しました。"
      @tags = Tag.find(params[:id])
      render :edit
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    flash[:notice] = "タグを削除しました。"
    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end