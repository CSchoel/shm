require 'rexml/document'

xmlfile = File.new(ARGV[0])
xml = REXML::Document.new(xmlfile)

root = xml.root()
parameters = root.get_elements("//variable[@variability='parameter' and not(starts-with(@name, '$PRE'))]")
parameters.sort_by!{|x| x.attribute("name").value()}.each do |x|
  print "      +\"#{x.attribute("name")}=\"+String(#{x.attribute("name")})+\"\\n\""
  #print x.attribute("name")
  #rel = x.get_elements("Real")
  #print("="+rel[0].attribute("start").to_s) if rel.length > 0 and rel[0].attribute("useStart")
  puts
end
