class Admin::MembersController < ApplicationController
  # ログイン確認
  before_action :authenticate_admin!

  def index
    @members = Member.page(params[:page])
  end

  def show
    @member = Member.find(params[:id])
    @writings = @member.writings.order(created_at: :desc).limit(5)
    @like_writings = @member.writing_likes.order(created_at: :desc).limit(5).map(&:writing)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def writings
    @member = Member.find(params[:id])
    @writings = @member.writings.order(created_at: :desc).page(params[:page])
  end

  def like_writings
    @member = Member.find(params[:id])
    @like_writings = @member.writing_likes.order(created_at: :desc).map(&:writing)
    @like_writings = Kaminari.paginate_array(@like_writings).page(params[:page])
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
