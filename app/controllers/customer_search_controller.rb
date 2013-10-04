require 'rexml/document'
class CustomerSearchController < ApplicationController
  include REXML
  skip_before_action :verify_authenticity_token
  def GetDetails
    
    #Get Custome Map location details from Zillow API
    apiUserName="root"
    apiPassword="root"
    
    if(params[:txtStreetAddress] != nil)
      streetAddress=params[:txtStreetAddress].gsub(' ','+' )
      streetAddress=streetAddress.gsub(',','%2C' )
    else
      streetAddress=""
    end
    
    if(params[:selectCity] != nil && params[:selectState] !=nil)
      citystatezip=params[:selectCity] + '%2C+' + params[:selectState]
    else
      citystatezip=""
    end
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