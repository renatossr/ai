class CreateStatementLines < ActiveRecord::Migration[5.1]
  def change
    create_table :statement_lines do |t|
      t.integer :statement_id
      t.string :name
      t.string :original_name
      t.string :footnote

      t.timestamps
    end
  end
end
