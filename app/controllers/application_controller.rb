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

  # ログインユーザー以外の情報編集・削除不可
  def is_matching_login_user
    @writing = Writing.find(params[:id])
    user_id = @writing.member.id
    login_user_id = current_member.id
    if (user_id != login_user_id )
      redirect_to writings_path
    end
  end

end
