class CreateWalkScores < ActiveRecord::Migration[5.0]
  def change
    create_table :walk_scores do |t|
      t.integer :job_id
      t.integer :walking_score
      t.string :description
      t.integer :transit_score
      t.integer :biking_score

      t.timestamps
    end
  end
end
