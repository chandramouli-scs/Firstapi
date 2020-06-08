module RailsJwtAuth
  class ConfirmationsController < ApplicationController
    include ParamsHelper
    include RenderHelper

    def create
      user = RailsJwtAuth.model.where(
        email: confirmation_create_params[RailsJwtAuth.email_field_name]
      ).first

      return render_422(email: [{error: :not_found}]) unless user

      user.send_confirmation_instructions ? render_confirm_create(user) : render_422(user.errors.details)
    end

    def update
      return render_404 unless
        params[:id] &&
        (user = RailsJwtAuth.model.where(confirmation_token: params[:id]).first)

      user.confirm! ? render_confirm_update : render_422(user.errors.details)
    end
  end
end
