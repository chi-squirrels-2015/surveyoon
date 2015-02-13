class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :choice
      t.belongs_to :question

      t.timestamps
    end
  end
end
