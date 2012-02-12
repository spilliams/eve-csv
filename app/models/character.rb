class Character < ActiveRecord::Base
  belongs_to :user
  
  attr_protected :user_id, :name, :character_id
  
  validates_presence_of :name, :character_id, :user
  validates_uniqueness_of :character_id
  # we don't *really* need to validate api stuff since
  # characters are only created through the import view
  
  def to_s
    name
  end
  
  def portrait_url(size=nil)
    size = 64 if size.nil? or size.blank? or size < 64
    size = 512 if size > 512
    "http://image.eveonline.com/Character/#{character_id}_#{size}.jpg"
  end
  
  def api
    user.api
  end
end
