class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string :job_title
      t.string :company
      t.string :indeed_url
      t.string :job_key

      t.timestamps
    end
  end
end
