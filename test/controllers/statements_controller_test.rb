require 'test_helper'

class StatementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @statement = statements(:one)
  end

  test "should get index" do
    get statements_url
    assert_response :success
  end

  test "should get new" do
    get new_statement_url
    assert_response :success
  end

  test "should create statement" do
    assert_difference('Statement.count') do
      post statements_url, params: { statement: { company_id: @statement.company_id, month: @statement.month, pdf_file_name: @statement.pdf_file_name, pdf_page: @statement.pdf_page, period: @statement.period, processed_document: @statement.processed_document, statement_type_id: @statement.statement_type_id, string: @statement.string, year: @statement.year } }
    end

    assert_redirected_to statement_url(Statement.last)
  end

  test "should show statement" do
    get statement_url(@statement)
    assert_response :success
  end

  test "should get edit" do
    get edit_statement_url(@statement)
    assert_response :success
  end

  test "should update statement" do
    patch statement_url(@statement), params: { statement: { company_id: @statement.company_id, month: @statement.month, pdf_file_name: @statement.pdf_file_name, pdf_page: @statement.pdf_page, period: @statement.period, processed_document: @statement.processed_document, statement_type_id: @statement.statement_type_id, string: @statement.string, year: @statement.year } }
    assert_redirected_to statement_url(@statement)
  end

  test "should destroy statement" do
    assert_difference('Statement.count', -1) do
      delete statement_url(@statement)
    end

    assert_redirected_to statements_url
  end
end
