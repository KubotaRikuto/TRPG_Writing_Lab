class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  helper_method :current_sign_in_at, :last_sign_in_at

  def index
  end

  def show
    @member = Member.find(params[:id])
    @last_sign_in = @member.last_sign_in_at
  end

  def edit
  end

  def update
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :introduction, :is_deleted, :last_sign_in_at)
  end
  def current_sign_in_at
    current_member.current_sign_in_at if current_member
  end

  def last_sign_in_at
    current_member.last_sign_in_at if current_member
  end
end
