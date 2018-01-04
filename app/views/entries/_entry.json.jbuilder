json.extract! entry, :id, :company_id, :name, :original_name, :period, :month, :year, :value, :footnote, :pdf_file_name, :pdf_page, :processed_document, :created_at, :updated_at
json.url entry_url(entry, format: :json)
