class UserRegisterationController < ApplicationController
  skip_before_action :verify_authenticity_token
  include ActionView::Helpers::NumberHelper
  include Sidekiq::Worker
  
  def GetRegister   
    @usercompanyName = params[:textCompany]
    @userfirstName = params[:textFirstName]
    @userlastName = params[:textLastName]
    @userincorporationType = params[:textIncorporationType]
    @userbussStreetAddress = params[:textBussStreetAddress]
    @userbussCity = params[:textBussCity] 
    @userbussState = params[:textBussState] 
    #if(!@userbusscitystateVal.blank?)
    #  @userbusscitystate = @userbusscitystateVal.split(',')    
    #  @userbussCity = @userbusscitystate.at(0).strip()      
    #  @userbussState = @userbusscitystate.at(1).strip()      
    #end
      
    @userbussZipCode = params[:textBussZipCode]
    
    @usermailStreetAddress = params[:textMailStreetAddress]
    @usermailCity = params[:textMailCity]
    @usermailState = params[:textMailState]
    #f(!@usermailcitystateVal.blank?)    
    #  @usermailcitystate = @usermailcitystateVal.split(',')
    #  @usermailCity = @usermailcitystate.at(0).strip()
    #  @usermailState = @usermailcitystate.at(1).strip()      
    #end
   
    @usermailZipCode = params[:textMailZipCode]
    @userphoneNumber = params[:textPhoneNumber]
    @useremail = params[:textEmail]
    @userlicense = params[:textLicense]
    @useruserName = params[:textUserName]
    password = params[:textPassword]
    authCode = params[:textCode]
    @userauthCode = authCode
    keyCode = params[:hiddenFilledCode]
    currentTime = Time.new
    time = currentTime.strftime("%Y-%m-%d %H:%M:%S")
    status = true
    
    #Generating encrypted password
    if(!password.blank?)
      #salt = BCrypt::Engine.generate_salt
      #password = BCrypt::Engine.hash_secret(password, salt)
      salt = currentTime.strftime("%Y%m%d").to_str
      encryptedpassword = AuthenticationController.new()
      password = encryptedpassword.password_encryption(password, salt)
    end
    
    
    if(params[:textCompany] != nil and params[:textFirstName] != nil and params[:textLastName] != nil and params[:textIncorporationType] != nil and 
      params[:textBussStreetAddress] != nil and params[:textBussCity] != nil and params[:textBussState] != nil and params[:textBussZipCode] != nil and
      params[:textMailStreetAddress] != nil and params[:textMailCity] and params[:textMailState] != nil and params[:textMailZipCode] != nil and
      params[:textPhoneNumber] != nil and params[:textEmail] != nil and params[:textLicense] != nil and params[:textUserName] != nil and password != nil and salt != nil)
        
  
        if(keyCode.blank?)
          isUsed='0'
          @subPlan = UserSubscriptionPlan.find_by(PlanType: 'New User')
          @itemprice = @subPlan.price
          @price = number_to_currency(@itemprice.to_i, :unit => "$")
        else
          isUsed='1'
          @subPlan = UserSubscriptionPlan.find_by(PlanType: 'Subsequent User')
          @itemprice = @subPlan.price
          @price = number_to_currency(@itemprice.to_i, :unit => "$")
        end
        
        userExistence = SubscribedUser.find_by(UserName: @useruserName)
        emailExistence = SubscribedUser.find_by(EmailID: @useremail)
        licenseExistence = SubscribedUser.find_by(LicenseNumber: @userlicense)
        companyExistence = SubscribedUser.find_by(CompanyName: @usercompanyName)

        if(!userExistence.blank?)
          status = false
          @messageString="Username already exists."  
        end
                  
        if(!emailExistence.blank?)
          status = false
          @messageString="Email ID already exists."  
        end
                         
        if(!licenseExistence.blank? && keyCode == nil)
          status = false
          @messageString="License Number already exists."  
        end    
                         
        if(!companyExistence.blank? && keyCode == nil)
          status = false
          @messageString="Company name already exists."
        end      
        
        if(status == true)
          @messageString = ''
                          
          #Save User Information
          @subscribedUser = SubscribedUser.new(UserName: @useruserName, Password: password, Salt: salt, FirstName: @userfirstName,
          LastName: @userlastName, EmailID: @useremail, CompanyName: @usercompanyName, IncorporationType: @userincorporationType,
          ContactNumber: @userphoneNumber, LicenseNumber: @userlicense, AuthCodeUsed: isUsed, IsActivated: 0, IsSubscribed: 0, IsNotification: 1, 
          DateCreated: time, DateUpdated: time)        
          @subscribedUser.save 
        
          #Get UserID for User to save user address details.
          user = SubscribedUser.find_by(UserName: @useruserName)
        
          #Save Address Details
          @userBussAddressDetail = UserAddressDetail.new(UserID: user.id, AddressType: 'Business', Address: @userbussStreetAddress, City: @userbussCity, State: @userbussState, ZipCode: @userbussZipCode, DateCreated: time, DateUpdated: time)
          @userBussAddressDetail.save
        
          @userMailAddressDetail = UserAddressDetail.new(UserID: user.id, AddressType: 'Mailing' , Address: @usermailStreetAddress, City: @usermailCity, State: @usermailState, ZipCode: @usermailZipCode, DateCreated: time, DateUpdated: time)
          @userMailAddressDetail.save
        
          #Create key for the user company to be used by subsicuent user.
          if(keyCode.blank?)
            keyCode = Time.now.to_i
            @keyCode = keyCode
            @key = Key.new(UserID: user.id, Key: keyCode , DateCreated: time)
            @key.save          
          end
                      
          #render Confirm Subscription form with filled user data   
          render :action => 'GetSubscription'
          #redirect_to user_registeration_GetSubscription_url
      else
          @authCode = params[:hiddenFilledCode]
      end
    end 
     
      if(!authCode.blank?)
        key = Key.find_by(Key: authCode)
        if(not key.blank?)  
          userDetails = SubscribedUser.find_by(ID: key.UserID)
          userBussAddressDetails = UserAddressDetail.find_by(UserID: key.UserID, AddressType: 'Business')
          userMailAddressDetails = UserAddressDetail.find_by(UserID: key.UserID, AddressType: 'Mailing')
        
          @userauthCode = authCode
          @usercompanyName = userDetails.CompanyName
          @userincorporationType = userDetails.IncorporationType
          @userbussStreetAddress = userBussAddressDetails.Address
          @userbussCity = userBussAddressDetails.City
          @userbussState = userBussAddressDetails.State
          @userbussZipCode = userBussAddressDetails.ZipCode
          @usermailStreetAddress = userMailAddressDetails.Address
          @usermailCity = userMailAddressDetails.City
          @usermailState = userMailAddressDetails.State
          @usermailZipCode = userMailAddressDetails.ZipCode
          @userphoneNumber = userDetails.ContactNumber
          @useremail = userDetails.EmailID
          @userlicense = userDetails.LicenseNumber
          @error = ""
        else
          @error = "1"         
          @messageString = "Invalid Authcode!"
        end
     end 
  end
  
end