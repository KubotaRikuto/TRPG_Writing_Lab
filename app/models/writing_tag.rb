class WritingTag < ApplicationRecord
  # --- association ---
  belongs_to :writing
  belongs_to :tag
  # ------

  # --- validation  ---
  validates :writing_id, presence: true
  validates :tag_id, presence: true
  # ------
end
