class Public::MembersController < ApplicationController
  # ログイン確認
  before_action :authenticate_member!
  # ゲストユーザID編集・削除不可
  before_action :check_guest, only:[:update, :destroy]
  # 非公開投稿への画面遷移不可
  before_action :require_active_member, only: [:show, :edit]

  def index
    @members = Member.active.page(params[:page])

  end

  def show
    @member = Member.find(params[:id])
    @writings = @member.writings.published.order(created_at: :desc).limit(5)
    @like_writings = @member.writing_likes.includes(:writing).where(writings: { is_public: true }).order(created_at: :desc).limit(5).map(&:writing)
  end

  def edit
    @member = current_member
  end

  def writings
    @member = Member.find(params[:id])
    @writings = @member.writings.published.order(created_at: :desc).page(params[:page])
  end

  def like_writings
    @member = Member.find(params[:id])
    @like_writings = @member.writing_likes.includes(:writing).where(writings: { is_public: true }).order(created_at: :desc).map(&:writing)
    @like_writings = Kaminari.paginate_array(@like_writings).page(params[:page])
  end

  def unsubscribe
    @member = current_member
  end

  def update
    @member = current_member
      if @member.update!(member_params)
        flash[:notice] = "プロフィールを変更しました"
        redirect_to member_path(@member.id)
      else
        flash[:alert] = "プロフィールの変更に失敗しました"
        render :edit
      end
  end

  def destroy
    @member = current_member
    if @member.destroy
      # 退会後はsessionIDのresetを実行
      reset_session
      redirect_to root_path
    else
      @member = current_member
      flash[:alert] = "アカウントの削除に失敗しました"
      render :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :introduction, :favorite_trpg, :profile_image, :is_deleted)
  end

  def require_active_member
    member = Member.find(params[:id])
    if member.is_deleted == true
      redirect_to members_path
    end
  end
end
