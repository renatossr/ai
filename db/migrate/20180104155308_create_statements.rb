class CreateStatements < ActiveRecord::Migration[5.1]
  def change
    create_table :statements do |t|
      t.integer :company_id
      t.integer :statement_type_id
      t.string :period
      t.integer :month
      t.integer :year
      t.string :pdf_file_name
      t.integer :pdf_page
      t.string :processed_document

      t.timestamps
    end
  end
end
