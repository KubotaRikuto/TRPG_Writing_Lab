class WritingLike < ApplicationRecord
  # --- association ---
  belongs_to :member
  belongs_to :writing
  # ------
end
