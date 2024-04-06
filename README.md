# jsc_test

This Application build for TECHNICAL TEST at Jobseeker Company as Flutter Developer 

## Getting Started

- the apk inside apk directory
- this app use OPEN API from https://newsapi.org/
- use BLOC for state management and HIVE for loca storage
- only have 2 pages, home and detail.
- Home Page contains 2 different end point, the response of each API Endpoint store at Local Storage with HIVE.Then from       localstorage data will be loaded in the UI, if no Internet Connection app will direct load From the local storage.
- The home page has a search to filter titles from data in local storage.
- On the detail page the data is sent from the item selected on the home page, not taken from the API because the news api does not have an endpoint for detail data
  
  