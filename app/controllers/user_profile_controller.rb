class UserProfileController < ApplicationController
  skip_before_action :verify_authenticity_token
  def EditProfile
    if(!session[:user_id])
      redirect_to nicks_list_Index_url, flash:{:redirectUrl => user_profile_ViewProfile_url}
    end
    
    @userID = session[:user_id]
    if(!@userID.blank?)
      userDetails = SubscribedUser.find_by(ID: @userID)
      userBussAddressDetails = UserAddressDetail.find_by(UserID: @userID, AddressType: 'Business')
      userMailAddressDetails = UserAddressDetail.find_by(UserID: @userID, AddressType: 'Mailing')
    
      @firstName = userDetails.FirstName
      @lastName = userDetails.LastName    
      @companyName = userDetails.CompanyName
      @incorporationType = userDetails.IncorporationType
      @bussStreetAddress = userBussAddressDetails.Address
      @bussCity = userBussAddressDetails.City + ', ' + userBussAddressDetails.State
      #@bussState = userBussAddressDetails.State
      @bussZipCode = userBussAddressDetails.ZIPCode
      @mailStreetAddress = userMailAddressDetails.Address
      @mailCity = userMailAddressDetails.City + ', ' + userMailAddressDetails.State
      #@mailState = userMailAddressDetails.State
      @mailZipCode = userMailAddressDetails.ZIPCode
      @phoneNumber = userDetails.ContactNumber
      @email = userDetails.EmailID
      @license = userDetails.LicenseNumber
      @error = ""
    end
  end

  def ViewProfile
    
    if(!session[:user_id])
      redirect_to nicks_list_Index_url, flash:{:redirectUrl => user_profile_ViewProfile_url}
    end
    
    @userID = session[:user_id]
    if(!@userID.blank?)
      userDetails = SubscribedUser.find_by(ID: @userID)
      userBussAddressDetails = UserAddressDetail.find_by(UserID: @userID, AddressType: 'Business')
      userMailAddressDetails = UserAddressDetail.find_by(UserID: @userID, AddressType: 'Mailing')
    
      @firstName = userDetails.FirstName
      @lastName = userDetails.LastName    
      @companyName = userDetails.CompanyName
      @incorporationType = userDetails.IncorporationType
      @bussStreetAddress = userBussAddressDetails.Address
      @bussCity = userBussAddressDetails.City + ', ' + userBussAddressDetails.State
      @bussZipCode = userBussAddressDetails.ZIPCode
      @mailStreetAddress = userMailAddressDetails.Address
      @mailCity = userMailAddressDetails.City + ', ' + userMailAddressDetails.State
      @mailZipCode = userMailAddressDetails.ZIPCode
      @phoneNumber = userDetails.ContactNumber
      @email = userDetails.EmailID
      @license = userDetails.LicenseNumber
      @error = ""
    end
  end
  
  def UpdateProfile
    @userID = session[:user_id]
    currentTime = Time.new
    time = currentTime.strftime("%Y-%m-%d %H:%M:%S")
    if(!@userID.blank?)
      @userDetails = SubscribedUser.find_by(ID: @userID)
      
      @firstName = params[:textFirstName]
      @lastName = params[:textLastName]
      @email = params[:textEmail]
            
      @userDetails.FirstName = @firstName
      @userDetails.LastName = @lastName
      @userDetails.EmailID = @email
      @userDetails.DateUpdated = time
      @userDetails.save
          
    end    
    redirect_to user_profile_ViewProfile_url, :notice => "Profile updated successfuly!"
  end
  
end
