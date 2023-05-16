class Admin::TagsController < ApplicationController

  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @tag =Tag.new(tag_params)
    @tag.admin_created = true
    if @tag.save!
      flash[:notice] = "タグを新しく投稿しました。"
      redirect_to admin_tags_path
    else
      @tag = Tag.new
      @tags = Tag.all
      flash[:notice] = "タグ投稿に失敗しました。"
      render :index
    end
  end

  def update
    @tag =Tag.find(params[:id])
    if @tag.update!(tag_params)
      flash[:notice] = "タグを更新しました。"
      redirect_to admin_tags_path
    else
      @tag = Tag.find(params[:id])
      flash[:notice] = "タグの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      flash[:notice] = "タグを削除しました。"
      redirect_to admin_tags_path
    else
      @tag = Tag.new
      @tags =Tag.all
      flash[:notice] = "タグの削除に失敗しました。"
      render :index
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name)
  end
end
