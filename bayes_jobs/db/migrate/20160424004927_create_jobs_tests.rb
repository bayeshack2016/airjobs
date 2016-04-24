class CreateJobsTests < ActiveRecord::Migration
  def change
    create_table :jobs_tests do |t|
      t.string :title
      t.string :skill
      t.string :state

      t.timestamps null: false
    end
  end
end
