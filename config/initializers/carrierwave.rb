CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/" 
	config.permissions = 0666
	config.storage = :fog
  config.fog_credentials = {
    :provider               => "AWS",                        # required
    :aws_access_key_id      => "AKIAJEFS3V2LQVXUVHKQ",                        # required
    :aws_secret_access_key  => "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",                        # required
    :region                 => "us-west-2"          # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = "mountseek"                    # required
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end