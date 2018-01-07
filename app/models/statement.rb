class Statement < ApplicationRecord
  belongs_to :company
  belongs_to :statementtype
end
