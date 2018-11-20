
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
