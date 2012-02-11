class CharactersController < ApplicationController
  # GET /users/1/characters/import
  def import
    @characters = current_user.api.account.characters.characters
  end
  
  # POST /users/1/characters
  # POST /users/1/characters.json
  def bulk_create
    current_user.characters.destroy_all
    current_user.character_id = nil
    current_user.save
    
    characters = []
    ok = true
    Character.transaction do
      i=0
      params[:name].each do |name|
        if params[:import] and params[:import][i]
          c = Character.new(:user => current_user)
          c.name = params[:name][i]
          c.character_id = params[:character_id][i]
          ok = false unless c.save
          characters << c
        end
        i=i+1
      end
    end
    
    unless characters.empty?
      default = Character.where(:character_id => params[:default]).first
      default = characters.first unless default # user didn't select a default
      current_user.character_id = default.id
      current_user.save
    end
    
    if ok
      respond_to do |format|
        if characters.empty?
          notice = "No characters imported."
        else
          notice = 'Characters successfully imported.'
        end
        format.html { redirect_to user_characters_path, notice: notice }
      end
    else
      redirect_to user_characters_path(current_user), :alert => "There was an error importing some or all of the characters."
    end
  end
  
  # GET /characters
  # GET /characters.json
  def index
    if params[:user_id]
      @characters = User.find(params[:user_id]).characters
    else
      @characters = Character.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @characters }
    end
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @character = Character.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character }
    end
  end

  # DELETE /users/1/characters/1
  # DELETE /users/1/characters/1.json
  def destroy
    @character = Character.find(params[:id])
    @character.destroy

    respond_to do |format|
      format.html { redirect_to characters_url }
      format.json { head :ok }
    end
  end
end
