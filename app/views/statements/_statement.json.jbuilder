json.extract! statement, :id, :company_id, :statement_type_id, :period, :month, :year, :pdf_file_name, :pdf_page, :processed_document, :created_at, :updated_at
json.url statement_url(statement, format: :json)
