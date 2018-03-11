class Category < ApplicationRecord
	  # 如果分類下已有餐廳，就不允許刪除分類（刪除時拋出 Error）
  has_many :restaurants, dependent: :restrict_with_error


	validates_presence_of :name #確保分類名稱必填

    validates_uniqueness_of :name #分類名稱驗證不重複

end
