require 'rexml/document'
class CustomerSearchController < ApplicationController
  include REXML
  skip_before_action :verify_authenticity_token
  
  def GetDetails    
    if(params[:txtStreetAddress] != nil && params[:selectCity] != nil && params[:selectState] != nil && params[:txtZipCode] != nil)
      streetAddress=params[:txtStreetAddress].gsub(' ','+' )
      streetAddress=streetAddress.gsub(',','%2C' )   
      citystatezip=params[:selectCity] + '%2C+' + params[:selectState] + '%2C+' + params[:txtZipCode]
      
      #Calling method to show location map
      ShowLocationMap(streetAddress, citystatezip)
    end    
  end
  
  #Get Custome Map location details from Zillow API to show location map on web page
  def ShowLocationMap(streetAddress, citystatezip)
    apiUserName="root"
    apiPassword="root"
    #uri = "http://www.zillow.com/webservice/GetSearchResults.htm?#{'zws-id=X1-ZWz1dmvv3i5qtn_3fm17&address=2114+Bigelow+Ave&citystatezip=Seattle%2C+WA'}"
    uri = "http://www.zillow.com/webservice/GetSearchResults.htm?#{'zws-id=X1-ZWz1dmvv3i5qtn_3fm17&address=' + streetAddress + '&citystatezip=' + citystatezip}"
    rest_resource = RestClient::Resource.new(uri, apiUserName, apiPassword) 
    users = rest_resource.get
    users= users.gsub('SearchResults:searchresults','SearchResults')  
    users= users.gsub('xsi:schemaLocation','schemaLocation')
    xmldoc = Document.new(users)
    root = xmldoc.root
    longitude=""
    latitude=""
    xmldoc.elements.each('SearchResults/response/results/result/address/longitude') do |long| 
      longitude = long.text   
    end
    
    xmldoc.elements.each('SearchResults/response/results/result/address/latitude') do |long| 
      latitude = long.text   
    end
    
    #Pass values for Longitude and Latitude to the View to show customer location in MAP.
    @longitude = longitude
    @latitude = latitude
  end
end