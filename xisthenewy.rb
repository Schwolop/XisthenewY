require 'nokogiri'
require 'open-uri'

root_uri = 'https://www.google.com/search?q='
middle_query = '+is+the+new+'
words = ['cheese','drug','sausage']

print "\t#{words.join("\t")}\n"
words.each do |x|
  print "#{x}\t"
  words.each do |y|
    query_string = "#{root_uri}#{x}#{middle_query}#{y}"
    doc = Nokogiri::HTML(open(query_string))
    results_string = doc.at_css('#resultStats').children.first.text
    results_count = /^About (.*) results$/.match(results_string)[1].delete(',').to_f
    printf "%.1E\t", results_count
  end
  print "\n"
end
