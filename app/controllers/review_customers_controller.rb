class ReviewCustomersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def AddReviews
    if(session[:user_id] == nil)
      session[:redirectPageUrl] = review_customers_AddReviews_url
      session[:hidFirstName] = params[:hidFirstName]
      session[:hidLastName] = params[:hidLastName]
      session[:hidPhoneNumber] = params[:hidPhoneNumber]
      session[:hidStreetAddress] = params[:hidStreetAddress]
      session[:hidselectCity] = params[:hidselectCity]
      session[:hidZipCode] = params[:hidZipCode]
      session[:hidReviewCount] = params[:hidReviewCount]
      redirect_to root_url
    end
    @reviewQuestion = ReviewQuestion.all

    if(!session[:hidFirstName].blank?)      
      params[:hidFirstName] = session[:hidFirstName]
      params[:hidLastName] = session[:hidLastName]
      params[:hidPhoneNumber] = session[:hidPhoneNumber] 
      params[:hidStreetAddress] = session[:hidStreetAddress]
      params[:hidselectCity] = session[:hidselectCity]
      params[:hidZipCode] = session[:hidZipCode]
      params[:hidReviewCount] = session[:hidReviewCount]
      
    end
    
    @firstName = params[:hidFirstName]
    @lastName = params[:hidLastName]
    @phoneNumber = params[:hidPhoneNumber]
    @streetAddress = params[:hidStreetAddress]
    @citystateVal = params[:hidselectCity]
    @zipCode = params[:hidZipCode]
    @city = ""
    @state = ""
    if(!@citystateVal.blank?)
      @city = @citystateVal.at(0).strip()
      @state = @citystateVal.at(1).strip()
    end
    @reviewCount = params[:hidReviewCount]
    
    @customer = Customer.where("LastName = ? AND ContactNumber = ? OR StreetAddress = ? AND City = ? AND State = ? AND ZIPCode = ?", @lastName, @phoneNumber, @streetAddress, @city, @state, @zipCode)
      if(!@customer.blank?)
      @reviewer = SubscribedUser.find_by_sql("select user.*, cust.ID as 'CustomerID', rev.ID as 'ReviewID' 
                  from SubscribedUsers user join Reviews rev on user.ID = rev.UserID join Customers cust on cust.ID = rev.CustomerID
                  where cust.ID IN (" + @customer.all.collect {|cust| cust.ID}.join(',') + ")")          
      end
      
      if(!@reviewer.blank?)
        @reviewer.each do |revUser|
          if(revUser.ID == session[:user_id])
            session[:hidFirstName] = params[:hidFirstName]
            session[:hidLastName] = params[:hidLastName]
            session[:hidPhoneNumber] = params[:hidPhoneNumber]
            session[:hidStreetAddress] = params[:hidStreetAddress]
            session[:hidselectCity] = params[:hidselectCity]
            session[:hidZipCode] = params[:hidZipCode]
            session[:hidReviewerID] = revUser.ID
            session[:hidReviewID] = revUser.ReviewID
            session[:hidReviewCount] = @reviewer.length
            redirect_to review_customers_UpdateReviews_url
          end
        end
      end
    
  end

  def AddReviewData
    if(session[:user_id] == nil)
      redirect_to root_url
    end
    #@reviewQuestion = ReviewQuestion.all

    currentTime = Time.new
    time = currentTime.strftime("%Y-%m-%d %H:%M:%S")

    @firstName = params[:hidFirstName]
    @lastName = params[:hidLastName]
    @phoneNumber = params[:hidPhoneNumber]
    @streetAddress = params[:hidStreetAddress]
    @zipCode = params[:hidZipCode]
    @citystateVal = params[:hidselectCity]
    @city = ""
    @state = ""
    if(!@citystateVal.blank?)
      @citystateVal = @citystateVal.split(',')
      @city = @citystateVal.at(0).strip()
      @state = @citystateVal.at(1).strip()
    end

    @customer = Customer.find_by(FirstName: @firstName, LastName: @lastName, ContactNumber: @phoneNumber, StreetAddress: @streetAddress, City: @city, State: @state, ZIPCode: @zipCode)
    if(@customer.blank?)
      @customer = Customer.new(FirstName: @firstName, MiddleName: "", LastName: @lastName, ContactNumber: @phoneNumber, StreetAddress: @streetAddress, City: @city, State: @state, ZIPCode: @zipCode, DateCreated: time, DateUpdated: time)
    @customer.save
    end

    @userID = session[:user_id]
    @mlandjudgments = params[:textmlandjudgments]
    @otherPublicThirdPartyInfo = params[:textotherPublicThirdPartyInfo]
    #@review = Review.find_by(UserID: @userID)
    #if(@review.blank?)
    @review = Review.new(UserID: @userID, CustomerID: @customer.ID, IsVisible: 0, IsApproved: 0, MLAndJudgments: @mlandjudgments, OtherPublicThirdPartyInfo: @otherPublicThirdPartyInfo, DateCreated: time, DateUpdated: time)
    @review.save
    #end

    @quesComment1 = params[:quesComment1]
    @radYesNo1 = params[:radYesNo1]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 1, Comments: @quesComment1, IsYes: @radYesNo1, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @radYesNo2 = params[:radYesNo2]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 2, Comments: "", IsYes: @radYesNo2, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @radYesNo3 = params[:radYesNo3]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 3, Comments: "", IsYes: @radYesNo3, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @radYesNo4 = params[:radYesNo4]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 4, Comments: "", IsYes: @radYesNo4, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @radYesNo5 = params[:radYesNo5]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 5, Comments: "", IsYes: @radYesNo5, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @radYesNo6 = params[:radYesNo6]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 6, Comments: "", IsYes: @radYesNo6, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @radYesNo7 = params[:radYesNo7]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 7, Comments: "", IsYes: @radYesNo7, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @quesComment8 = params[:quesComment8]
    @radYesNo8 = params[:radYesNo8]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 8, Comments: @quesComment8, IsYes: @radYesNo8, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @quesComment9 = params[:quesComment9]
    @radYesNo9 = params[:radYesNo9]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 9, Comments: @quesComment9, IsYes: @radYesNo9, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save
    
    @quesComment10 = params[:quesComment10]
    @radYesNo10 = params[:radYesNo10]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 10, Comments: @quesComment10, IsYes: @radYesNo10, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @quesComment11 = params[:quesComment11]
    @radYesNo11 = params[:radYesNo11]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 11, Comments: @quesComment11, IsYes: @radYesNo11, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @quesComment12 = params[:quesComment12]
    @radYesNo12 = params[:radYesNo12]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 12, Comments: @quesComment12, IsYes: @radYesNo12, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @quesComment13 = params[:quesComment13]
    @radYesNo13 = params[:radYesNo13]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 13, Comments: @quesComment13, IsYes: @radYesNo13, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @quesComment14 = params[:quesComment14]
    @radYesNo14 = params[:radYesNo14]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 14, Comments: @quesComment14, IsYes: @radYesNo14, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @quesComment15 = params[:quesComment15]
    @radYesNo15 = params[:radYesNo15]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 15, Comments: @quesComment15, IsYes: @radYesNo15, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @quesComment16 = params[:quesComment16]
    @radYesNo16 = params[:radYesNo16]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 16, Comments: @quesComment16, IsYes: @radYesNo16, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    @quesComment17 = params[:quesComment17]
    @reviewAnswer = ReviewAnswer.new(ReviewID: @review.ID, QuestionID: 17, Comments: @quesComment17, IsYes: @radYesNo17, DateCreated: time, DateUpdated: time)
    @reviewAnswer.save

    session[:hidFirstName] = params[:hidFirstName]
    session[:hidLastName] = params[:hidLastName]
    session[:hidPhoneNumber] = params[:hidPhoneNumber]
    session[:hidStreetAddress] = params[:hidStreetAddress]
    session[:hidselectCity] = params[:hidselectCity]
    session[:hidZipCode] = params[:hidZipCode]
    
    redirect_to review_customers_ListReviews_url
  end

  def ReadReviews
    if(session[:user_id] == nil)
      session[:redirectPageUrl] = "review_customers_ReadReviews_url"
      session[:hidFirstName] = params[:hidFirstName]
      session[:hidLastName] = params[:hidLastName]
      session[:hidPhoneNumber] = params[:hidPhoneNumber]
      session[:hidStreetAddress] = params[:hidStreetAddress]
      session[:hidselectCity] = params[:hidselectCity]
      session[:hidZipCode] = params[:hidZipCode]
      redirect_to root_url
    end
    
    if(!session[:hidFirstName].blank?)      
      params[:hidFirstName] = session[:hidFirstName]
      params[:hidLastName] = session[:hidLastName]
      params[:hidPhoneNumber] = session[:hidPhoneNumber] 
      params[:hidStreetAddress] = session[:hidStreetAddress]
      params[:hidselectCity] = session[:hidselectCity]
      params[:hidZipCode] = session[:hidZipCode]
      
    end
    
    @firstName = params[:hidFirstName]
    @lastName = params[:hidLastName]
    @phoneNumber = params[:hidPhoneNumber]
    @streetAddress = params[:hidStreetAddress]
    @citystateVal = params[:hidselectCity]
    @zipCode = params[:hidZipCode]
    @city = ""
    @state = ""
    if(!@citystateVal.blank?)
      @city = @citystateVal.at(0).strip()
      @state = @citystateVal.at(1).strip()
    end
    
    @reviewerID = params[:hidReviewerID]
    @reviewID = params[:hidReviewID]
    @reviewCount = params[:hidReviewCount]
    @reviewQuestion = ReviewQuestion.all
      
    if(!@reviewID.blank? && !@reviewerID.blank?)
        @review = Review.find_by(ID: @reviewID)     
        @reviewAnswers = ReviewAnswer.where("ReviewID = (?)", @reviewID)
        @reviewer = SubscribedUser.find_by(ID: @reviewerID)
        @reviewerAdd = UserAddressDetail.find_by(UserID: @reviewerID)            
    end
        
  end

  def ListReviews
    if(session[:user_id] == nil)
      session[:redirectPageUrl] = "review_customers_ListReviews_url"
      session[:hidFirstName] = params[:hidFirstName]
      session[:hidLastName] = params[:hidLastName]
      session[:hidPhoneNumber] = params[:hidPhoneNumber]
      session[:hidStreetAddress] = params[:hidStreetAddress]
      session[:hidselectCity] = params[:hidselectCity]
      session[:hidZipCode] = params[:hidZipCode]
      redirect_to root_url
    end
    
    if(!session[:hidFirstName].blank?)      
      params[:hidFirstName] = session[:hidFirstName]
      params[:hidLastName] = session[:hidLastName]
      params[:hidPhoneNumber] = session[:hidPhoneNumber] 
      params[:hidStreetAddress] = session[:hidStreetAddress]
      params[:hidselectCity] = session[:hidselectCity]
      params[:hidZipCode] = session[:hidZipCode]
      
    end
    
    @firstName = params[:hidFirstName]
    @lastName = params[:hidLastName]
    @phoneNumber = params[:hidPhoneNumber]
    @streetAddress = params[:hidStreetAddress]
    @citystateVal = params[:hidselectCity]
    @zipCode = params[:hidZipCode]
    @city = ""
    @state = ""
    if(!@citystateVal.blank?)
      @city = @citystateVal.at(0).strip()
      @state = @citystateVal.at(1).strip()
    end

    @customer = Customer.where("LastName = ? AND ContactNumber = ? OR StreetAddress = ? AND City = ? AND State = ? AND ZIPCode = ?", @lastName, @phoneNumber, @streetAddress, @city, @state, @zipCode)
    if(!@customer.blank?)
      @reviewer = SubscribedUser.find_by_sql("select user.*, cust.ID as 'CustomerID', rev.ID as 'ReviewID' 
                  from SubscribedUsers user join Reviews rev on user.ID = rev.UserID join Customers cust on cust.ID = rev.CustomerID
                  where cust.ID IN (" + @customer.all.collect {|cust| cust.ID}.join(',') + ")")          
    end

  end

  def UpdateReviews
    if(session[:user_id] == nil)
      redirect_to root_url
    end
    @firstName = params[:hidFirstName]
    @lastName = params[:hidLastName]
    @phoneNumber = params[:hidPhoneNumber]
    @streetAddress = params[:hidStreetAddress]
    @citystateVal = params[:hidselectCity]
    @zipCode = params[:hidZipCode]
    @city = ""
    @state = ""
    if(!@citystateVal.blank?)
      @city = @citystateVal.at(0).strip()
      @state = @citystateVal.at(1).strip()
    end
    
    @reviewerID = params[:hidReviewerID]
    @reviewID = params[:hidReviewID]
    @reviewCount = params[:hidReviewCount]
    @reviewQuestion = ReviewQuestion.all
      
    if(!@reviewID.blank? && !@reviewerID.blank?)
      @review = Review.find_by(ID: @reviewID)          
      @reviewAnswers = ReviewAnswer.where("ReviewID = (?)", @reviewID)
      @reviewer = SubscribedUser.find_by(ID: @reviewerID)
      @reviewerAdd = UserAddressDetail.find_by(UserID: @reviewerID)            
    end
  end
  
  def UpdateReviewData
    if(session[:user_id] == nil)
      redirect_to root_url, :notice => "Login Session Expired!"
    end
    #@reviewQuestion = ReviewQuestion.all

    currentTime = Time.new
    time = currentTime.strftime("%Y-%m-%d %H:%M:%S")

    @firstName = params[:hidFirstName]
    @lastName = params[:hidLastName]
    @phoneNumber = params[:hidPhoneNumber]
    @streetAddress = params[:hidStreetAddress]
    @zipCode = params[:hidZipCode]
    @citystateVal = params[:hidselectCity]
    @city = ""
    @state = ""
    if(!@citystateVal.blank?)
      @citystateVal = @citystateVal.split(',')
      @city = @citystateVal.at(0).strip()
      @state = @citystateVal.at(1).strip()
    end

    @customer = Customer.find_by(FirstName: @firstName, LastName: @lastName, ContactNumber: @phoneNumber, StreetAddress: @streetAddress, City: @city, State: @state, ZIPCode: @zipCode)
    if(@customer.blank?)
      @customer = Customer.new(FirstName: @firstName, MiddleName: "", LastName: @lastName, ContactNumber: @phoneNumber, StreetAddress: @streetAddress, City: @city, State: @state, ZIPCode: @zipCode, DateCreated: time, DateUpdated: time)
    @customer.save
    end

    @userID = session[:user_id]
    @reviewID = params[:hidReviewID]
    @mlandjudgments = params[:textmlandjudgments]
    @otherPublicThirdPartyInfo = params[:textotherPublicThirdPartyInfo]
    
    
    
    @reviewUpdate = Review.find_by(ID: @reviewID)
    @review = ReviewHistory.find_by(ID: @reviewID)
    if(!@review.blank?)
      @review.destroy
    end
    @review = ReviewHistory.new(ID: @reviewUpdate.ID, UserID: @reviewUpdate.UserID, CustomerID: @reviewUpdate.CustomerID, IsVisible: @reviewUpdate.IsVisible, IsApproved: @reviewUpdate.IsApproved, MLAndJudgments: @reviewUpdate.MLAndJudgments, OtherPublicThirdPartyInfo: @reviewUpdate.OtherPublicThirdPartyInfo, DateCreated: @reviewUpdate.DateCreated, DateUpdated: @reviewUpdate.DateUpdated)
    @review.save
    
    @reviewUpdate.MLAndJudgments = @mlandjudgments
    @reviewUpdate.OtherPublicThirdPartyInfo = @otherPublicThirdPartyInfo
    @reviewUpdate.save
    
    @quesComment1 = params[:quesComment1]
    @radYesNo1 = params[:radYesNo1]
    @reviewAnswerUpdate = ReviewAnswer.find_by(ReviewID: @reviewID, QuestionID: 1)
    
    @reviewAnswer = ReviewAnswerHistory.find_by(ReviewID: @reviewID, QuestionID: 1)
    if(!@reviewAnswer.blank?)
      @reviewAnswer.destroy
    end
    @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
    @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
    @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
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
      @reviewAnswer = ReviewAnswerHistory.new(ID: @reviewAnswerUpdate.ID, ReviewID: @reviewAnswerUpdate.ReviewID, QuestionID: @reviewAnswerUpdate.QuestionID, Comments: @reviewAnswerUpdate.Comments, IsYes: @reviewAnswerUpdate.IsYes, DateCreated: @reviewAnswerUpdate.DateCreated, DateUpdated: @reviewAnswerUpdate.DateUpdated)
      @reviewAnswer.save
    
    
    @reviewAnswerUpdate.Comments = @quesComment17
    @reviewAnswerUpdate.DateUpdated = time
    @reviewAnswerUpdate.save

    session[:hidFirstName] = params[:hidFirstName]
    session[:hidLastName] = params[:hidLastName]
    session[:hidPhoneNumber] = params[:hidPhoneNumber]
    session[:hidStreetAddress] = params[:hidStreetAddress]
    session[:hidselectCity] = params[:hidselectCity]
    session[:hidZipCode] = params[:hidZipCode]
    
    redirect_to review_customers_ListReviews_url
  end
  
end
