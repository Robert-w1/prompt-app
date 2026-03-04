class CreateChatProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_projects do |t|
      t.references :chat, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
    # so we don't have duplicate chats in the project
    add_index :chat_projects, [:chat_id, :project_id], unique: true
  end
end
