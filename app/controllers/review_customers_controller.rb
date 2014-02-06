class ReviewCustomersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def AddReviews
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    if(!session[:user_id])
      #redirect_to nicks_list_Index_url, flash:{:hidFirstName => params[:hidFirstName], :hidLastName => params[:hidLastName], :hidPhoneNumber => params[:hidPhoneNumber], :hidStreetAddress => params[:hidStreetAddress], :hidselectCity => params[:hidselectCity], :hidZipCode => params[:hidZipCode], :redirectUrl => review_customers_AddReviews_url}
      redirect_to nicks_list_Index_url, flash:{:hidFirstName => params[:txtFirstName], :hidLastName => params[:txtLastName], :hidPhoneNumber => params[:txtPhoneNumber], :hidStreetAddress => params[:txtStreetAddress], :hidselectCity => params[:selectCity], :hidselectState => params[:selectState], :hidZipCode => params[:txtZipCode], :redirectUrl => customer_search_GetDetails_url}
    else

      @reviewQuestion = ReviewQuestion.all

      #if(!flash[:hidFirstName].blank?)
      #  params[:hidFirstName] = flash[:hidFirstName]
      #  params[:hidLastName] = flash[:hidLastName]
      #  params[:hidPhoneNumber] = flash[:hidPhoneNumber]
      #  params[:hidStreetAddress] = flash[:hidStreetAddress]
      #  params[:hidselectCity] = flash[:hidselectCity]
      #  params[:hidselectState] = flash[:hidselectState]
      #  params[:hidZipCode] = flash[:hidZipCode]
      #end

      @firstName = params[:hidFirstName]
      @lastName = params[:hidLastName]
      @phoneNumber = params[:hidPhoneNumber]
      @streetAddress = params[:hidStreetAddress]
      #@citystateVal = params[:hidselectCity]
      @zipCode = params[:hidZipCode]
      #@city = ""
      #@state = ""
      #if(!@citystateVal.blank?)
      #  @citystateValSplit = @citystateVal.split(',')
      #  @city = @citystateValSplit.at(0).strip()
      #  @state = @citystateValSplit.at(1).strip()
      #end
      
      @city = params[:hidselectCity]
      @state = params[:hidselectState]
      
      @reviewCount = params[:hidReviewCount]

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
        @reviewer = SubscribedUser.find_by_sql("select user.id, cust.id as 'CustomerID', rev.id as 'ReviewID', rev.DateCreated
                  from subscribed_users user join reviews rev on user.id  = rev.UserID
                  join customer_searches cust on cust.id= rev.CustomerSearchID

                  where cust.id IN ('" + @custoemrIDs.to_s + "')")
      end

      if(!@reviewer.blank?)
        @reviewer.each do |revUser|
          if(revUser.id == session[:user_id])
            @reviewerID = revUser.id
            @reviewID = revUser.ReviewID
            @reviewCount = @reviewer.length
            redirect_to review_customers_UpdateReviews_url, flash:{:hidFirstName => @firstName, :hidLastName => @lastName, :hidPhoneNumber => @phoneNumber, :hidStreetAddress => @streetAddress, :hidselectCity => @city, :hidselectState => @state, :hidZipCode => @zipCode, :hidReviewerID => @reviewerID, :hidReviewID => @reviewID, :hidReviewCount => @reviewCount}
          end
        end
      end
    end
  end

  def AddReviewData
    #@reviewQuestion = ReviewQuestion.all

    currentTime = Time.new
    time = currentTime.strftime("%Y-%m-%d %H:%M:%S")

    @firstName = params[:hidFirstName]
    @lastName = params[:hidLastName]
    @phoneNumber = params[:hidPhoneNumber]
    @streetAddress = params[:hidStreetAddress]
    @zipCode = params[:hidZipCode]
    #@citystateVal = params[:hidselectCity]
    #@city = ""
    #@state = ""
    #if(!@citystateVal.blank?)
    #  @citystateValSplit = @citystateVal.split(',')
    #  @city = @citystateValSplit.at(0).strip()
    #  @state = @citystateValSplit.at(1).strip()
    #end
    @city = params[:hidselectCity]
    @state = params[:hidselectState]
    @customer = CustomerSearch.find_by_sql("select cs.id from customer_searches cs
                                  join customer_addresses ca on cs.AddressID = ca.id
                                  join customer_phones cp on cs.id = cp.CustomerSearchID
                                  where (cs.LastName = '" + @lastName + "' AND cp.ContactNumber = '" + @phoneNumber + "') OR (ca.StreetAddress = '" + @streetAddress + "' AND ca.City = '" + @city + "' AND ca.State = '" + @state + "' AND ca.ZipCode = '" + @zipCode + "')")
    @userID = session[:user_id]
    if(!@customer.blank? && @customer.length > 0)

      #@review = Review.find_by(UserID: @userID)
      #if(@review.blank?)
      @review = Review.new(UserID: @userID, CustomerSearchID: @customer[0].id, IsPublished: 0, IsApproved: 0, DateCreated: time, DateUpdated: time)
      @review.save
      #end

      @quesComment1 = params[:quesComment1]
      @radYesNo1 = params[:radYesNo1]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 1, Comments: @quesComment1, IsYes: @radYesNo1, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @radYesNo2 = params[:radYesNo2]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 2, Comments: "", IsYes: @radYesNo2, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @radYesNo3 = params[:radYesNo3]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 3, Comments: "", IsYes: @radYesNo3, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @radYesNo4 = params[:radYesNo4]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 4, Comments: "", IsYes: @radYesNo4, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @radYesNo5 = params[:radYesNo5]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 5, Comments: "", IsYes: @radYesNo5, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @radYesNo6 = params[:radYesNo6]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 6, Comments: "", IsYes: @radYesNo6, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @radYesNo7 = params[:radYesNo7]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 7, Comments: "", IsYes: @radYesNo7, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @quesComment8 = params[:quesComment8]
      @radYesNo8 = params[:radYesNo8]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 8, Comments: @quesComment8, IsYes: @radYesNo8, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @quesComment9 = params[:quesComment9]
      @radYesNo9 = params[:radYesNo9]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 9, Comments: @quesComment9, IsYes: @radYesNo9, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @quesComment10 = params[:quesComment10]
      @radYesNo10 = params[:radYesNo10]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 10, Comments: @quesComment10, IsYes: @radYesNo10, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @quesComment11 = params[:quesComment11]
      @radYesNo11 = params[:radYesNo11]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 11, Comments: @quesComment11, IsYes: @radYesNo11, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @quesComment12 = params[:quesComment12]
      @radYesNo12 = params[:radYesNo12]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 12, Comments: @quesComment12, IsYes: @radYesNo12, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @quesComment13 = params[:quesComment13]
      @radYesNo13 = params[:radYesNo13]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 13, Comments: @quesComment13, IsYes: @radYesNo13, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @quesComment14 = params[:quesComment14]
      @radYesNo14 = params[:radYesNo14]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 14, Comments: @quesComment14, IsYes: @radYesNo14, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @quesComment15 = params[:quesComment15]
      @radYesNo15 = params[:radYesNo15]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 15, Comments: @quesComment15, IsYes: @radYesNo15, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @quesComment16 = params[:quesComment16]
      @radYesNo16 = params[:radYesNo16]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 16, Comments: @quesComment16, IsYes: @radYesNo16, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @quesComment17 = params[:quesComment17]
      @reviewAnswer = ReviewAnswer.new(ReviewID: @review.id, QuestionID: 17, Comments: @quesComment17, IsYes: @radYesNo17, DateCreated: time, DateUpdated: time)
      @reviewAnswer.save

      @customerReviewJoin = CustomerReviewJoin.find_by(CustomerSearchID: @customer[0].id, UserID: @userID)
      if(!@customerReviewJoin.blank?)
      @customerReviewJoin.IsReviewGiven = 1
      @customerReviewJoin.DateCreated = time
      @customerReviewJoin.DateUpdated = time
      @customerReviewJoin.save
      else
        @customerReviewJoin = CustomerReviewJoin.new(CustomerSearchID: @customer[0].id, UserID: @userID, IsReviewGiven: 1, IsRequestSent: 0, DateCreated: time, DateUpdated: time)
      @customerReviewJoin.save
      end

      @subscribedUser = SubscribedUser.find_by(ID: @userID)

      @userfirstName = @subscribedUser.FirstName
      @userlastName = @subscribedUser.LastName
      @userEmail = @subscribedUser.EmailID

      mail_to_admin = UserMailer.ReviewAdminNotification(@userfirstName, @userlastName, @userEmail, @firstName, @lastName, @phoneNumber, @streetAddress, @zipCode, @citystateVal)
      mail_to_admin.deliver

      mail_to_user = UserMailer.ReviewUserNotification(@userfirstName, @userlastName, @userEmail, @firstName, @lastName, @phoneNumber, @streetAddress, @zipCode, @citystateVal)
    mail_to_user.deliver
    end
    #redirect_to customer_search_ViewSearchResultPage_url, flash:{:hidFirstName => params[:hidFirstName], :hidLastName => params[:hidLastName], :hidPhoneNumber => params[:hidPhoneNumber], :hidStreetAddress => params[:hidStreetAddress], :hidselectCity => params[:hidselectCity], :hidZipCode => params[:hidZipCode]}, :notice => "Review added successfully!"
    redirect_to customer_search_ViewSearchResultPage_url, flash:{:hidFirstName => params[:hidFirstName], :hidLastName => params[:hidLastName], :hidPhoneNumber => params[:hidPhoneNumber], :hidStreetAddress => params[:hidStreetAddress], :hidselectCity => params[:hidselectCity], :hidselectState => params[:hidselectState], :hidZipCode => params[:hidZipCode]}, :notice => "Review added successfully!"
  end

  def ReadReviews
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    if(!session[:user_id])
      #redirect_to nicks_list_Index_url, flash:{:hidFirstName => params[:hidFirstName], :hidLastName => params[:hidLastName], :hidPhoneNumber => params[:hidPhoneNumber], :hidStreetAddress => params[:hidStreetAddress], :hidselectCity => params[:hidselectCity], :hidZipCode => params[:hidZipCode], :hidReviewerID => params[:hidReviewerID], :hidReviewID => params[:hidReviewID], :hidReviewCount => params[:hidReviewCount], :redirectUrl => review_customers_ReadReviews_url}
      redirect_to nicks_list_Index_url, flash:{:hidFirstName => params[:txtFirstName], :hidLastName => params[:txtLastName], :hidPhoneNumber => params[:txtPhoneNumber], :hidStreetAddress => params[:txtStreetAddress], :hidselectCity => params[:selectCity], :hidselectState => params[:selectState], :hidZipCode => params[:txtZipCode], :redirectUrl => customer_search_GetDetails_url}
    else

      #if(!flash[:hidFirstName].blank?)
      #  params[:hidFirstName] = flash[:hidFirstName]
      #  params[:hidLastName] = flash[:hidLastName]
      #  params[:hidPhoneNumber] = flash[:hidPhoneNumber]
      #  params[:hidStreetAddress] = flash[:hidStreetAddress]
      #  params[:hidselectCity] = flash[:hidselectCity]
      #  params[:hidselectState] = flash[:hidselectState]
      #  params[:hidZipCode] = flash[:hidZipCode]
      #  params[:hidReviewerID] = flash[:hidReviewerID]
      #  params[:hidReviewID] = flash[:hidReviewID]
      #  params[:hidReviewCount] = flash[:hidReviewCount]
      #  params[:hidCurrentIndex] = flash[:hidCurrentIndex]
      #  params[:hidReviewerID] = flash[:hidReviewerID]
      #  params[:hidReviewID] = flash[:hidReviewID]
      #end

      @firstName = params[:hidFirstName]
      @lastName = params[:hidLastName]
      @phoneNumber = params[:hidPhoneNumber]
      @streetAddress = params[:hidStreetAddress]
      #@citystateVal = params[:hidselectCity]
      @zipCode = params[:hidZipCode]
      @city = params[:hidselectCity]
      @state = params[:hidselectState]
      #@city = ""
      #@state = ""
      #if(!@citystateVal.blank?)
      #  @citystateValSplit = @citystateVal.split(',')
      #  @city = @citystateValSplit.at(0).strip()
      #  @state = @citystateValSplit.at(1).strip()
      #end
      if(params[:hidCurrentIndex].blank?)
        @currentIndex = 0
      else
        @currentIndex = params[:hidCurrentIndex]
      end
      @reviewerID = params[:hidReviewerID]
      @reviewID = params[:hidReviewID]
      @reviewCount = params[:hidReviewCount]
      @reviewQuestion = ReviewQuestion.all

      if(!@reviewID.blank? && !@reviewerID.blank?)

        @reviewDetails = CustomerSearch.find_by_sql("select cust.FirstName, cust.LastName, custadd.*
                      from customer_addresses custadd join customer_searches cust on cust.AddressID = custadd.id
                      join reviews rev on cust.ID  = rev.CustomerSearchID
                      where rev.id = '" + @reviewID.to_s + "'")

        @revfirstName = @reviewDetails[0].FirstName
        @revlastName = @reviewDetails[0].LastName
        @revstreetAddress = @reviewDetails[0].StreetAddress
        #@revcitystateVal = @reviewDetails[0].City + ', ' + @reviewDetails[0].State
        @city = @reviewDetails[0].City
        @state = @reviewDetails[0].State
        @revzipCode = @reviewDetails[0].ZipCode
        @revphoneNumber = @phoneNumber

        @review = Review.find_by(ID: @reviewID)
        @reviewAnswers = ReviewAnswer.where("ReviewID = (?)", @reviewID)
      #@reviewer = SubscribedUser.find_by(ID: @reviewerID)
      #@reviewerAdd = UserAddressDetail.find_by(UserID: @reviewerID)
      end
    end
  end

  def PrevNextReview
    if(!params[:hidFirstName].blank?)
      @firstName = params[:hidFirstName]
      @lastName = params[:hidLastName]
      @phoneNumber = params[:hidPhoneNumber]
      @streetAddress = params[:hidStreetAddress]
      @zipCode = params[:hidZipCode]
      #@citystateVal = params[:hidselectCity]
      #citystateVal = params[:hidselectCity].to_str.split(',')
      #@city = citystateVal.at(0).strip()
      #@state = citystateVal.at(1).strip()
      @city = params[:hidselectCity]
      @state = params[:hidselectState]
      @currentIndex = params[:hidCurrentIndex]
      #@actionVal = params[:hidActionVal]
    end

    #if(@actionVal == 'Previous')
    #@currentIndex = @currentIndex.to_i - 1
    #else
    #@currentIndex = @currentIndex.to_i + 1
    #end
    @currentIndex = @currentIndex.to_i
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
      @reviewer = SubscribedUser.find_by_sql("select user.id, cust.ID as 'CustomerID', rev.id as 'ReviewID', rev.DateCreated
                  from subscribed_users user join reviews rev on user.id  = rev.UserID
                  join customer_searches cust on cust.id= rev.CustomerSearchID
                  where rev.IsApproved = '1' and rev.IsPublished = '1' and cust.id IN ('" + @custoemrIDs.to_s + "') order by rev.DateCreated desc")

      @reviewID = @reviewer[@currentIndex.to_i-1].ReviewID
      @reviewerID = @reviewer[@currentIndex.to_i-1].id

    #redirect_to review_customers_ReadReviews_url, flash:{:hidFirstName => params[:hidFirstName], :hidLastName => params[:hidLastName], :hidPhoneNumber => params[:hidPhoneNumber], :hidStreetAddress => params[:hidStreetAddress], :hidselectCity => params[:hidselectCity], :hidZipCode => params[:hidZipCode], :hidReviewCount => @reviewer.length, :hidCurrentIndex => @currentIndex, :hidReviewID => @reviewID, :hidReviewerID => @reviewerID}

    end

  end

  def TermsConditions
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    if(!session[:user_id])
      #redirect_to nicks_list_Index_url, flash:{:hidFirstName => params[:hidFirstName], :hidLastName => params[:hidLastName], :hidPhoneNumber => params[:hidPhoneNumber], :hidStreetAddress => params[:hidStreetAddress], :hidselectCity => params[:hidselectCity], :hidZipCode => params[:hidZipCode], :redirectUrl => customer_search_GetDetails_url}
      redirect_to nicks_list_Index_url, flash:{:hidFirstName => params[:txtFirstName], :hidLastName => params[:txtLastName], :hidPhoneNumber => params[:txtPhoneNumber], :hidStreetAddress => params[:txtStreetAddress], :hidselectCity => params[:selectCity], :hidselectState => params[:selectState], :hidZipCode => params[:txtZipCode], :redirectUrl => customer_search_ViewSearchResultPage_url}
    else

      @siteContent = SiteContent.find_by(PageCode: 105)
      if(!@siteContent.blank?)
        @content = @siteContent.Content.html_safe
        @title = @siteContent.Title.html_safe
      end

      @firstName = params[:hidFirstName]
      @lastName = params[:hidLastName]
      @phoneNumber = params[:hidPhoneNumber]
      @streetAddress = params[:hidStreetAddress]
      #@citystateVal = params[:hidselectCity]
      @city = params[:hidselectCity]
      @state = params[:hidselectState]
      @zipCode = params[:hidZipCode]
      @reviewerID = params[:hidReviewerID]
      @reviewID = params[:hidReviewID]
      @reviewCount = params[:hidReviewCount]
      @redirectUrl = params[:hidRedirectUrl]
      @currentIndex = params[:hidCurrentIndex]
    end
  end

  def UpdateReviews
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    if(!session[:user_id])
      #redirect_to nicks_list_Index_url, flash:{:hidFirstName => params[:hidFirstName], :hidLastName => params[:hidLastName], :hidPhoneNumber => params[:hidPhoneNumber], :hidStreetAddress => params[:hidStreetAddress], :hidselectCity => params[:hidselectCity], :hidZipCode => params[:hidZipCode], :hidReviewerID => params[:hidReviewerID], :hidReviewID => params[:hidReviewID], :hidReviewCount => params[:hidReviewCount], :redirectUrl => review_customers_UpdateReviews_url}
      redirect_to nicks_list_Index_url, flash:{:hidFirstName => params[:txtFirstName], :hidLastName => params[:txtLastName], :hidPhoneNumber => params[:txtPhoneNumber], :hidStreetAddress => params[:txtStreetAddress], :hidselectState => params[:selectCity], :hidselectSate => params[:hidselectState], :hidZipCode => params[:txtZipCode], :redirectUrl => customer_search_GetDetails_url}
    else

      if(!flash[:hidFirstName].blank?)
        params[:hidFirstName] = flash[:hidFirstName]
        params[:hidLastName] = flash[:hidLastName]
        params[:hidPhoneNumber] = flash[:hidPhoneNumber]
        params[:hidStreetAddress] = flash[:hidStreetAddress]
        params[:hidselectCity] = flash[:hidselectCity]
        params[:hidselectState] = flash[:hidselectState]
        params[:hidZipCode] = flash[:hidZipCode]
        params[:hidReviewerID] = flash[:hidReviewerID]
        params[:hidReviewID] = flash[:hidReviewID]
        params[:hidReviewCount] = flash[:hidReviewCount]
      end

      @firstName = params[:hidFirstName]
      @lastName = params[:hidLastName]
      @phoneNumber = params[:hidPhoneNumber]
      @streetAddress = params[:hidStreetAddress]
      #@citystateVal = params[:hidselectCity]
      @zipCode = params[:hidZipCode]
      #@city = ""
      #@state = ""
     # if(!@citystateVal.blank?)
      #  @citystateValSplit = @citystateVal.split(',')
      #  @city = @citystateValSplit.at(0).strip()
      #  @state = @citystateValSplit.at(1).strip()
      #end
      
      @city = params[:hidselectCity]
      @state = params[:hidselectState]
      
      @reviewerID = params[:hidReviewerID]
      @reviewID = params[:hidReviewID]
      @reviewCount = params[:hidReviewCount]
      @reviewQuestion = ReviewQuestion.all

      if(!@reviewID.blank? && !@reviewerID.blank?)
        @reviewDetails = CustomerSearch.find_by_sql("select cust.FirstName, cust.LastName, custadd.*
                      from customer_addresses custadd join customer_searches cust on cust.AddressID = custadd.id
                      join reviews rev on cust.id  = rev.CustomerSearchID
                      where rev.id = '" + @reviewID.to_s + "'")

        @revfirstName = @reviewDetails[0].FirstName
        @revlastName = @reviewDetails[0].LastName
        @revstreetAddress = @reviewDetails[0].StreetAddress
        #@revcitystateVal = @reviewDetails[0].City + ', ' + @reviewDetails[0].State
        @city = @reviewDetails[0].City
        @state = @reviewDetails[0].State
        @revzipCode = @reviewDetails[0].ZipCode
        @revphoneNumber = @phoneNumber
        @review = Review.find_by(ID: @reviewID)
        @reviewAnswers = ReviewAnswer.where("ReviewID = (?)", @reviewID)
      #@reviewer = SubscribedUser.find_by(ID: @reviewerID)
      #@reviewerAdd = UserAddressDetail.find_by(UserID: @reviewerID)
      end
    end
  end

  def UpdateReviewData

    #@reviewQuestion = ReviewQuestion.all

    currentTime = Time.new
    time = currentTime.strftime("%Y-%m-%d %H:%M:%S")

    @firstName = params[:hidFirstName]
    @lastName = params[:hidLastName]
    @phoneNumber = params[:hidPhoneNumber]
    @streetAddress = params[:hidStreetAddress]
    @zipCode = params[:hidZipCode]
    #@citystateVal = params[:hidselectCity]
    @city = params[:hidselectCity]
    @state = params[:hidselectState]
    #if(!@citystateVal.blank?)
    #  @citystateValSplit = @citystateVal.split(',')
    #  @city = @citystateValSplit.at(0).strip()
    #  @state = @citystateValSplit.at(1).strip()
    #end

    #@customer = Customer.find_by(FirstName: @firstName, LastName: @lastName, ContactNumber: @phoneNumber, StreetAddress: @streetAddress, City: @city, State: @state, ZIPCode: @zipCode)
    #if(@customer.blank?)
    #@customer = Customer.new(FirstName: @firstName, MiddleName: "", LastName: @lastName, ContactNumber: @phoneNumber, StreetAddress: @streetAddress, City: @city, State: @state, ZIPCode: @zipCode, DateCreated: time, DateUpdated: time)
    #@customer.save
    #end

    @userID = session[:user_id]
    @reviewID = params[:hidReviewID]

    @quesComment1 = params[:quesComment1]
    @radYesNo1 = params[:radYesNo1]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 1)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 1)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = @quesComment1
    @reviewAnswerUpdate.IsYes = @radYesNo1
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @radYesNo2 = params[:radYesNo2]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 2)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 2)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = ""
    @reviewAnswerUpdate.IsYes = @radYesNo2
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @radYesNo3 = params[:radYesNo3]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 3)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 3)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = ""
    @reviewAnswerUpdate.IsYes = @radYesNo3
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @radYesNo4 = params[:radYesNo4]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 4)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 4)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = ""
    @reviewAnswerUpdate.IsYes = @radYesNo4
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @radYesNo5 = params[:radYesNo5]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 5)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 5)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = ""
    @reviewAnswerUpdate.IsYes = @radYesNo5
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @radYesNo6 = params[:radYesNo6]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 6)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 6)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = ""
    @reviewAnswerUpdate.IsYes = @radYesNo6
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @radYesNo7 = params[:radYesNo7]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 7)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 7)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = ""
    @reviewAnswerUpdate.IsYes = @radYesNo7
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @quesComment8 = params[:quesComment8]
    @radYesNo8 = params[:radYesNo8]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 8)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 8)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = @quesComment8
    @reviewAnswerUpdate.IsYes = @radYesNo8
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @quesComment9 = params[:quesComment9]
    @radYesNo9 = params[:radYesNo9]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 9)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 9)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = @quesComment9
    @reviewAnswerUpdate.IsYes = @radYesNo9
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @quesComment10 = params[:quesComment10]
    @radYesNo10 = params[:radYesNo10]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 10)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 10)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = @quesComment10
    @reviewAnswerUpdate.IsYes = @radYesNo10
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @quesComment11 = params[:quesComment11]
    @radYesNo11 = params[:radYesNo11]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 11)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 11)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = @quesComment11
    @reviewAnswerUpdate.IsYes = @radYesNo11
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @quesComment12 = params[:quesComment12]
    @radYesNo12 = params[:radYesNo12]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 12)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 12)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = @quesComment12
    @reviewAnswerUpdate.IsYes = @radYesNo12
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @quesComment13 = params[:quesComment13]
    @radYesNo13 = params[:radYesNo13]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 13)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 13)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = @quesComment13
    @reviewAnswerUpdate.IsYes = @radYesNo13
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @quesComment14 = params[:quesComment14]
    @radYesNo14 = params[:radYesNo14]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 14)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 14)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = @quesComment14
    @reviewAnswerUpdate.IsYes = @radYesNo14
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @quesComment15 = params[:quesComment15]
    @radYesNo15 = params[:radYesNo15]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 15)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 15)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = @quesComment15
    @reviewAnswerUpdate.IsYes = @radYesNo15
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @quesComment16 = params[:quesComment16]
    @radYesNo16 = params[:radYesNo16]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 16)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 16)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = @quesComment16
    @reviewAnswerUpdate.IsYes = @radYesNo16
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    @quesComment17 = params[:quesComment17]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 17)

    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 17)
    if(!@reviewAnswer.blank?)
    @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(id: @reviewAnswerUpdate.id, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
    @reviewAnswer.save

    @reviewAnswerUpdate.Comments = @quesComment17
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    redirect_to customer_search_ViewSearchResultPage_url, flash:{:hidFirstName => params[:hidFirstName], :hidLastName => params[:hidLastName], :hidPhoneNumber => params[:hidPhoneNumber], :hidStreetAddress => params[:hidStreetAddress], :hidselectCity => params[:hidselectCity], :hidselectCity => params[:hidselectState], :hidZipCode => params[:hidZipCode]}, :notice => "Review updated successfully!"
  #redirect_to customer_search_GetDetails_url, flash:{:hidFirstName => params[:hidFirstName], :hidLastName => params[:hidLastName], :hidPhoneNumber => params[:hidPhoneNumber], :hidStreetAddress => params[:hidStreetAddress], :hidselectCity => params[:hidselectCity], :hidZipCode => params[:hidZipCode]}, :notice => "Review updated successfully!"
  end

end
