class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # --- Devise機能 ---
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  #-----------------

  # --- Active Storage ---
  has_one_attached :profile_image
  #-----------------

  # --- スコープ ---
  # 退会ユーザーは非表示
  scope :active, -> { where(is_deleted: false) }
  #-----------------


  # --- カスタムメソッド ---
  # プロファイル画像のサイズ変更
  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

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
