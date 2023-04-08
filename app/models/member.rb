class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates_format_of :password, with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "は半角英数字で入力してください"

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  # 不要なら削除
  # def last_sign_in_time_ago
  #   return "未ログイン" unless last_sign_in_at.present?

  #   time_ago_in_words(last_sign_in_at) + "前"
  # end

  # def last_sign_in_date_or_time
  #   return "未ログイン" unless last_sign_in_at.present?

  #   if last_sign_in_at > 1.day.ago
  #     last_sign_in_at.strftime("%H:%M")
  #   elsif last_sign_in_at > 7.days.ago
  #     last_sign_in_at.strftime("%-m/%-d")
  #   else
  #     last_sign_in_at.strftime("%Y/%-m/%-d")
  #   end
  # end

end
