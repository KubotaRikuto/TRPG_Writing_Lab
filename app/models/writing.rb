class Writing < ApplicationRecord

  # --- association ---
  belongs_to :member
  has_many :writing_comments, dependent: :destroy
  has_many :writing_likes, dependent: :destroy
  has_many :writing_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  #-----------------

  # --- validation  ---
  validates :title, presence: { message: "タイトルを記入していません。"}
  #-----------------

  # --- Active Storage ---
  has_one_attached :writing_image
  #-----------------

  # 作品サムネイル画像のサイズ変更
  def get_thumbnail_image(width,height)
    unless writing_image.attached?
      file_path = Rails.root.join('app/assets/images/l_e_others_501.jpg')
      writing_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    writing_image.variant(resize_to_limit: [width, height]).processed
  end

  # 平均プレイ時間
  def avg_play_time
    (max_play_time + min_play_time)/2
  end

  # 平均プレイ人数

end
