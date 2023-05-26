class Admin::WritingsController < ApplicationController
  # ログイン確認
  before_action :authenticate_admin!

  def index
    @writings = Writing.page(params[:page])
  end

  def show
    @writing = Writing.find(params[:id])
    @writing_tags = @writing.tags
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

  private

  def writing_params
    params.require(:writing).permit(:is_public)
  end
end
