class AddMathScoreToJobsTest < ActiveRecord::Migration
  def change
    add_column :jobs_tests, :math_score, :integer
  end
end
