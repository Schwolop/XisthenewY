require 'nokogiri'
require 'open-uri'

root_uri = 'https://www.google.com/search?q='
middle_query = '+is+the+new+'

words = ARGV.count > 1 ? ARGV : ['white','black','drug','ruby','java']
output_words = words.map { |w| w.length > 8 ? "#{w[0..2]}..#{w[w.length-3..w.length-1]}" : w }

print "X \\ Y\t#{output_words.join("\t")}\n"
words.each_with_index do |x,i|
  print "#{output_words[i]}\t"
  words.each do |y|
    if x != y
      query_string = "#{root_uri}#{x}#{middle_query}#{y}"
      doc = Nokogiri::HTML(open(query_string))
      results_string = doc.at_css('#resultStats').children.first.text
      results_count = /^About (.*) results$/.match(results_string)[1].delete(',').to_f
      printf "%.1E\t", results_count
    else
      print "\t"
    end
  end
  print "\n"
end
