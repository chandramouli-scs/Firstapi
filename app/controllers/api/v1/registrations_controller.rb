class Api::V1::RegistrationsController < Devise::RegistrationsController

	def create
		user = User.new(user_params)
		if user.save
			render json: {status:"OK", message:"Sign up successfully", data:user}, status: :ok
		else
			render json: {status:"Error", message:"Error Please provide all inputs", data:user.errors}, status: :unprocessable_entity
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end