class User < ApplicationRecord

	include RailsJwtAuth::Authenticatable
    include RailsJwtAuth::Recoverable
    include RailsJwtAuth::Trackable
    
    validates :email, presence: true,
                    uniqueness: true,
                    format: URI::MailTo::EMAIL_REGEXP


end
