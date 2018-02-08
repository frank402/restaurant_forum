class Category < ApplicationRecord
	has_many :restaurants

	validates_presence_of :name
  
    has_many :restaurants
end
