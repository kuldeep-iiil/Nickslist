require 'rexml/document'
class CustomerSearchController < ApplicationController
  include REXML
  include ActionView::Helpers::NumberHelper
  skip_before_action :verify_authenticity_token
  
  
  
  def GetDetails    
    #if(session[:user_id] == nil)
     # redirect_to root_url, :notice => "Please login first to get result for search!"
    #end
    
    if(params[:txtStreetAddress] != nil && params[:selectCity] != nil && params[:txtZipCode] != nil)
      @firstName = params[:txtFirstName]
      @lastName = params[:txtLastName]
      @phoneNumber = params[:txtPhoneNumber]
      @streetAddress = params[:txtStreetAddress]
      @zipCode = params[:txtZipCode]
      @citystateVal = params[:selectCity]
      citystateVal = params[:selectCity].to_str.split(',')
      @city = citystateVal.at(0).strip()
      @state = citystateVal.at(1).strip()
      #streetAddress=params[:txtStreetAddress].gsub('#','' )
      streetAddress=params[:txtStreetAddress].gsub(' ', '+')
      #streetAddress=streetAddress.gsub(' ', '+') 
      params[:txtStreetAddress] 
      
      #citystatezip=params[:selectCity] + '%2C+' + params[:selectState] + '%2C+' + params[:txtZipCode]
      city=params[:selectCity].gsub(' ', '+')
      citystatezip=city + '%2C+' + params[:txtZipCode]
      citystatezip=citystatezip.gsub(', ','%2C')
      
      #Get Reviews count for searched person
      #@customer = Customer.find_by(LastName: @lastName, ContactNumber: @phoneNumber, StreetAddress: @streetAddress, City: @city, State: @state, ZIPCode: @zipCode)
           
      @customer = Customer.where("LastName = ? AND ContactNumber = ? OR StreetAddress = ? AND City = ? AND State = ? AND ZIPCode = ?", @lastName, @phoneNumber, @streetAddress, @city, @state, @zipCode)
      if(!@customer.blank?)
      @reviewer = SubscribedUser.find_by_sql("select user.*, cust.ID as 'CustomerID', rev.ID as 'ReviewID' 
                  from SubscribedUsers user join Reviews rev on user.ID = rev.UserID join Customers cust on cust.ID = rev.CustomerID
                  where cust.ID IN (" + @customer.all.collect {|cust| cust.ID}.join(',') + ")")          
      end
      
      if(!@reviewer.blank?)
          @reviewer.each do |revUser|
            if(revUser.ID == session[:user_id])
              @currentUser = true
              @reviewerID = revUser.ID
              @reviewID = revUser.ReviewID 
            else
              @currentUser = false
            end
          end
        end
      
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
      @taxAssessment = number_to_currency(long.text, :unit => "$")     
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
      @lastSoldPrice = number_to_currency(long.text, :unit => "$")   
    end         
  end
end