class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
<<<<<<< HEAD
      t.integer :times_taken, default: 0
=======
>>>>>>> created models, migration, associations, and seed
      t.belongs_to :creator

      t.timestamps
    end
  end
end
