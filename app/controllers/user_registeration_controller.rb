class UserRegisterationController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def GetRegister    
    companyName = params[:textCompany]
    firstName = params[:textFirstName]
    lastName = params[:textLastName]
    incorporationType = params[:textIncorporationType]
    bussStreetAddress = params[:textBussStreetAddress]
    bussCity = params[:textBussCity]
    bussState = params[:textBussState]
    bussZipCode = params[:textBussZipCode]
    mailStreetAddress = params[:textMailStreetAddress]
    mailCity = params[:textMailCity]
    mailState = params[:textMailState]
    mailZipCode = params[:textMailZipCode]
    phoneNumber = params[:textPhoneNumber]
    email = params[:textEmail]
    license = params[:textLicense]
    userName = params[:textUserName]
    password = params[:textPassword]
    if(!password.blank?)
      salt = BCrypt::Engine.generate_salt
      password = BCrypt::Engine.hash_secret(password, salt)
    end
    authCode = params[:textCode]
    keyCode = params[:hiddenFilledCode]
    time = Time.new
    time = time.strftime("%Y-%m-%d %H:%M:%S")
    status = true
    
    if(companyName != nil and firstName != nil and lastName != nil and incorporationType != nil and 
      bussStreetAddress != nil and bussCity != nil and bussState != nil and bussZipCode != nil and
      mailStreetAddress != nil and mailCity != nil and mailState != nil and mailZipCode != nil and
      phoneNumber != nil and email != nil and license != nil and userName != nil and password != nil)
          
        if(keyCode.blank?)
          isUsed='0'
          params[:hiddenPrice] = '1000.00'
        else
          isUsed='1'
          params[:hiddenPrice] = '700.00'
        end
        
        userExistence = SubscribedUser.find_by(UserName: userName)
        emailExistence = SubscribedUser.find_by(EmailID: email)
        licenseExistence = SubscribedUser.find_by(LicenseNumber: license)
        companyExistence = SubscribedUser.find_by(CompanyName: companyName)

        if(!userExistence.blank?)
          status = false
          @messageString="Error Message : Username already exists."  
        end
                  
        if(!emailExistence.blank?)
          status = false
          @messageString="Error Message : Email ID already exists."  
        end
                         
        if(!licenseExistence.blank? && keyCode == nil)
          status = false
          @messageString="Error Message : License Number already exists."  
        end    
                         
        if(!companyExistence.blank? && keyCode == nil)
          status = false
          @messageString="Error Message : Company name already exists."
        end      
        
        if(status == true)
          @messageString = ''
                          
          #Save User Information
          @subscribedUser = SubscribedUser.new(UserName: userName, Password: password, FirstName: firstName,
          LastName: lastName, EmailID: email, CompanyName: companyName, IncorporationType: incorporationType,
          ContactNumber: phoneNumber, LicenseNumber: license, AuthCodeUsed: isUsed, IsEnabled: 0, IsActivated: 1, 
          IsApproved: 0, DateCreated: time, DateUpdated: time)        
          @subscribedUser.save 
        
          #Get UserID for User to save user address details.
          user = SubscribedUser.find_by(UserName: userName)
        
          #Save Address Details
          @userBussAddressDetail = UserAddressDetail.new(UserID: user.ID, AddressType: 'Business', Address: bussStreetAddress, City: bussCity, State: bussState, ZIPCode: bussZipCode, DateCreated: time, DateUpdated: time)
          @userBussAddressDetail.save
        
          @userMailAddressDetail = UserAddressDetail.new(UserID: user.ID, AddressType: 'Mailing' , Address: mailStreetAddress, City: mailCity, State: mailState, ZIPCode: mailZipCode, DateCreated: time, DateUpdated: time)
          @userMailAddressDetail.save
        
          #Create key for the user company to be used by subsicuent user.
          if(keyCode.blank?)
            keyCode = Time.now.to_i
            @keyCode = keyCode
            @key = Key.new(UserID: user.ID, Key: keyCode , DateCreated: time)
            @key.save          
          end
                      
          #render Confirm Subscription form with filled user data   
          render :action => 'GetSubscription'
      else
          params[:textCompany] = companyName
          params[:textFirstName] = firstName
          params[:textLastName] = lastName
          params[:textIncorporationType] = incorporationType
          params[:textBussStreetAddress] = bussStreetAddress
          params[:textBussCity] = bussCity
          params[:textBussState] = bussState
          params[:textBussZipCode] = bussZipCode
          params[:textMailStreetAddress] = mailStreetAddress
          params[:textMailCity] = mailCity
          params[:textMailState] = mailState
          params[:textMailZipCode] = mailZipCode
          params[:textPhoneNumber] = phoneNumber
          params[:textEmail] = email
          params[:textConfirmEmail] = email
          params[:textLicense] = license
          params[:textUserName] = userName
      end
    end 
     
      if(!authCode.blank?)
        key = Key.find_by(Key: authCode)
        if(not key.blank?)  
          userDetails = SubscribedUser.find_by(ID: key.UserID)
          userBussAddressDetails = UserAddressDetail.find_by(UserID: key.UserID, AddressType: 'Business')
          userMailAddressDetails = UserAddressDetail.find_by(UserID: key.UserID, AddressType: 'Mailing')
        
          @authCode = authCode
          @companyName = userDetails.CompanyName
          @incorporationType = userDetails.IncorporationType
          @bussStreetAddress = userBussAddressDetails.Address
          @bussCity = userBussAddressDetails.City
          @bussState = userBussAddressDetails.State
          @bussZipCode = userBussAddressDetails.ZIPCode
          @mailStreetAddress = userMailAddressDetails.Address
          @mailCity = userMailAddressDetails.City
          @mailState = userMailAddressDetails.State
          @mailZipCode = userMailAddressDetails.ZIPCode
          @phoneNumber = userDetails.ContactNumber
          @email = userDetails.EmailID
          @license = userDetails.LicenseNumber
        end
     end 
  end
  
  def GetSubscription

  end
  
  def PaypalPayment
    
  end
  
  def show
    @order = "1"
    @paypal = PaypalInterface.new(@order)
    @paypal.express_checkout
    #if @paypal.express_checkout_response.success?
      @paypal_url = @paypal.api.express_checkout_url(@paypal.express_checkout_response)
      redirect_to @paypal_url
   # else
    #  @Error = 'Error Occured'
    #end
    
    #@paypal.do_direct_payment
    #@paypal_url = @paypal.api.express_checkout_url(@paypal.do_direct_payment)
    #redirect_to @paypal_url
  end
  
  def paid
    if order = Order.pay(params[:token], params[:PayerID])
      # success message
    else
      # error message
    end
    redirect_to orders_path
  end
  
  def ipn
    if payment = Payment.find_by_transaction_id(params[:txn_id])
      payment.receive_ipn(params)
    else
      Payment.create_by_ipn(params)
    end
  end
  
  def revoked
    if order = Order.cancel_payment(params)
      # set a message for the user
    end
    redirect_to orders_path
  end
end