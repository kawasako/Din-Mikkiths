class User < AWS::Record::HashModel
  include ActiveModel::Conversion             # モデルオブジェクトとしての振る舞い
  include ActiveModel::Validations            # バリデーション機能
  extend ActiveModel::Naming                  # form_forで必要
  extend ActiveModel::Translation             # 日本語の属性名

  string_attr :id, :hash_key => true
  string_attr :password
  string_attr :secret_key
  string_attr :has_records, :set => true
  timestamps
end