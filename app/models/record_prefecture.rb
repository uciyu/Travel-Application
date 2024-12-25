class RecordPrefecture < ApplicationRecord
  belongs_to :record
  belongs_to :prefecture

  # 同じidでの組み合わせは1つだけ
  validates :record_id, uniqueness: { scope: :prefecture_id }
end
