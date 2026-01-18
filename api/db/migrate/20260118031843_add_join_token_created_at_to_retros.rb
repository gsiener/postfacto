class AddJoinTokenCreatedAtToRetros < ActiveRecord::Migration[8.1]
  def change
    add_column :retros, :join_token_created_at, :datetime
  end
end
