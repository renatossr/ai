class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.integer :statement_line_id
      t.decimal :value

      t.timestamps
    end
  end
end
