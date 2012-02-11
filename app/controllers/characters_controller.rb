class CharactersController < ApplicationController
  before_filter do
    # ASK can we look at other players' character lists?
    if params[:user_id]
      @user = User.find(params[:user_id])
    # ASK can we look at all characters or just our own?
    elsif current_user
      @user = current_user
    end
  end
  
  # GET /users/1/characters/import
  def import
    @characters = @user.api.account.characters.characters
  end
  
  # POST /users/1/characters
  # POST /users/1/characters.json
  def bulk_create
    ok = true
    Character.transaction do
      i=0
      params[:name].each do |name|
        if params[:import][i]
          c = Character.new(:user => current_user)
          c.name = params[:name][i]
          c.character_id = params[:character_id][i]
          ok = false unless c.save
        end
        i=i+1
      end
    end
    
    if ok
      respond_to do |format|
        format.html { redirect_to user_characters_path, notice: 'Characters successfully imported.' }
      end
    else
      redirect_to user_characters_path(current_user), :alert => "There was an error importing characters"
    end
  end
  
  # GET /characters
  # GET /characters.json
  def index
    if @user
      @characters = @user.characters
    # ASK can we look at all characters or just our own?
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
