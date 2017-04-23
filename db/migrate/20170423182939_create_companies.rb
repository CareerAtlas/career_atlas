class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.integer :job_id
      t.string :name
      t.integer :overall_rating
      t.integer :culture_rating
      t.integer :leadership_rating
      t.integer :compensation_rating
      t.integer :opportunity_rating
      t.integer :work_life_balance_rating
      t.integer :recommend_to_friend_rating

      t.timestamps
    end
  end
end
