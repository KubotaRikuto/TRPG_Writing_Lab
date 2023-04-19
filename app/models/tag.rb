class Tag < ApplicationRecord
  # --- association　---
  has_many :writing_tags, dependent: :destroy
  has_many :writings, through: :writing_tags
  #-----------------

  # --- validation ---
  validates :name, uniqueness: true, presence: true
  #-----------------
end
