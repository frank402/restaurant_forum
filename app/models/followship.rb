class Followship < ApplicationRecord
  # 「使用者追蹤使用者」的 self-referential relationships 設定
  # 由於 :following 指向 User Model, Rails 無法自動推論
  # 使用 :class_name 告知對應的 Model 名稱
  belongs_to :user
  belongs_to :following, class_name: 'User'
  
  # 這個驗證透過對 Model 的資料表執行一條 SQL 查詢語句，搜尋是否已經有同樣數值的紀錄存在。:scope 選項可以用另一個屬性來限制唯一性：
  validates :following_id, uniqueness: { scope: :user_id }
end
