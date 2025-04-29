class Prefecture < ApplicationRecord
  has_many :record_prefectures, dependent: :destroy
  has_many :records, through: :record_prefectures
end
