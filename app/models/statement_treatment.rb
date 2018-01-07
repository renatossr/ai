class StatementTreatment
  require 'csv'
  
  def self.treat(file)
    @uploaded_file = save_original_file(file)
    
    #include step to process pdf into csv
    @arr = get_array_from_csv(@uploaded_file)
    
    @statement_type = get_statement_type(@arr)
    puts 'Statement Type: ' + @statement_type
    
    
    #remove_nil(@arr)
    
    clean_edges(@arr)
    stack_balance_sheet(@arr)
    clean_messy_lines(@arr)
    
    return @arr
  end
  
  private
  def self.save_original_file(file)
    content = file.read
    File.open(Rails.root.join('public', 'uploads', file.original_filename), 'wb') do |f|
      f.write(content)
      return f
    end
  end
  
  def self.get_array_from_csv(file)
    return CSV.read(file)
  end
  
  def self.get_statement_type(arr)
    types = {BS: ['balanço'], IS: ['resultado'], CF: ['fluxo de caixa']}

    arr.each do |line|
      line.each do |item|
        types.each do |key, value|
          if value.any? { |i| item.to_s.downcase.include?(i) }
            return key.to_s
          end
        end
      end
    end
    
    #puts 'Statement Type: ' + @statement_type
  
  end
  
  # Clean title and footer of statement
  def self.clean_edges(arr)
    test_limits = {beg: ['consolidado'], finish: ['explicativa']}
    limits = {beg: 0, finish: -1}

    arr.each_with_index do |line, index|
      line.each do |item|
        test_limits.each do |key, value|
          if value.any? { |i| item.to_s.downcase.include?(i) }
            limits[key] = index
          end
        end
      end
    end
    
    @arr = arr.values_at(limits[:beg]..limits[:finish]-1)
  end
  
  #Clean lines not properly processed by pdf table extractor
  def self.clean_messy_lines(arr)
    
    arr_index = []
    new_lines = []
    
    arr.each_with_index do |line, index|
      line.each do |item|
        #if item.to_s.scan(/(?:^|\s)(\d*\.?\d+|\d{1,3}(?:,\d{3})*(?:\.\d+)?)(?!\S)/).count > 1
        if item.to_s.split("\n").length > 1
          arr_index.push(index)
        end
      end
    end
    
    arr_index = arr_index.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)
    
    #Prepares lines to be swapped
    arr_index.each do |index| #loop each identified row with problem
      max_split = arr[index][0].split("\n").length #get number of embedded rows
      arr_new_lines = []
      arr[index].each_with_index do |value, column| #loop each column within problem row
        column_array = []
        for i in 0..max_split-1
          column_array[i] = value != nil ? value.split("\n")[i] : nil
        end
        arr_new_lines.push(column_array)
      end
      new_lines.push({row_index: index, n_rows: max_split, content: arr_new_lines.transpose})
    end
    
    #Swap problematic lines for treated ones
    #iterates backwards to avoid index problems
    for e in (new_lines.length-1).downto(0)
      entry = new_lines[e]
      for i in (entry[:n_rows]-1).downto(0)
        arr.insert(entry[:row_index], entry[:content][i])
      end
      arr.delete_at(entry[:row_index]+entry[:n_rows])
    end
    
    @arr = arr
    
  end
  
  #Identifies if balance_sheet is side by side and stacks Assets and Liabilities+ShareholdersEquity
  def self.stack_balance_sheet(arr)
    keywords = ['passivo']
    column = nil
    arr_liability = []
    
    arr.each do |line|
      line.each_with_index do |item, line_index|
        if keywords.any? { |i| item.to_s.downcase.include?(i) }
            column = line_index
        end
      end
    end
    
    arr.each_with_index do |line, index|
      arr_liability.push(arr[index].slice!(column, line.length))
    end
    
    arr_liability.each do |line|
      arr.push(line)
    end
    @arr = arr
    
    
  end
  
  def self.remove_nil(arr)
    arr.each_with_index do |line, index|
      arr[index].map!{|x|x.nil? ? '..':x}
    end
  end
  
end