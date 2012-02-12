class CustomDevise::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    current_user.status = params[:status]
    current_character = Character.find_by_name(params[:current_character])
    current_user.current_character_id = current_character.id unless current_character.nil?
    current_user.save

    respond_with resource, :location => after_sign_in_path_for(resource)
  end
  
  # DELETE /resource/sign_out
  def destroy
    current_user.status = nil
    current_user.current_character_id = nil
    current_user.save
    
    signed_in = signed_in?(resource_name)
    redirect_path = after_sign_out_path_for(resource_name)
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :signed_out if signed_in

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.any(*navigational_formats) { redirect_to redirect_path }
      format.all do
        method = "to_#{request_format}"
        text = {}.respond_to?(method) ? {}.send(method) : ""
        render :text => text, :status => :ok
      end
    end
  end
end