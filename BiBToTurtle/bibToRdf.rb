require 'bibtex'
require './configuration.rb'
require 'json'

#Constants
A = " a "
DOT = " ."
SEMICOLON = " ;"
NEW_LINE = " \n"
DOUBLE_QUOTE = "\""
EMPTYSTRING = ""
COMMASTRING = ", "
LEFTINDENT = "        "
SPACE = " "
GREATER_THEN = ">"
LESSER_THEN = "<"
PREFIX = "@prefix"
COLON = ":"
SDA = "sda:"
FOAF = "foaf:"
PERSON = "person"
NAME = "name"
FAMILYNAME = "familyName"
FIRSTNAME = "firstName"
BIBLIOGRAPHICRESOURCE = "dct:BibliographicResource"
RDFIDENTIFIER = "dct:modified"

#Global Vars
foafPersons = []

#FUNCTION TO CHECK IF THE PERSON TYPES EXISTS
#ELSE ADD FOAF:PERSON
#TO THE MODEL
def addNonExistingPersonToList(personToCheck, existingPersonList, foafPersons)
  foundPerson = false
  for persons in existingPersonList
    puts persons["item"].to_s + NEW_LINE
    if personToCheck["id"].to_s == persons["item"].to_s
      foundPerson = true
    end
  end

  if !foundPerson
    foafPersons.push(personToCheck)
  end
end

#FUNCTION TO WRITE THE MISSING
#PERSON LIST AS AN INSTANCE OF
#FOAF:PERSON
def addNonExistingPersonToFile(file, foafPersons)
  file.write(NEW_LINE)
  file.write("####################PERSON#TYPE#INSTANCES#######################")
  file.write(NEW_LINE)
  for persons in foafPersons.uniq!
    file.write(persons["id"].to_s + SPACE + A + SPACE + FOAF + PERSON + SEMICOLON + NEW_LINE)
    file.write(LEFTINDENT + FOAF + NAME + SPACE + DOUBLE_QUOTE + persons["fname"].to_s + SPACE + persons["lname"].to_s + DOUBLE_QUOTE + SPACE + SEMICOLON + NEW_LINE )
    file.write(LEFTINDENT + FOAF + FAMILYNAME + SPACE + DOUBLE_QUOTE + persons["lname"].to_s + DOUBLE_QUOTE + SPACE + SEMICOLON + NEW_LINE )
    file.write(LEFTINDENT + FOAF + FIRSTNAME + SPACE + DOUBLE_QUOTE + persons["fname"].to_s  + DOUBLE_QUOTE + SPACE + DOT + NEW_LINE + NEW_LINE )
  end
end

#FUNCTION TO CONVERT AUTHOR LIST INTO DATA-TYPE-RPROPERTY-ELEMENTS
def authorListToRDFProperties(list, type, propertyname, existingPersonList, foafPersons)
  if type == "string"
    return list
  elsif type == "rdf"
    #puts list.to_s + NEW_LINE
    list.gsub!(/[^A-Za-z, ]/, '')
    list2 = list.dup
    list2 = list2.split(/ and /)
    result= EMPTYSTRING
    puts list2.to_s + NEW_LINE

    i= 0

    for items in list2
      #puts i.to_s + "   :  "+ items

      itemTemp = items.dup
      itemTemp = itemTemp.split(/,/)

      lname = itemTemp[0].dup
      #puts "Lastname:" + lname.to_s.gsub!(/[^A-Za-z]/, '').to_s
      lname = lname.to_s
      lname = lname.gsub(/\s+/, "")

      fname = itemTemp[1].dup
      fname = fname.to_s.gsub!(/[^A-Za-z]/, '').to_s
      fname = fname.gsub(/\s+/, "")

      #puts "fname:" + fname + SPACE + "lname:" + lname + NEW_LINE
      #puts "RES:" + itemTemp[0].to_s + itemTemp[1].to_s

      result = result + SPACE + propertyname + fname + lname  + COMMASTRING

      personToCheck = {}
      personToCheck["id"] = propertyname + fname + lname
      personToCheck["fname"] = fname
      personToCheck["lname"] = lname

      addNonExistingPersonToList( personToCheck, existingPersonList, foafPersons)

      i = i + 1
    end

    puts  NEW_LINE

  else

  end
  #puts list
  n = 2
  result = result[/\A.{#{result.size-n}}/].to_s
  #puts "RESULT:" + result

  return result
end

#READING ALREADY EXISTING PERSONS
file = File.read('result.json')
existingPersonList = JSON.parse(file)

#Input file for parsing BibTex
print 'Please provide the path or name to the input file:'
bibFilePath = gets
b = BibTeX.open('./sda.bib')
arrayLength = b.length

#Input Prefix for the Publications
print 'Please provide the prefix for your Publication Entries:'
prefixPublications = gets
prefixPublications = prefixPublications.gsub(/\n/," ")
prefixPub = prefixPublications.split(/:/)
prefixPub = prefixPub[0] + COLON

Prefixes.push(prefixPublications)
puts prefixPub

#Input prefix for Persons/Authors
prefixPersons = gets
prefixPersons = prefixPersons.gsub(/\n/," ")
prefixPerson = prefixPersons.split(/:/)
prefixPerson = prefixPerson[0] + COLON

#Input File Path for the output
print 'Please provide the path or the name of the file to be written:'
ttlFilePath = gets


#Opening an RDF File to write
begin
  #Ttl File for writing
  file = File.open("sda.ttl", "w")
  #file.write("your text")

  #Write Prefixes
  file.write("####################PREFIXES#####################" + NEW_LINE)
  for prefix in Prefixes
    file.write(PREFIX + SPACE + prefix +  DOT + NEW_LINE)
  end

  #Write Prefixes
  file.write( NEW_LINE + "#################CLASS DEFINITION################" + NEW_LINE)
  for classes in CLASSDEFINITIONS
    file.write( NEW_LINE + classes + NEW_LINE)
  end

  #Convert Bib To RDF Entries
  file.write( NEW_LINE + "#############PUBLICATION ENTRIES#################" + NEW_LINE)
  for item in b do
    publicationType = item.type
    classTypes = EMPTYSTRING
    keyName = EMPTYSTRING
    file.write( NEW_LINE )

    for hashItem in ENTRYTYPES do
      for keyItem in hashItem do
        if item.type.to_s == keyItem["label"]
          length = keyItem["items"].length
          length = length - 1
          keyItem["items"].each_with_index { |val, index|
            if length != index
              classTypes += val + COMMASTRING
            else
              classTypes += val
            end
          }
        end
      end
    end

    string = item.key.dup
    replacements = [ ["{", ""], ["}", ""],["'", ""], ["[", ""], ["]", ""], ["\\", ""], ["\"", ""], [":", ""], ["/", ""], ["+", ""], ["?", ""] ]
    replacements.each {|replacement| string.gsub!(replacement[0], replacement[1])}
    keyName = item.key.dup

    #Write the parsed class type
    if classTypes.to_s != ''
      #puts "class: " + classTypes
      file.write( prefixPub + string + A + classTypes + SEMICOLON + NEW_LINE  )
      classTypes = EMPTYSTRING
    else
      #puts "class: " + classTypes
      classTypes = BIBLIOGRAPHICRESOURCE
      file.write( prefixPub + string + A + classTypes + SEMICOLON + NEW_LINE  )
      classTypes = EMPTYSTRING
    end

    for d in item do
      #Checking the Field Name
      temp = d[0].to_s.downcase
      property = EMPTYSTRING
      boolValidProp = false

      #puts "TEMP:" + temp

      for fieldItem in FIELDENCODING do
        for fieldValue in fieldItem do
          #case for undefined mappings missing
          if keyName == "dbpedia_events"
            puts d[0].to_s
            puts d[1]
          end

          if temp == fieldValue["label"].downcase
            length = fieldValue["items"].length
            length = length - 1
            fieldValue["items"].each_with_index { |val, index|

            property = val
            file.write( LEFTINDENT + property +  SPACE )

            if temp == "pages"
              startPageValue = d[1].to_s.dup
              startPageValue = startPageValue.split(/-/)


              if property == "bibo:pageStart"
                #Parsing and Filing the Field Value
                #puts startPageValue
                propStr = DOUBLE_QUOTE + startPageValue[0].to_s.dup + DOUBLE_QUOTE
                file.write( propStr +  SPACE + SEMICOLON + NEW_LINE)
              end
              if property == "bibo:pageEnd"
                propStr = DOUBLE_QUOTE + startPageValue[-1].to_s.dup + DOUBLE_QUOTE
                file.write( propStr +  SPACE + SEMICOLON + NEW_LINE)
              end

            elsif temp == "file" || temp == "url" || temp == "biburl"

              string = LESSER_THEN + d[1].to_s + GREATER_THEN
              replacements = [ ["https\\", "https"], ["http\\", "http"], [" ", ""]  ]
              replacements.each {|replacement| string.gsub!(replacement[0], replacement[1])}

              #Parsing and Filing the Field Value
              file.write( string +  SPACE + SEMICOLON + NEW_LINE)
            elsif temp == "author"

              if property == "dct:creator"
                authorArray = authorListToRDFProperties(d[1].to_s, "rdf", "sdaperson:", existingPersonList, foafPersons)

                #Parsing and Filing the Field Value
                string =  authorArray
                file.write( string +  SPACE + SEMICOLON + NEW_LINE)

              elsif property == "bibo:authorlist"
                string = DOUBLE_QUOTE +   d[1].to_s + DOUBLE_QUOTE
                file.write( string +  SPACE + SEMICOLON + NEW_LINE)

              end

            elsif temp == "crossref"

              #For linking Cross References
              string =  d[1].to_s
              replacements = [ ["{", ""], ["}", ""],["'", ""], ["[", ""], ["]", ""], ["\\", ""], ["\"", ""], [":", ""], ["/", ""], ["+", ""] ]
              replacements.each {|replacement| string.gsub!(replacement[0], replacement[1])}
              file.write(  prefixPub + string +  SPACE + SEMICOLON + NEW_LINE)

            elsif temp == "title" || temp == "year" || temp == "publisher"

              string = d[1].to_s.dup
              string = string.gsub("\"", "'")

              replacements = [ ["{", ""], ["}", ""],["'", ""], ["[", ""], ["]", ""], ["\\", ""], ["textsuperscript", ""], ["texttt", ""], ["^", ""]  ]
              replacements.each {|replacement| string.gsub!(replacement[0], replacement[1])}

              file.write( DOUBLE_QUOTE +  string + DOUBLE_QUOTE +  SPACE + SEMICOLON + NEW_LINE)


            else

              #Parsing and Filing the Field Value
              string = DOUBLE_QUOTE + d[1].to_s.gsub(/[^A-Za-z0-9\-, ]/, '').to_s + DOUBLE_QUOTE
              file.write( string +  SPACE + SEMICOLON + NEW_LINE)
            end
            }

            boolValidProp = true
          end
        end
      end

      if boolValidProp == false
        property = SDA + d[0].to_s
        file.write( LEFTINDENT + property +  SPACE )
        string = d[1].to_s

        replacements = [ ["{", ""], ["}", ""],["'", ""], ["[", ""], ["]", ""], ["\\", ""], ["\"", "'"], ["textsuperscript", ""], ["texttt", ""], ["^", ""]   ]
        replacements.each {|replacement| string.gsub!(replacement[0], replacement[1])}

        file.write(DOUBLE_QUOTE +  string + DOUBLE_QUOTE +  SPACE + SEMICOLON + NEW_LINE)
      end
      boolValidProp = false
      temp = EMPTYSTRING
    end
    file.write( LEFTINDENT + RDFIDENTIFIER + SPACE + DOUBLE_QUOTE +  keyName + DOUBLE_QUOTE +  SPACE + DOT + NEW_LINE)
    #file.seek(-4, IO::SEEK_END)
    #file.write( DOT + NEW_LINE )
  end
  addNonExistingPersonToFile(file, foafPersons)
  print foafPersons.uniq!
rescue IOError => e
  #some error occur, dir not writable etc.
  #puts "File I/O Error:" + e
ensure
  file.close unless file.nil?
end
