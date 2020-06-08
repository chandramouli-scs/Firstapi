module RailsJwtAuth
  module ParamsHelper
    private
    
    def registration_create_params
      params.require(RailsJwtAuth.model_name.underscore).permit(
        RailsJwtAuth.auth_field_name, :password, :password_confirmation
      )
    end

    def confirmation_create_params
      params.require(:confirmation).permit(RailsJwtAuth.email_field_name)
    end

    def session_create_params
      params.require(:session).permit(RailsJwtAuth.auth_field_name, :password)
    end

    def password_create_params
      params.require(:password).permit(RailsJwtAuth.email_field_name)
    end

    def password_update_params
      params.require(:password).permit(:password, :password_confirmation)
    end

    def invitation_create_params
      params.require(:invitation).permit(RailsJwtAuth.email_field_name)
    end

    def invitation_update_params
      params.require(:invitation).permit(:password, :password_confirmation)
    end
  end
end
