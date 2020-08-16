class Task < ApplicationRecord
  def self.csv_attributes
    ["name", "description", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{ |attr| task.send(attr) }
      end
    end
  end

  def self.import(file)
    # CSV.foreachでCSVファイルを一行ずつ読み込む headers: trueで一行目をヘッダーとして無視させる
    CSV.foreach(file.path, headers: true) do |row|
      # メソッドがself.なのでnewはTask.newと同じ
      task = new
      # slice(*csv_attributes)はslice('name', 'description', 'created_at', 'updated_at')と同義
      task.attributes = row.to_hash.slice(*csv_attributes)
      task.save!
    end
  end

  has_one_attached :image

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
