class Video < ActiveRecord::Base
	#mount_uploader :name, VideoUploader

  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i

  before_create -> do
    uid = link.match(YT_LINK_FORMAT)

    self.uid = uid[2] if uid && uid[2]

    if self.uid.to_s.length != 11
      self.errors.add(:link, 'is invalid.')
      false
    end

    get_additional_info if uid
    
  end


  #validates :link, presence: true, format: YT_LINK_FORMAT

  def self.yt_client(session) 
    @@client = YouTubeIt::OAuth2Client.new(
            client_access_token: session[0], 
            client_refresh_token: session[2], 
            client_id: "886645300352-eqrmcrbjv1hkraj3eu3heg4u14cdqbk0.apps.googleusercontent.com", 
            client_secret: "0xAKK6ObS9ljy1NT9Fsq1934", 
            dev_key: "AIzaSyAq1ngA0WP73hu-3Mdr6dVpA5-nPmT5kjo", 
            expires_at: session[1])
  end


  private

  def get_additional_info
    begin
      video = @@client.video_by(uid)
      self.title = video.title
      self.description = video.description
      self.duration = parse_duration(video.duration)
      self.author = video.author.name
      unless video.rating.nil?
        self.likes = video.rating.likes 
        self.dislikes = video.rating.dislikes
      end
    rescue
      self.title = '' ; self.duration = '00:00:00' ; self.author = '' ; self.likes = 0 ; self.dislikes = 0
    end
  end

  def parse_duration(d)
    hr = (d / 3600).floor
    min = ((d - (hr * 3600)) / 60).floor
    sec = (d - (hr * 3600) - (min * 60)).floor

    hr = '0' + hr.to_s if hr.to_i < 10
    min = '0' + min.to_s if min.to_i < 10
    sec = '0' + sec.to_s if sec.to_i < 10

    hr.to_s + ':' + min.to_s + ':' + sec.to_s
  end
end
