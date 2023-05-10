class TrpgRule < ApplicationRecord
  # --- association ---
  has_many :writings, dependent: :destroy
  # ------
end
