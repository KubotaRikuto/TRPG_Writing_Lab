class Admin::MembersController < ApplicationController
  # ログイン確認
  before_action :authenticate_admin!

  def index
    @members = Member.page(params[:page])
  end

  def show
    @member = Member.find(params[:id])
    @writings = @member.writings.page(params[:page])
    @like_writings = @member.writing_likes.map(&:writing)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
      if @member.update!(member_params)
        flash[:notice] = "プロフィールを変更しました"
        redirect_to admin_member_path(@member.id)
      else
        flash[:alert] = "プロフィールの変更に失敗しました"
        render :edit
      end
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :introduction, :favorite_trpg, :profile_image, :is_deleted)
  end
end
