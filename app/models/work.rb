class Work < ApplicationRecord

  # --- バリデーション ---
  validates :title, presence: { message: "タイトルを記入していません。"}
  #-----------------

  # --- association ---
  belongs_to :member
  has_many :post_comments
  has_many :post_likes
  #-----------------

  # --- Active Storage ---
  has_one_attached :work_image
  #-----------------

  # 作品サムネイル画像のサイズ変更
  def get_thumbnail_image(width,height)
    unless work_image.attached?
      file_path = Rails.root.join('app/assets/images/l_e_others_501.jpg')
      work_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    work_image.variant(resize_to_limit: [width, height]).processed
  end

  # 平均プレイ時間
  def avg_play_time
    (max_play_time + min_play_time)/2
  end

  # 平均プレイ人数

end
