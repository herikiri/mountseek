CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/" 
	config.permissions = 0666
	config.storage = :fog
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJA24JJUKFLQDIC5Q',                        # required
    :aws_secret_access_key  => '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'
  }
  config.fog_directory  = "mountseek"                    # required
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
