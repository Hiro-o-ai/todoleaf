class User < ApplicationRecord
  # gem bcryptのインストールが必要
  # 下記コードの記述でカラムに対応しない属性が2つ追加(password属性、password_confimartion属性)
  # 属性には一時的にデータが置かれるだけ
  has_secure_password
end
