# Install latest version from omegahat
install.packages("SSOAP", repos = "http://www.omegahat.org/R", dependencies = TRUE, type = "source")

# Load neccessary libraries
library(SSOAP)
library(RCurl)
library(XML)

# fetch definitions
def <- processWSDL("http://search.isiknowledge.com/esti/wokmws/ws/WokSearchLite?wsdl")

# create Client Interface
ff <- genSOAPClientInterface(def = def)

# throws error:
# Error: evaluation nested too deeply: infinite recursion / options(expressions=)?
# Error during wrapup: evaluation nested too deeply: infinite recursion / options(expressions=)?
# maybe due to function "search" (which also exists in r-base)

# Define the search
search_array <- list(
  'queryParameters' = list(
    'databaseID' = 'WOS',
    'userQuery' = 'AU=Douglas T*',
    'editions' = list(
      list('collection' = 'WOS', 'edition' = 'SSCI'),
      list('collection' = 'WOS', 'edition' = 'SCI')
    ),
    'queryLanguage' = 'en'
  ),
  'retrieveParameters' = list(
    'count' = '5',
    'fields' = list('name' = 'Date', 'sort' = 'D'),
    'firstRecord' = '1'
  )
)

# Call search from Client
try(search_response = ff@functions$search(search_array))

# Print the returned search results
print(search_response)