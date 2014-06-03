class Video < ActiveRecord::Base
	mount_uploader :name, VideoUploader
end
