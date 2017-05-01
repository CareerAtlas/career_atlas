class RemoveUserIdIndeedUrlFromJobs < ActiveRecord::Migration[5.0]
  def change
    remove_column :jobs, :user_id, :integer
    remove_column :jobs, :indeed_url, :string
  end
end
