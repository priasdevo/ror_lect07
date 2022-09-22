class Student < ApplicationRecord
	has_many :Score, dependent: :delete_all
end
