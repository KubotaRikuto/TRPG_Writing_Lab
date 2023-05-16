class Tag < ApplicationRecord
  # --- association ---
  has_many :writing_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :writings, through: :writing_tags
  # ------
  # --- vallidates ---
  validates :tag_name, uniqueness: true, presence: true
  # ------
end
