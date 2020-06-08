module RailsJwtAuth
  class SessionsController < ApplicationController
    include ParamsHelper
    include RenderHelper

    def create
      user = find_user

      if !user
        render_422 session: [{error: :invalid_session}]
      elsif user.respond_to?('confirmed?') && !user.confirmed?
        render_422 session: [{error: :unconfirmed}]
      elsif user.authentication?(session_create_params[:password])
        render_session_create generate_jwt(user), user
      else
        render_422 session: [user.unauthenticated_error]
      end
    end

    def destroy
      return render_404 unless RailsJwtAuth.simultaneous_sessions > 0

      authenticate!
      payload = JwtManager.decode_from_request(request)&.first
      current_user.destroy_auth_token payload['auth_token']
      render json: {message: "Logout successfully"}, status: :ok
    end

    private

    def generate_jwt(user)
      JwtManager.encode(user.to_token_payload(request))
    end

    def find_user
      auth_field = RailsJwtAuth.auth_field_name!
      RailsJwtAuth.model.where(auth_field => session_create_params[auth_field]).first
    end
  end
end
