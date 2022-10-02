class ChangeUrlToProviderId < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :url, :string
    add_column :users, :provider_id, :string
  end
end
