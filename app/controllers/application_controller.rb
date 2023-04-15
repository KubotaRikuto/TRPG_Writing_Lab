class ApplicationController < ActionController::Base

  # ゲストユーザーの編集・削除不可
  def check_guest
    email = current_member&.email || params[:member][:email].downcase
    if email == 'guest@example.com'
      if member_signed_in?
        redirect_to member_path(current_member.id), alert: 'ゲストユーザの編集・削除はできません。'
      else
        redirect_to new_member_session_path, alert: 'ゲストユーザのパスワード変更はできません。'
      end
    end
  end
end
