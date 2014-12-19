class AllPoems
  attr_reader :poems
  def initialize directory='data/*.txt'
    @files = Dir.glob(directory)
    @poems = []
    @files.each do |file|
      @poems << Poem.new(file)
    end
  end

  def print
    output_hash = Hash.new
    @poems.each do |poem|
      if !output_hash[poem.author]
        output_hash[poem.author] = Hash.new
      end
      output_hash[poem.author][poem.title] = {
        verses: poem.verses, 
        lines: poem.lines,
      }
    end
    p output_hash
  end
end


class Poem
  attr_reader :poem_body
  def initialize file
    @file_lines = IO.readlines(file)
    @poem_body = @file_lines[2..-1]
  end

  def title
    @file_lines[0].chomp
  end

  def author
    @file_lines[1].chomp
  end

  def verses
    @poem_body.select{|a| a == "\n"}.count
  end

  def lines
    @poem_body.select{|a| a =~ /^.+$/}.count
  end
end


AllPoems.new.print
