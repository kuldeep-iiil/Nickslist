require 'rexml/document'
class CustomerSearchController < ApplicationController
  include REXML
  skip_before_action :verify_authenticity_token
  
  def GetDetails    
    if(params[:txtStreetAddress] != nil && params[:selectCity] != nil && params[:txtZipCode] != nil)
      
      #streetAddress=params[:txtStreetAddress].gsub('#','' )
      streetAddress=params[:txtStreetAddress].gsub(' ', '+')
      #streetAddress=streetAddress.gsub(' ', '+') 
      streetAddress=streetAddress.gsub(',','%2C' )  
      
      #citystatezip=params[:selectCity] + '%2C+' + params[:selectState] + '%2C+' + params[:txtZipCode]
      citystatezip=params[:selectCity] + '%2C+' + params[:txtZipCode]
      citystatezip=citystatezip.gsub(', ','%2C')
      
      #location = params[:txtStreetAddress] + ', ' + params[:selectCity] + ', ' + params[:selectState] + ', ' + params[:txtZipCode]
      location = params[:txtStreetAddress] + ', ' + params[:selectCity] + ', ' + params[:txtZipCode]
     
      cordinates = Geocoder.search(location)
      
      #Calling method to show Home Details
      ShowHomeDetails(streetAddress, citystatezip)
      
      #Pass values for Longitude and Latitude to the View to show customer location in MAP.
      if cordinates.present?        
        @longitude = cordinates[0].longitude.to_s
        @latitude = cordinates[0].latitude.to_s
        @address = cordinates[0].address.to_s
        #@classifieds = cordinates[0].latitude.to_s + ', ' + cordinates[0].longitude.to_s + ', 10, 40'
        #@classifieds = @classifieds.to_gmaps4rails
      end
    end    
  end
  
  #Get Customer Home details from Zillow API
  def ShowHomeDetails(streetAddress, citystatezip)
    #Key to access Zillow API
    zwsID = 'X1-ZWz1dn6tpoopvv_18y6r'
    #uri = "http://www.zillow.com/webservice/GetSearchResults.htm?#{'zws-id=X1-ZWz1dmvv3i5qtn_3fm17&address=2114+Bigelow+Ave&citystatezip=Seattle%2C+WA'}"
    uri = "http://www.zillow.com/webservice/GetDeepSearchResults.htm?#{'zws-id=' + zwsID + '&address=' + streetAddress + '&citystatezip=' + citystatezip}"
    #@uri = uri
    rest_resource = RestClient::Resource.new(uri, '', '') 
    users = rest_resource.get
    users= users.gsub('SearchResults:searchresults','SearchResults')  
    users= users.gsub('xsi:schemaLocation','schemaLocation')
    xmldoc = Document.new(users)
    root = xmldoc.root
    longitude=""
    latitude=""
    xmldoc.elements.each('SearchResults/response/results/result/taxAssessmentYear') do |long| 
      @taxAssessmentYear = long.text   
    end  
    xmldoc.elements.each('SearchResults/response/results/result/taxAssessment') do |long| 
      @taxAssessment = long.text   
    end
    xmldoc.elements.each('SearchResults/response/results/result/yearBuilt') do |long| 
      @yearBuilt = long.text   
    end  
    xmldoc.elements.each('SearchResults/response/results/result/lotSizeSqFt') do |long| 
      @lotSizeSqFt = long.text   
    end
    xmldoc.elements.each('SearchResults/response/results/result/finishedSqFt') do |long| 
      @finishedSqFt = long.text   
    end  
    xmldoc.elements.each('SearchResults/response/results/result/bathrooms') do |long| 
      @bathrooms = long.text   
    end
    xmldoc.elements.each('SearchResults/response/results/result/bedrooms') do |long| 
      @bedrooms = long.text   
    end  
    xmldoc.elements.each('SearchResults/response/results/result/lastSoldDate') do |long| 
      @lastSoldDate = long.text   
    end
    xmldoc.elements.each('SearchResults/response/results/result/lastSoldPrice') do |long| 
      @lastSoldPrice = long.text   
    end         
  end
end