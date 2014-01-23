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
    
    @userbusscitystateVal = params[:textBussCity]    
    @userbussCity = ""
    @userbussState = ""
    if(!@userbusscitystateVal.blank?)
      @userbusscitystate = @userbusscitystateVal.split(',')    
      @userbussCity = @userbusscitystate.at(0).strip()      
      @userbussState = @userbusscitystate.at(1).strip()      
    end
      
    @userbussZipCode = params[:textBussZipCode]
    
    @usermailStreetAddress = params[:textMailStreetAddress]    
    @usermailcitystateVal = params[:textMailCity]
    @usermailCity = ""
    @usermailState = ""
    if(!@usermailcitystateVal.blank?)    
      @usermailcitystate = @usermailcitystateVal.split(',')
      @usermailCity = @usermailcitystate.at(0).strip()
      @usermailState = @usermailcitystate.at(1).strip()      
    end
   
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
    
    
    if(@usercompanyName != nil and @userfirstName != nil and @userlastName != nil and @userincorporationType != nil and 
      @userbussStreetAddress != nil and @userbussCity != nil and @userbussZipCode != nil and
      @usermailStreetAddress != nil and @usermailCity != nil and @usermailZipCode != nil and
      @userphoneNumber != nil and @useremail != nil and @userlicense != nil and @useruserName != nil and password != nil and salt != nil)
          
        if(keyCode.blank?)
          isUsed='0'
          @itemprice = 100.00
          @price = number_to_currency(100.00, :unit => "$")
        else
          isUsed='1'
          @itemprice = 70.00
          @price = number_to_currency(70.00, :unit => "$")
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
          ContactNumber: @userphoneNumber, LicenseNumber: @userlicense, AuthCodeUsed: isUsed, IsActivated: 0, IsSubscribed: 0, 
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
          @userbusscitystateVal = userBussAddressDetails.City + ', ' + userBussAddressDetails.State
          #@bussState = userBussAddressDetails.State
          @userbussZipCode = userBussAddressDetails.ZipCode
          @usermailStreetAddress = userMailAddressDetails.Address
          @usermailcitystateVal = userMailAddressDetails.City + ', ' + userMailAddressDetails.State
          #@mailState = userMailAddressDetails.State
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