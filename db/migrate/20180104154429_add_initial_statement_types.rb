class AddInitialStatementTypes < ActiveRecord::Migration[5.1]
  def up
    StatementType.create(id: 1, name: "Income Statement")
    StatementType.create(id: 2, name: "Balance Sheet")
    StatementType.create(id: 3, name: "Cash Flow Statement")
  end
  
  def down
    StatementType.delete_all
  end
end
