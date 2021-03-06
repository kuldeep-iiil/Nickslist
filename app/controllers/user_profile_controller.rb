class UserProfileController < ApplicationController
  skip_before_action :verify_authenticity_token
  def EditProfile
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    
    
    if(!session[:user_id])
      redirect_to nicks_list_Index_url, flash:{:redirectUrl => user_profile_ViewProfile_url}
    else
    
    @userID = session[:user_id]
    if(!@userID.blank?)
      userDetails = SubscribedUser.find_by(ID: @userID)
      userBussAddressDetails = UserAddressDetail.find_by(UserID: @userID, AddressType: 'Business')
      userMailAddressDetails = UserAddressDetail.find_by(UserID: @userID, AddressType: 'Mailing')
    
      @userfirstName = userDetails.FirstName
      @userlastName = userDetails.LastName    
      @usercompanyName = userDetails.CompanyName
      @userincorporationType = userDetails.IncorporationType
      @userbussStreetAddress = userBussAddressDetails.Address
      @userbussCity = userBussAddressDetails.City
      @userbussState = userBussAddressDetails.State
      #@bussState = userBussAddressDetails.State
      @userbussZipCode = userBussAddressDetails.ZipCode
      @usermailStreetAddress = userMailAddressDetails.Address
      @usermailCity = userMailAddressDetails.City
      @usermailState = userMailAddressDetails.State
      #@mailState = userMailAddressDetails.State
      @usermailZipCode = userMailAddressDetails.ZipCode
      @userphoneNumber = userDetails.ContactNumber
      @useremail = userDetails.EmailID
      @userlicense = userDetails.LicenseNumber
      @error = ""
    end
    end
  end

  def ViewProfile
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    
    if(!session[:user_id])
      redirect_to nicks_list_Index_url, flash:{:redirectUrl => user_profile_ViewProfile_url}
    else
    
    @userID = session[:user_id]
    if(!@userID.blank?)
      userDetails = SubscribedUser.find_by(ID: @userID)
      userBussAddressDetails = UserAddressDetail.find_by(UserID: @userID, AddressType: 'Business')
      userMailAddressDetails = UserAddressDetail.find_by(UserID: @userID, AddressType: 'Mailing')
    
      @userfirstName = userDetails.FirstName
      @userlastName = userDetails.LastName    
      @usercompanyName = userDetails.CompanyName
      @userincorporationType = userDetails.IncorporationType
      @userbussStreetAddress = userBussAddressDetails.Address
      @userbussCity = userBussAddressDetails.City + ', ' + userBussAddressDetails.State
      @userbussZipCode = userBussAddressDetails.ZipCode
      @usermailStreetAddress = userMailAddressDetails.Address
      @usermailCity = userMailAddressDetails.City + ', ' + userMailAddressDetails.State
      @usermailZipCode = userMailAddressDetails.ZipCode
      @userphoneNumber = userDetails.ContactNumber
      @useremail = userDetails.EmailID
      @userlicense = userDetails.LicenseNumber
      @error = ""
    end
    end
  end
  
  def UpdateProfile
    @userID = session[:user_id]
    currentTime = Time.new
    time = currentTime.strftime("%Y-%m-%d %H:%M:%S")
    if(!@userID.blank?)
      @userDetails = SubscribedUser.find_by(ID: @userID)
      
      @userfirstName = params[:textFirstName]
      @userlastName = params[:textLastName]
      @useremail = params[:textEmail]
            
      @userDetails.FirstName = @userfirstName
      @userDetails.LastName = @userlastName
      @userDetails.EmailID = @useremail
      @userDetails.DateUpdated = time
      @userDetails.save
          
    end    
    redirect_to user_profile_ViewProfile_url, :notice => "Profile updated successfuly!"
  end
  
end
