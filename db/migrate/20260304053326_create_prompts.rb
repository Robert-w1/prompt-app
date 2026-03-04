class CreatePrompts < ActiveRecord::Migration[7.1]
  def change
    create_table :prompts do |t|
      t.references :message, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
