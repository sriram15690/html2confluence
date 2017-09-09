require 'html2confluence'

def html_to_confluence_parser(filepath =  "./input_files")
  input_files = Dir.glob("#{filepath}/**/*.html") - ['.', '..']
  puts "***** Started parsing files in #{filepath} ***** \n\n"
  input_files.each do |file|
    puts "Parssing file #{file}"
    output = parse(file)
    write_output(output, file)
  end
  puts "\n\n***** Finished parsing & copying. Pls. check the output in #{filepath}"
end

def parse(filepath)
  parser = HTMLToConfluenceParser.new
  input_file = File.open(filepath)
  parser.feed(input_file.read)
  output = parser.to_wiki_markup
  output
end

def write_output output, file
  destination_path = "./output_files/#{File.basename file}"
  File.open(destination_path, 'w') do |f|
    f.write output
  end
end

html_to_confluence_parser()