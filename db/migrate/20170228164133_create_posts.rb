class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :messages, id: false do |t|
      t.integer :id
      t.string :board, null: false
      t.string :name
      t.string :email
      t.string :subject
      t.string :content
      t.integer :thread, null: false
      t.boolean :op, null: false, default: false
      t.timestamp :timestamp
      t.primary_key :id
    end

    # add_index :messagens, %i[id board], unique: true
  end
end
