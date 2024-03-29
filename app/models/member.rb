class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # --- Devise機能 ---
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  #-----------------

  # --- association　---
  has_many :writings, dependent: :destroy
  has_many :writing_comments, dependent: :destroy
  has_many :writing_likes, dependent: :destroy
  #-----------------

  # --- validation ---
  validates :name, presence: true, length: { minimum: 1, maximum: 10 }
  #-----------------

  # --- Active Storage ---
  has_one_attached :profile_image
  #-----------------

  # --- scope ---
  # 退会ユーザーは非表示
  scope :active, -> { where(is_deleted: false) }
  #-----------------

  # --- カスタムメソッド ---
  # ゲストログイン
  def self.guest
    find_or_create_by(email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "ゲストプレイヤー"
    end
  end

  # 最終ログイン日
  def last_sign_in_date
    self[:last_sign_in_at].strftime("%Y/%m/%d")
  end

  # プロファイル画像のサイズ変更
  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # いいね総数
  def total_likes
    writings.joins(:writing_likes).count
  end
end
