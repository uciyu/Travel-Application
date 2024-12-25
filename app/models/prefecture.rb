class Prefecture < ApplicationRecord
  has_many :record_prefectures, dependent: :destroy
end
