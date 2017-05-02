class AddColumnUrlToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :url, :string
  end
end
