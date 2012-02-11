class Character < ActiveRecord::Base
  belongs_to :user
  
  attr_protected :user_id, :name, :character_id
  
  validates_presence_of :name, :character_id, :user
  validates_uniqueness_of :character_id
end
