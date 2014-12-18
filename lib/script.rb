@data_hash = Hash.new
poem_files = Dir.glob('data/*.txt')

poem_files.each do |poem_file|
  all_lines = IO.readlines(poem_file)
  @verse_count = 0
  @line_count = 0
  all_lines.each_with_index do |line, index|
    if index == 0
      @title = line.chomp
    elsif index == 1
      @author = line.chomp
      if not @data_hash.has_key?(@author)
        @data_hash[@author] = Hash.new
      end
    else
      if line =~ /^.+$/
        @line_count += 1
      elsif line == "\n"
        @verse_count += 1
      end
    end
  end
  @data_hash[@author][@title] = {
    verses: @verse_count,
    lines: @line_count,
  }
end

p @data_hash
