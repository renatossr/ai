class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.integer :company_id
      t.string :name
      t.string :original_name
      t.string :period
      t.integer :month
      t.integer :year
      t.integer :value
      t.integer :footnote
      t.string :pdf_file_name
      t.integer :pdf_page
      t.string :processed_document

      t.timestamps
    end
  end
end
