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
    
    @newsUpdatesList = NewsUpdates.all  
    
  end
  
  def About
    @siteContent = SiteContent.find_by(Title: "About BillyList")
    if(!@siteContent.blank?)
      @content = @siteContent.Content.html_safe
    end
    
    @testimonialList = Testimonials.all
  end
  
  def HowItWorks
    @siteContent = SiteContent.find_by(Title: "How It Works")
    if(!@siteContent.blank?)
      @content = @siteContent.Content.html_safe
    end
    
    @testimonialList = Testimonials.all
  end
  
  def Testimonials
    @testimonialList = Testimonials.all
  end
  
  def PressRelease
    @siteContent = SiteContent.find_by(Title: "Press Release")
    if(!@siteContent.blank?)
      @content = @siteContent.Content.html_safe
    end
    @testimonialList = Testimonials.all
  end
  
  def FAQ
    @faqList = Faq.all
  end
  
  def ContactUs
    if(!params[:textEmail].blank?)
      @userfirstName = params[:textFirstName]
      @userlastName = params[:textLastName]
      @useremail = params[:textEmail]
      @comments = params[:textComment]
      mail = UserMailer.ContactUs_Email(@userfirstName, @userlastName, @useremail, @comments)
      mail.deliver        
      redirect_to root_url, :notice => "Your comments post successfully!"
    end
     @userID = session[:user_id]
    if(!@userID.blank?)
      userDetails = SubscribedUser.find_by(ID: @userID)
      @userfirstName = userDetails.FirstName
      @userlastName = userDetails.LastName
      @useremail = userDetails.EmailID
    end
    @testimonialList = Testimonials.all
  end
end
