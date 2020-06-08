module RailsJwtAuth
  module RenderHelper

    #render for user login session
    def render_session_create(jwt, user)
      auth_field = RailsJwtAuth.auth_field_name
      render json: {session: {jwt: jwt, auth_field => user[auth_field]}, message: "successfully loged-in"}, status: 201
    end

    #render for user registration
    def render_registration(resource)
      render json: {data:{email: "#{resource.email}"}, message:"please confirm your account, confirm-email has sent to your email"}, root: true, status: 201
    end

    #render for status 204
    def render_204
      render json: {}, status: 204
    end

    #render for user password update
    def render_password_update
      render json: {message: "Your password is updated, please log-in"}, status: :ok
    end

    #render for user password create
    def render_password_create
      render json: {message: "Please set your new password using mail that we have sent, please log-in"}, status: :ok
    end

    #render for resending confirm account for existing user
    def render_confirm_update
      render json: {message: "Your account is confirmed, Please log in"}, status: :ok
    end

    #render for confirm account for new user
    def render_confirm_create(email)
      render json: {message: "Confirmation mail was sent to #{email.email} "}, status: :ok
    end

    #render for sending invitations
    def render_invi
      render json: {message: "Invitation successfully sent "}, status: :ok
    end

    #render for unlock account(email)
    def render_unlock_update
      render json: {message: "Your account is unlocked now, please log-in"}, status: :ok
    end

    #render for 404 error
    def render_404
      render json: {}, status: 404
    end

    #render for 422 errors
    def render_422(errors)
      render json: {errors: errors}, status: 422
    end
  end
end
