class User < ApplicationRecord

	include RailsJwtAuth::Authenticatable
    include RailsJwtAuth::Recoverable
    include RailsJwtAuth::Trackable
    include RailsJwtAuth::Confirmable
    include RailsJwtAuth::Invitable
  	include RailsJwtAuth::Lockable
    
    validates :email, presence: true,
                    uniqueness: true,
                    format: URI::MailTo::EMAIL_REGEXP


end
