class ReviewCustomersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def AddReviews
    if(session[:user_id] == nil)
      redirect_to root_url, :notice => "Login Session Expired!"
    end
    @reviewQuestion = ReviewQuestion.all

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
  end

  def AddReviewData
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
      redirect_to root_url, :notice => "Login Session Expired!"
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
        @reviewAnswers = ReviewAnswer.where("ReviewID = (?)", @reviewID)
        @reviewer = SubscribedUser.find_by(ID: @reviewerID)
        @reviewerAdd = UserAddressDetail.find_by(UserID: @reviewerID)            
    end
        
  end

  def ListReviews
    if(session[:user_id] == nil)
      redirect_to root_url, :notice => "Login Session Expired!"
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
    
    session[:hidFirstName] = nil
      session[:hidLastName] = nil
      session[:hidPhoneNumber] = nil
      session[:hidStreetAddress] = nil
      session[:hidselectCity] = nil
      session[:hidZipCode] = nil

  end

  def UpdateReviews
    if(session[:user_id] == nil)
      redirect_to root_url, :notice => "Login Session Expired!"
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
        @reviewAnswers = ReviewAnswer.where("ReviewID = (?)", @reviewID)
        @reviewer = SubscribedUser.find_by(ID: @reviewerID)
        @reviewerAdd = UserAddressDetail.find_by(UserID: @reviewerID)            
    end
    
  end
end
