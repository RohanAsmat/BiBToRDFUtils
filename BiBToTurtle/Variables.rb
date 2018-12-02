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

#String Parser Replacements
REPLACEMENT_INSTANCE_ID = [ ["{", ""], ["}", ""],["'", ""], ["[", ""], ["]", ""], ["\\", ""], ["\"", ""], [":", ""], ["/", ""], ["+", ""], ["?", ""] ]
REPLACEMENT_URLS = [ ["https\\", "https"], ["http\\", "http"], [" ", ""]  ]
REPLACEMENT_CROSSREF = [ ["{", ""], ["}", ""],["'", ""], ["[", ""], ["]", ""], ["\\", ""], ["\"", ""], [":", ""], ["/", ""], ["+", ""], ["?", ""] ]
REPLACEMENT_ALL = [ ["{", ""], ["}", ""],["'", ""], ["[", ""], ["]", ""], ["\\", ""], ["\"", "'"], ["textsuperscript", ""], ["texttt", ""], ["^", ""]   ]
