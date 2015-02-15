class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
<<<<<<< HEAD
<<<<<<< HEAD
=======
      t.string :random_code
>>>>>>> able to generate unique and safe URL for people to take survey without logging in
      t.integer :times_taken, default: 0
=======
>>>>>>> created models, migration, associations, and seed
      t.belongs_to :creator

      t.timestamps
    end
  end
end
