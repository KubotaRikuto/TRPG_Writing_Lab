class Admin::WritingsController < ApplicationController
  # ログイン確認
  before_action :authenticate_admin!

  def index
    @writings = Writing.page(params[:page])
    @tag_list = Tag.all
  end

  def show
    @writing = Writing.find(params[:id])
    @writing_tags = @writing.tags
    @tag_list = Tag.all
  end

  def update
    @writing = Writing.find(params[:id])

    if @writing.update(writing_params)
      flash[:notice] = "公開情報が更新されました。"
      redirect_to admin_writing_path(@writing.id)
    else
      @writing = Writing.find(params[:id])
      flash[:notice] = "公開情報の更新に失敗しました。"
      render :show
    end
  end

  def word_search
    @tag_list = Tag.all
    keyword = params[:word]
    @writings = Writing.joins(:member, :trpg_rule).search(keyword)
    if @writings.count > 0 && keyword.present?
      flash.now[:notice] = "「#{keyword}」の検索結果 - #{@writings.count}件"
    else
      flash[:alert] = "「#{keyword}」に該当する作品は見つかりませんでした。別の検索ワードをお試しください。"
      redirect_to admin_writings_path
    end
  end

  def tag_search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @writings = @tag.writings.page(params[:page]).per(10)
    if @writings.count > 0
      flash.now[:notice] = "「#{@tag.tag_name}」の検索結果 - #{@writings.count}件"
    else
      flash[:alert] = "「#{@tag.tag_name}」に該当する作品は見つかりませんでした。別の検索タグをお試しください。"
      redirect_to admin_writings_path
    end
  end

  private

  def writing_params
    params.require(:writing).permit(:is_public)
  end
end
