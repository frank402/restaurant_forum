class Category < ApplicationRecord
	has_many :restaurants

	validates_presence_of :name #確保分類名稱必填
  

    validates_uniqueness_of :name #分類名稱驗證不重複

end
