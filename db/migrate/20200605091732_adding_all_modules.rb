class AddingAllModules < ActiveRecord::Migration[6.0]
  def change
		add_column :users, :invitation_token, :string
  		add_column :users, :invitation_sent_at, :datetime 
  		add_column :users, :invitation_accepted_at, :datetime 
  		add_column :users, :invitation_created_at, :datetime

  		add_column :users, :failed_attempts, :integer
  		add_column :users, :unlock_token, :string
  		add_column :users, :first_failed_attempt_at, :datetime
  		add_column :users, :locked_at, :datetime

	end
end

