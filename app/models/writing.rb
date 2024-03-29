class Writing < ApplicationRecord

  # --- association ---
  belongs_to :member
  belongs_to :trpg_rule
  has_many :writing_comments, dependent: :destroy
  has_many :writing_likes, dependent: :destroy

  has_many :writing_tags, dependent: :destroy
  has_many :tags, through: :writing_tags
  #-----------------

  # --- validation  ---
  validates :title, presence: { message: "タイトルを記入していません。"}, length: { minimum: 1, maximum: 30 }
  validates :summary, presence: false, length: { maximum: 50000 }
  validates :max_play_time, numericality: { only_integer: true, message: '数字を入力してください' }
  validates :min_play_time, numericality: { only_integer: true, message: '数字を入力してください' }
  validates :max_players, numericality: { only_integer: true, message: '数字を入力してください' }
  validates :max_players, numericality: { only_integer: true, message: '数字を入力してください' }
  #-----------------
  validate :validate_zip_file_mime_type
  #-----------------

  # --- Active Storage ---
  has_one_attached :writing_image
  has_one_attached :writing_zip
  #-----------------

  # --- scope ---
  # 公開・非公開機能
  scope :published, -> {where(is_public: true)}
  scope :unpublished, -> {where(is_public: false)}
  # ------

  # --- カスタムメソッド ---
  # 作品サムネイル画像のサイズ変更
  def get_thumbnail_image(width,height)
    unless writing_image.attached?
      file_path = Rails.root.join('app/assets/images/AdobeStock_301378170.jpeg')
      writing_image.attach(io: File.open(file_path), filename: 'default-image.jpeg', content_type: 'image/jpeg')
    end
    writing_image.variant(resize_to_limit: [width, height]).processed
  end

  # # アップロードデータ形式設定
  def validate_zip_file_mime_type
    return unless writing_zip.attached?
    if writing_zip.blob.content_type != 'application/zip'
      errors.add(:writing_zip, 'はZIP形式のファイルのみアップロードできます')
      writing_zip.purge # 非許可のファイルを削除する
    end
  end

  # 星レビュー機能
  def getPercent(number)
   if number.present?
     calPercent = number/5.to_f * 100
     percent = calPercent.round
     return percent.to_s
   else
     return 0
   end
  end

 # 最小最大判定
 def min_or_max

 end
  # 平均プレイ時間
  def avg_play_time
    (max_play_time + min_play_time)/2
  end

  # 平均プレイ人数

  # いいね機能
  def liked_by?(member)
    writing_likes.exists?(member_id: member.id)
  end

  # tag機能
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_writing_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_writing_tag
    end
  end

  # 検索機能
  def self.search(search_word)
    Writing.where("writings.title LIKE ? OR members.name LIKE ? OR trpg_rules.title LIKE ?", "%#{search_word}%", "%#{search_word}%", "%#{search_word}%")
  end
end
