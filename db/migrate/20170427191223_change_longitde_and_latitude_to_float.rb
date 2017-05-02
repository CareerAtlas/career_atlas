class ChangeLongitdeAndLatitudeToFloat < ActiveRecord::Migration[5.0]
  def change
    change_column :jobs, :longitude, :float
    change_column :jobs, :latitude, :float

  end
end
