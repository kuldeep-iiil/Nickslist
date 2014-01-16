require 'rexml/document'

class CustomerSearchController < ApplicationController
  include REXML
  include ActionView::Helpers::NumberHelper
  skip_before_action :verify_authenticity_token
  def GetDetails
    if(!session[:user_id])
      redirect_to nicks_list_Index_url, flash:{:hidFirstName => params[:txtFirstName], :hidLastName => params[:txtLastName], :hidPhoneNumber => params[:txtPhoneNumber], :hidStreetAddress => params[:txtStreetAddress], :hidselectCity => params[:selectCity], :hidZipCode => params[:txtZipCode], :redirectUrl => customer_search_ViewSearchResultPage_url}
    else

      if(!params[:hidFirstName].blank?)
        params[:txtFirstName] = params[:hidFirstName]
        params[:txtLastName] = params[:hidLastName]
        params[:txtPhoneNumber] = params[:hidPhoneNumber]
        params[:txtStreetAddress] = params[:hidStreetAddress]
        params[:selectCity] = params[:hidselectCity]
        params[:txtZipCode] = params[:hidZipCode]
      end

      if(params[:txtStreetAddress].strip != '' && params[:selectCity].strip != '' && params[:txtZipCode].strip != '')
        @firstName = params[:txtFirstName]
        @lastName = params[:txtLastName]
        @phoneNumber = params[:txtPhoneNumber]
        @streetAddress = params[:txtStreetAddress]
        @zipCode = params[:txtZipCode]
        @citystateVal = params[:selectCity]

        session[:hidFirstName] = nil
        session[:hidLastName] = nil
        session[:hidPhoneNumber] = nil
        session[:hidStreetAddress] = nil
        session[:hidselectCity] = nil
        session[:hidZipCode] = nil
        session[:indexVal] = nil

        session[:hidFirstName] = @firstName
        session[:hidLastName] = @lastName
        session[:hidPhoneNumber] = @phoneNumber
        session[:hidStreetAddress] = @streetAddress
        session[:hidselectCity] = @citystateVal
        session[:hidZipCode] = @zipCode
        session[:indexVal] = '0'

        citystateVal = params[:selectCity].to_str.split(',')
        @city = citystateVal.at(0).strip()
        @state = citystateVal.at(1).strip()
        #streetAddress=params[:txtStreetAddress].gsub('#','' )
        streetAddress=params[:txtStreetAddress].gsub(' ', '+')
        #streetAddress=streetAddress.gsub(' ', '+')

        #citystatezip=params[:selectCity] + '%2C+' + params[:selectState] + '%2C+' + params[:txtZipCode]
        city=params[:selectCity].gsub(' ', '+')
        citystatezip=city + '%2C+' + params[:txtZipCode]
        citystatezip=citystatezip.gsub(', ','%2C')

        currentUserID = session[:user_id]
        #Get Reviews count for searched person
        #@customer = Customer.find_by(LastName: @lastName, ContactNumber: @phoneNumber, StreetAddress: @streetAddress, City: @city, State: @state, ZIPCode: @zipCode)

        currentTime = Time.new
        time = currentTime.strftime("%Y-%m-%d %H:%M:%S")

        #Add customer search log for reporting
        @customerSearch = CustomerSearch.find_by_sql("select cs.id from customer_searches cs
                                  join customer_addresses ca on cs.AddressID = ca.id
                                  join customer_phones cp on cs.id = cp.CustomerSearchID
                                  where cs.LastName = '" + @lastName + "' AND cp.ContactNumber = '" + @phoneNumber + "' AND ca.StreetAddress = '" + @streetAddress + "' AND ca.City = '" + @city + "' AND ca.State = '" + @state + "' AND ca.ZipCode = '" + @zipCode + "'")
        if(@customerSearch.blank?)
          @customerAddress = CustomerAddress.find_by(StreetAddress: @streetAddress, City: @city, State: @state, ZipCode: @zipCode)
          if(@customerAddress.blank?)
            @customerAddress = CustomerAddress.new(StreetAddress: @streetAddress, City: @city, State: @state, ZipCode: @zipCode, DateCreated: time, DateUpdated: time)
          @customerAddress.save
          end

          @customerAdded = CustomerSearch.new(FirstName: @firstName, LastName: @lastName, AddressID: @customerAddress.id, SearchDate: time)
          @customerAdded.save

          @customerPhone = CustomerPhone.find_by(ContactNumber: @phoneNumber, CustomerSearchID: @customerAdded.id)
          if(@customerPhone.blank?)
            @customerPhone = CustomerPhone.new(CustomerSearchID: @customerAdded.id, ContactNumber: @phoneNumber, DateCreated: time)
          @customerPhone.save
          end
        end

        @customer = CustomerSearch.find_by_sql("select cs.id from customer_searches cs
                                  join customer_addresses ca on cs.AddressID = ca.id
                                  join customer_phones cp on cs.id = cp.CustomerSearchID
                                  where (cs.LastName = '" + @lastName + "' AND cp.ContactNumber = '" + @phoneNumber + "') OR (ca.StreetAddress = '" + @streetAddress + "' AND ca.City = '" + @city + "' AND ca.State = '" + @state + "' AND ca.ZipCode = '" + @zipCode + "')")

        if(!@customer.blank?)
          if(@customer.length > 1)
            @custoemrIDs = @customer.collect {|cust| cust.id}.join(',')
          else
            @custoemrIDs = @customer[0].id
          end

          @reviewCount = Review.where(CustomerSearchID: @custoemrIDs, IsApproved: 1, IsPublished: 1).count
          @isUser = Review.where(CustomerSearchID: @custoemrIDs.to_s, UserID: currentUserID)
          @reviewer = SubscribedUser.find_by_sql("select user.id, cust.id as 'CustomerID', rev.ID as 'ReviewID', rev.DateCreated
                  from subscribed_users user join reviews rev on user.id  = rev.UserID
                  join customer_searches cust on cust.id= rev.CustomerSearchID
                  where rev.IsApproved = '1' and rev.IsPublished = '1' and cust.id IN ('" + @custoemrIDs.to_s + "') order by rev.DateCreated desc limit 0, 9")

          @currentreviewer = SubscribedUser.find_by_sql("select user.id, cust.id as 'CustomerID', rev.ID as 'ReviewID', rev.DateCreated
                  from subscribed_users user join reviews rev on user.id  = rev.UserID
                  join customer_searches cust on cust.id= rev.CustomerSearchID

                  where rev.UserID = '" + session[:user_id].to_s + "' and cust.id IN ('" + @custoemrIDs.to_s + "') order by rev.DateCreated desc limit 0, 9")

          @customerAddress = CustomerAddress.find_by(StreetAddress: @streetAddress, City: @city, State: @state, ZipCode: @zipCode)
          if(!@customerAddress.blank?)
            @mljudgement = MlJudgements.find_by(AddressID: @customerAddress.id)
            if(!@mljudgement.blank?)
              @mlComments = @mljudgement.MLJudgements
            end

            @courtProceeding = CourtProceedings.find_by(AddressID: @customerAddress.id)
            if(!@courtProceeding.blank?)
              @caseType = @courtProceeding.CaseType
              @hearingDate = @courtProceeding.CourtHearingDate.strftime('%m/%d/%Y')
              @caseFiledDate = @courtProceeding.DateFiled.strftime('%m/%d/%Y')
              @amountAwarded = number_to_currency(@courtProceeding.AmountAwarded, :unit => "$")
              @defendant = Defendants.find_by(id: @courtProceeding.DefendantID)
              if(!@defendant.blank?)
                @defFirstName = @defendant.FirstName
                @defLastName = @defendant.LastName
                @defAddress = @defendant.StreetAddress
                @defCityState = @defendant.City + ", " + @defendant.State
                @defZipcode = @defendant.ZipCode
              end
              @plaintiff = Plaintiffs.find_by(id: @courtProceeding.PlaintiffID)
              if(!@plaintiff.blank?)
                @plainFirstName = @plaintiff.FirstName
                @plainLastName = @plaintiff.LastName
                @plainAddress = @plaintiff.StreetAddress
                @plainCityState = @plaintiff.City + ", " + @plaintiff.State
                @plainZipcode = @plaintiff.ZipCode
              end
            end

            @lien = Liens.find_by(AddressID: @customerAddress.id)
            if(!@lien.blank?)
              @dateIssued = @lien.DateIssued.strftime('%m/%d/%Y')
              @amount = number_to_currency(@lien.Amount, :unit => "$")
              @grantor = Grantors.find_by(id: @lien.GrantorID)
              if(!@grantor.blank?)
                @grantFirstName = @grantor.FirstName
                @grantLastName = @grantor.LastName
                @grantAddress = @grantor.StreetAddress
                @grantCityState = @grantor.City + ", " + @grantor.State
                @grantZipcode = @grantor.ZipCode
              end
            end

          end
        end

        if(@customerSearch.blank?)
        searchID = @customerAdded.id
        else
        searchID = @customerSearch[0].id
        end

        @customerSearchLog = CustomerSearchLog.new(CustomerSearchID: searchID, SearchedDateTime: time)
        @customerSearchLog.save

        @customerReviewJoin = CustomerReviewJoin.find_by(CustomerSearchID: searchID, UserID: currentUserID)
        if(@customerReviewJoin.blank?)
          if(!@currentreviewer.blank?)
            @customerReviewJoin = CustomerReviewJoin.new(CustomerSearchID: searchID, UserID: currentUserID, IsReviewGiven: 1, IsRequestSent: 0, DateCreated: time, DateUpdated: time)
          @customerReviewJoin.save
          else
            @customerReviewJoin = CustomerReviewJoin.new(CustomerSearchID: searchID, UserID: currentUserID, IsReviewGiven: 0, IsRequestSent: 0, DateCreated: time, DateUpdated: time)
          @customerReviewJoin.save
          end
        end

        #if(!@reviewer.blank?)
        #@currentUser = false
        #@reviewer.each do |revUser|
        # if(revUser.id == currentUserID)
        # @currentUser = true
        #@reviewerID = revUser.id
        #@reviewID = revUser.ReviewID
        #end
        #end
        #end
        if(!@isUser.blank?)
          @isUser.each do |revUser|
            @reviewerID = revUser.UserID
            @reviewID = revUser.id
          end
        end

        #Get settings for Terms & Condition page
        @ChkTermsConditions = 1

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

      @siteContent = SiteContent.find_by(PageCode: 105)
      if(!@siteContent.blank?)
        @content = @siteContent.Content.html_safe
        @title = @siteContent.Title.html_safe
      end
    end
  end

  def LoadReviews
    if(!session[:hidFirstName].blank?)
      params[:hidFirstName] = session[:hidFirstName]
      params[:hidLastName] = session[:hidLastName]
      params[:hidPhoneNumber] = session[:hidPhoneNumber]
      params[:hidStreetAddress] = session[:hidStreetAddress]
      params[:hidselectCity] = session[:hidselectCity]
      params[:hidZipCode] = session[:hidZipCode]
    end

    @index = session[:indexVal]
    @index = @index.to_i + 9
    session[:indexVal] = @index

    @firstName = params[:hidFirstName]
    @lastName = params[:hidLastName]
    @phoneNumber = params[:hidPhoneNumber]
    @streetAddress = params[:hidStreetAddress]
    @citystateVal = params[:hidselectCity]
    @zipCode = params[:hidZipCode]
    @city = ""
    @state = ""
    if(!@citystateVal.blank?)
      @citystateValSplit = @citystateVal.split(',')
      @city = @citystateValSplit.at(0).strip()
      @state = @citystateValSplit.at(1).strip()
    end

    if(@firstName != nil && @lastName != nil && @phoneNumber != nil && @streetAddress != nil && @citystateVal != nil && @zipCode != nil)
      @customer = CustomerSearch.find_by_sql("select cs.id from customer_searches cs
                                  join customer_addresses ca on cs.AddressID = ca.id
                                  join customer_phones cp on cs.id = cp.CustomerSearchID
                                  where (cs.LastName = '" + @lastName + "' AND cp.ContactNumber = '" + @phoneNumber + "') OR (ca.StreetAddress = '" + @streetAddress + "' AND ca.City = '" + @city + "' AND ca.State = '" + @state + "' AND ca.ZipCode = '" + @zipCode + "')")
    end
    if(!@customer.blank?)
      if(@customer.length > 1)
        @custoemrIDs = @customer.collect {|cust| cust.id}.join(',')
      else
        @custoemrIDs = @customer[0].id
      end
      @reviewer = SubscribedUser.find_by_sql("select user.id, cust.id as 'CustomerID', rev.ID as 'ReviewID', rev.DateCreated
                  from subscribed_users user join reviews rev on user.id  = rev.UserID
                  join customer_searches cust on cust.id= rev.CustomerSearchID
                  where rev.IsApproved = '1' and rev.IsPublished = '1' and cust.id IN ('" + @custoemrIDs.to_s + "') order by rev.DateCreated desc limit " + @index.to_s + " ,9")
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

  def ViewSearchResultPage
    @firstName = flash[:hidFirstName]
    @lastName = flash[:hidLastName]
    @phoneNumber = flash[:hidPhoneNumber]
    @streetAddress = flash[:hidStreetAddress]
    @cityState = flash[:hidselectCity]
    @zipCode = flash[:hidZipCode]
  end
end