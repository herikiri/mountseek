class Horse < ActiveRecord::Base
	belongs_to :package
	belongs_to :user
end
