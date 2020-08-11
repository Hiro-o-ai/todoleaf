class Task < ApplicationRecord
  def self.rensackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransackable_associtations(auth_object = nil)
    []
  end
  
  # before_validation :set_nameless_name
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validate :validate_name_not_including_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc)}

  private

  # もしもnameがnilか空白の場合に名前なしを代入させるメソッド
  # def set_nameless_name
  #   self.name = "名前なし" if name.blank?
  # end

  # &.ボッチ演算子　nilの場合にNoMethodErrorではなくnilを返す、つまり検証を通ることになる
  def validate_name_not_including_comma
    errors.add(:name, "にカンマを含めることはできません") if name&.include?(',')
  end
end
