class CreateSavedJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :saved_jobs do |t|
      t.integer :job_id
      t.integer :user_id

      t.timestamps
    end
  end
end
