# SCRIPT TO PARSE AND STORE AS AN OUTPUT
# THE INSTANCE TYPES OF PARTICULAR TYPE
# FROM AN ONTOLOGY
require 'json'

#Input file for parsing Turtle
print 'Please provide the path or name to the input file:'

personNames = Array.new
personItem = {"name" => "", "item" => "", "class" => "" }

File.open("sda.tech.ttl", "r") do |f|
  f.each_line do |line|
    lineVariable =  line.dup
    lineVariable = lineVariable.split(/ /)[0].to_s

    if lineVariable.include? "sdaperson:"
      personItem["item"] = lineVariable.dup.to_s
      personItem["name"] = lineVariable.dup.split(/:/)[1].to_s
      personItem["class"] = line.dup.split(/ a /)[1].to_s.gsub!(";", "").gsub!("\n", "")

      personNames.push personItem

      puts lineVariable
    end
    personItem = {}
  end
end

File.open("result.json","w") do |f|
  f.write(personNames.to_json)
end
