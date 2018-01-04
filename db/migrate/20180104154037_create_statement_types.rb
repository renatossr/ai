class CreateStatementTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :statement_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
