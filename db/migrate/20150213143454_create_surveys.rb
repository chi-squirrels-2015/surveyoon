class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
      t.string :random_code
      t.integer :times_taken, default: 0
      t.belongs_to :creator

      t.timestamps
    end
  end
end
