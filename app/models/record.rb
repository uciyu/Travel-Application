class Record < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  has_many :record_prefectures, dependent: :destroy
  has_many :prefectures, through: :record_prefectures

  belongs_to :user
end
