class Identity < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider


  ## TODO : refactor this code, take a look -> http://guides.rubyonrails.org/active_record_querying.html#find-or-create-by
  def self.find_for_oauth(auth)
  	identity = find_or_create_by(provider: auth.provider, uid: auth.uid)
  end
end
