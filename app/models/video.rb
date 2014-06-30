class Video < ActiveRecord::Base
	mount_uploader :name, VideoUploader

	def self.yt_session
    #@yt_session ||= YouTubeIt::Client.new(:username => "heriynt89" , :password => "As4ln3b4kGoogle" , :dev_key => "AIzaSyAq1ngA0WP73hu-3Mdr6dVpA5-nPmT5kjo")    
  end

  def self.token_form(params, nexturl)
    yt_session.upload_token(video_options(params), nexturl)
  end

  private
    def self.video_options(params)
      opts = {:title => params[:title],
             :description => params[:description],
             :category => "People",
             :keywords => ["test"]}
    end


end
