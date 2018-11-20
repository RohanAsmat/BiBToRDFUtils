# Field and Entries Reference Manual
# https://www.andy-roberts.net/res/writing/latex/bibentries.pdf

#PREFIXES
Prefixes = [
  "address: <http://schemas.talis.com/2005/address/schema#>",
  "bibo: <http://purl.org/ontology/bibo/>",
  "biboDegree: <http://purl.org/ontology/bibo/degree/>",
  "bibtex: <http://purl.org/net/nknouf/ns/bibtex#>",
  "dct: <http://purl.org/dc/terms/>",
  "foaf: <http://xmlns.com/foaf/0.1/>",
  "rdfs: <http://www.w3.org/2000/01/rdf-schema#>",
  "sdaperson: <http://sda.tech/Person/>",
  "sda: <http://beta.sda.tech/schema/>",
  "sdatech: <https://sda.tech.cs.bonn.de>",
]

#Entries
ENTRYTYPES = [
  article = ["label" => "article", "items" => ["bibo:AcademicArticle", "dct:BibliographicResource"]],
  book = ["label" => "book", "items" => ["bibo:Book", "dct:BibliographicResource" ]],
  booklet = ["label" => "booklet", "items" => [ "bibtex:Publication", "dct:BibliographicResource"]],
  conference = ["label" => "conference", "items" => ["bibo:Conference", "dct:BibliographicResource"]],
  inbook = ["label" => "inbook", "items" => [ "bibo:Chapter" , "dct:BibliographicResource"]],
  incollection = ["label" => "incollection", "items" => ["bibtex:InCollection", "dct:BibliographicResource"]],
  inproceedings = ["label" => "inproceedings", "items" => ["bibtex:InProceedings", "dct:BibliographicResource"]],
  journal = ["label" => "journal", "items" => ["dct:BibliographicResource", "bibo:Journal"]],
  manual = ["label" => "manual", "items" => ["bibo:Manual", "bibtex:Manual", "dct:BibliographicResource"]],
  masterthesis = ["label" => "masterthesis", "items" => ["bibo:Thesis", "sdatech:completedThesis", "dct:BibliographicResource"]],
  misc = ["label" => "misc", "items" => ["bibo:Document", "dct:BibliographicResource"]],
  note = ["label" => "note", "items" => ["dct:BibliographicResource", "bibo:Note"]],
  other = ["label" => "other", "items" => ["dct:BibliographicResource"]],
  periodical = ["label" => "periodical", "items" => ["bibo:Periodical", "dct:BibliographicResource"]],
  phdthesis = ["label" => "phdthesis", "items" => ["bibo:Thesis", "sdatech:completedThesis", "dct:BibliographicResource"]],
  proceedings = ["label" => "proceedings", "items" => ["bibo:Proceedings", "dct:BibliographicResource"]],
  techreport = ["label" => "techreport", "items" => ["bibo:Report", "dct:BibliographicResource"]],
  unpublished = ["label" => "unpublished", "items" => [ "bibtex:Unpublished", "dct:BibliographicResource"]],
]

#Fields for defined RDF types
FIELDENCODING = [
  abstract = ["label" => "abstract", "items" => ["dct:abstract"] ],
  address = ["label" => "address", "items" => ["address:localityName"] ],
  annote = ["label" => "annote" , "items" => ["bibo:annotates", "bibtex:annote"]],
  #author = ["label" => "author", "items" => ["dct:creator","bibo:authorlist"]],
  author = ["label" => "author", "items" => ["dct:creator"]],
  biburl = ["label" => "biburl", "items" => ["rdfs:seeAlso"]],
  booktitle = ["label" => "booktitle", "items" => ["dct:isPartOf"]],
  chapter = ["label" => "chapter", "items" => ["bibo:chapter", "bibtex:chapter"] ],
  crossref = ["label" => "crossref", "items" => ["dct:references"]],
  date = ["label" => "date", "items" => ["dct:issued"]] ,
  doi = ["label" => "doi", "items" => ["bibo:doi"]],
  edition = ["label" => "edition", "items" => ["bibo:edition", "bibtex:edition"]],
  editor = ["label" => "editor", "items" => ["bibo:editor", "bibtex:editor"]],
  howpublished = ["label" => "howpublished", "items" => ["dct:hasFormat", "bibtex:howpublished"]],
  institution = ["label" => "institution", "items" => ["bibtex:institution"]],
  issue = ["label" => "issuetitle", "items" => ["bibo:issue"]],
  issbn = ["label" => "issbn", "items" => ["bibo:issbn"]],
  issn = ["label" => "issn", "items" => ["bibo:issn"]],
  journal = ["label" => "journal", "items" => ["dct:isPartOf"]],
  key = ["label" => "key", "items" => ["dct:identifier"]],
  keywords = ["label" => "keywords", "items" => ["bibtex:keywords"]],
  month = ["label" => "month", "items" => ["bibtex:month"]],
  note = ["label" => "note", "items" => ["bibtex:note"]],
  number = ["label" => "number", "items" => ["bibtex:number"]],
  organization = ["label" => "funded-by-name", "items" => ["bibtex:organization"]],
  #additional Check
  pages = ["label" => "pages", "items" => ["bibo:pageStart", "bibo:pageEnd" ]],
  publisher = ["label" => "publisher", "items" => ["dct:publisher"]],
  school = ["label" => "school", "items" => ["bibtex:school"]],
  series = ["label" => "series", "items" => ["dct:isPartOf"]],
  title = ["label" => "title", "items" => ["dct:title"]],
  type = ["label" => "type", "items" => ["dct:type", "bibtex:type"]],
  url = ["label" => "url", "items" => ["dct:hasFormat"]],
  file = ["label" => "file", "items" => ["dct:source"]],
  volume = ["label" => "volume", "items" => ["bibo:volume", "bibtex:volume"]],
  year = ["label" => "year", "items" => ["bibtex:year"]]
]

#Class Definitions
CLASSDEFINITIONS = [
  c1 = "dct:BibliographicResource rdfs:subClassOf foaf:Document .",
  c2 = "bibtex:InCollection rdfs:subClassOf dct:BibliographicResource .",
  c3 = "bibtex:InProceedings rdfs:subClassOf dct:BibliographicResource .",
  c4 = "bibtex:Manual rdfs:subClassOf dct:BibliographicResource .",
  c5 = "bibtex:Publication rdfs:subClassOf dct:BibliographicResource .",
  c6 = "bibtex:Unpublished rdfs:subClassOf foaf:Document .",
  c7 = "bibo:AcademicArticle rdfs:subClassOf bibo:Article .",
  c8 = "bibo:Article rdfs:subClassOf dct:BibliographicResource .",
  c9 = "bibo:Book rdfs:subClassOf dct:BibliographicResource .",
  c10 = "bibo:Chapter rdfs:subClassOf dct:BibliographicResource .",
  c11 = "bibo:Conference rdfs:subClassOf dct:BibliographicResource .",
  c12 = "bibo:Document rdfs:subClassOf foaf:Document .",
  c13 = "bibo:Periodical rdfs:subClassOf dct:BibliographicResource .",
  c14 = "bibo:Proceedings rdfs:subClassOf dct:BibliographicResource .",
  c15 = "bibo:Report rdfs:subClassOf dct:BibliographicResource .",
  c16 = "bibo:Thesis rdfs:subClassOf dct:BibliographicResource .",
]
