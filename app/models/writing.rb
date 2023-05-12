class Writing < ApplicationRecord

  # --- association ---
  belongs_to :member
  belongs_to :trpg_rule
  has_many :writing_comments, dependent: :destroy
  has_many :writing_likes, dependent: :destroy

  # has_many :writing_tags, dependent: :destroy
  # has_many :tags, through: :writing_tags
  #-----------------

  # --- validation  ---
  validates :title, presence: { message: "タイトルを記入していません。"}
  validates :max_play_time, numericality: { only_integer: true, message: '数字を入力してください' }
  validates :min_play_time, numericality: { only_integer: true, message: '数字を入力してください' }
  validates :max_players, numericality: { only_integer: true, message: '数字を入力してください' }
  validates :max_players, numericality: { only_integer: true, message: '数字を入力してください' }
  #-----------------

  # --- Active Storage ---
  has_one_attached :writing_image
  #-----------------

  # --- acts_as_taggable ---
  # acts_as_taggable_on :tags
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

  # tag
  # def save_writings(tags)
  #   current_tags = self.tags.pluck(:name) unless self.tags.nil?
  #   old_tags = current_tags - tags
  #   new_tags = tags - current_tags

  #   old_tags.each do |old_name|
  #     self.tags.delete Tag.find_by(name: old_name)
  #   end

  #   new_tags.each do |new_name|
  #     writing_tag = Tag.find_or_create_by(name: new_name)
  #     self.tags << writing_tag
  #   end
  # end
end
