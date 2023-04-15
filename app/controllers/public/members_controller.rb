class Public::MembersController < ApplicationController
  # ログイン確認
  before_action :authenticate_member!
  # ゲストユーザID編集・削除不可
  before_action :check_guest, only:[ :update, :withdrawl]
  # helper_method :current_sign_in_at, :last_sign_in_at

  def index
    @members = Member.active.page(params[:page])
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
      if @member.update!(member_params)
        flash[:notice] = "プロフィールを変更しました"
        redirect_to member_path(@member.id)
      else
        flash[:notice] = "プロフィールの変更に失敗しました"
        render :edit
      end
  end

  # 退会処理
  def withdrawl
    @member = current_member
    @member.update(is_deleted: true)
    # 退会後はsessionIDのresetを実行
    reset_session
    redirect_to root_path
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :introduction, :profile_image, :is_deleted)
  end

  # ログイン日時メソッド
  # def current_sign_in_at
  #   current_member.current_sign_in_at if current_member
  # end

  # def last_sign_in_at
  #   current_member.last_sign_in_at if current_member
  # end
end
