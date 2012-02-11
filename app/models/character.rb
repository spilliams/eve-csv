class Character < ActiveRecord::Base
  belongs_to :user
  
  attr_protected :user_id, :name, :character_id
  
  validates_presence_of :name, :character_id, :user
  validate :character_exists, :on => :create
  validate :user_owns_character, :on => :create
  
private
  
  def character_exists
    
  end
  
  def user_owns_character
    
  end
  
end
