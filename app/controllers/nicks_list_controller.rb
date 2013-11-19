class NicksListController < ApplicationController
  def Index
    @openLogin = ''
    if(!flash[:userName].blank? && !flash[:error].blank?)
      @openLogin = 1
      @userName = flash[:userName]
      @errorMessage = flash[:error]
    end
    
    if(!flash[:redirectUrl].blank?)
      @openLogin = 1
      @firstName = flash[:hidFirstName]
      @lastName = flash[:hidLastName]
      @phoneNumber = flash[:hidPhoneNumber]
      @streetAddress = flash[:hidStreetAddress]
      @citystateVal = flash[:hidselectCity]
      @zipCode = flash[:hidZipCode]
      @redirectUrl = flash[:redirectUrl]
      @reviewerID = flash[:hidReviewerID]
      @reviewID = flash[:hidReviewID]
      @reviewCount = flash[:hidReviewCount]
    end   
  end
  
  def About
    
  end
  
  def HowItWorks
    
  end
end
