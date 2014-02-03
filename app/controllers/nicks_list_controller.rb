class NicksListController < ApplicationController
  skip_before_action :verify_authenticity_token
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
    
    @newsUpdatesList = NewsUpdates.where(IsEnabled: 1)
    
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end  
    
  end
  
  def About
    @siteContent = SiteContent.find_by(PageCode: 101)
    if(!@siteContent.blank?)
      @content = @siteContent.Content.html_safe
      @title = @siteContent.Title.html_safe
    end
    
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    @testimonialList = Testimonials.where(IsEnabled: 1)
  end
  
  def HowItWorks
    @siteContent = SiteContent.find_by(PageCode: 102)
    if(!@siteContent.blank?)
      @content = @siteContent.Content.html_safe
      @title = @siteContent.Title.html_safe
    end
    
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    @testimonialList = Testimonials.where(IsEnabled: 1)
  end
  
  def Testimonials
    @siteContent = SiteContent.find_by(PageCode: 107)
    if(!@siteContent.blank?)
      @content = @siteContent.Content.html_safe
      @title = @siteContent.Title.html_safe
    end
    
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    @testimonialList = Testimonials.where(IsEnabled: 1)
  end
  
  def PressRelease
    @siteContent = SiteContent.find_by(PageCode: 103)
    if(!@siteContent.blank?)
      @content = @siteContent.Content.html_safe
      @title = @siteContent.Title.html_safe
    end
    
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    @testimonialList = Testimonials.where(IsEnabled: 1)
  end
  
  def FAQ
    @siteContent = SiteContent.find_by(PageCode: 106)
    if(!@siteContent.blank?)
      @content = @siteContent.Content.html_safe
      @title = @siteContent.Title.html_safe
    end
    
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    
    @faqList = Faq.where(IsEnabled: 1)
    @testimonialList = Testimonials.where(IsEnabled: 1)
  end
  
  def ContactUs
    @siteContent = SiteContent.find_by(PageCode: 108)
    if(!@siteContent.blank?)
      @content = @siteContent.Content.html_safe
      @title = @siteContent.Title.html_safe
    end
    
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    
    if(!params[:textEmail].blank?)
      @userfirstName = params[:textFirstName]
      @userlastName = params[:textLastName]
      @userEmail = params[:textEmail]
      @comments = params[:textComment]
      @userContact = params[:textContact]
      mail = UserMailer.ContactUs_Email(@userfirstName, @userlastName, @userEmail, @comments, @userContact)
      mail.deliver        
      redirect_to nicks_list_ContactUs_url, :notice => "Thank you for submitting your request. One of our representatives will contact you shortly."
    end
     @userID = session[:user_id]
    if(!@userID.blank?)
      userDetails = SubscribedUser.find_by(ID: @userID)
      @userfirstName = userDetails.FirstName
      @userlastName = userDetails.LastName
      @userEmail = userDetails.EmailID
      @userContact = userDetails.ContactNumber
    end
    @testimonialList = Testimonials.where(IsEnabled: 1)
  end
  
  def PrivacyPolicy
     @siteContent = SiteContent.find_by(PageCode: 104)
    if(!@siteContent.blank?)
      @content = @siteContent.Content.html_safe                                                                                                                                                                                                                                                                                                                                                                                                 
      @title = @siteContent.Title.html_safe
    end
  end
  
  def TermsConditions
     @siteContent = SiteContent.find_by(PageCode: 105)
    if(!@siteContent.blank?)
      @content = @siteContent.Content.html_safe
      @title = @siteContent.Title.html_safe
    end
  end
end
