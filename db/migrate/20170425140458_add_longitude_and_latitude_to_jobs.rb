class AddLongitudeAndLatitudeToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :longitude, :integer
    add_column :jobs, :latitude, :integer
  end
end
