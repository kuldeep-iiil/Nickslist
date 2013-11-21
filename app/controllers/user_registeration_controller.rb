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
      @userbusscitystateVal = @userbusscitystateVal.split(',')    
      @userbussCity = @userbusscitystateVal.at(0).strip()      
      @userbussState = @userbusscitystateVal.at(1).strip()      
    end
      
    #bussCity = params[:textBussCity]
    #bussState = params[:textBussState]    
    @userbussZipCode = params[:textBussZipCode]
    
    @usermailStreetAddress = params[:textMailStreetAddress]    
    @usermailcitystateVal = params[:textMailCity]
    @usermailCity = ""
    @usermailState = ""
    if(!@usermailcitystateVal.blank?)    
      @usermailcitystateVal = @usermailcitystateVal.split(',')
      @usermailCity = @usermailcitystateVal.at(0).strip()
      @usermailState = @usermailcitystateVal.at(1).strip()      
    end
    
    #mailCity = params[:textMailCity]
    #mailState = params[:textMailState]
    @usermailZipCode = params[:textMailZipCode]
    @userphoneNumber = params[:textPhoneNumber]
    @useremail = params[:textEmail]
    @userlicense = params[:textLicense]
    @userName = params[:textUserName]
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
      @userphoneNumber != nil and @useremail != nil and @userlicense != nil and @userName != nil and password != nil and salt != nil)
          
        if(keyCode.blank?)
          isUsed='0'
          @itemprice = 100.00
          @price = number_to_currency(100.00, :unit => "$")
        else
          isUsed='1'
          @itemprice = 70.00
          @price = number_to_currency(70.00, :unit => "$")
        end
        
        userExistence = SubscribedUser.find_by(UserName: @userName)
        emailExistence = SubscribedUser.find_by(EmailID: @useremail)
        licenseExistence = SubscribedUser.find_by(LicenseNumber: @userlicense)
        companyExistence = SubscribedUser.find_by(CompanyName: @usercompanyName)

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
          @subscribedUser = SubscribedUser.new(UserName: @userName, Password: password, Salt: salt, FirstName: @userfirstName,
          LastName: @userlastName, EmailID: @useremail, CompanyName: @usercompanyName, IncorporationType: @userincorporationType,
          ContactNumber: @userphoneNumber, LicenseNumber: @userlicense, AuthCodeUsed: isUsed, IsEnabled: 1, IsActivated: 0, 
          IsApproved: 0, IsSubscribed: 0, DateCreated: time, DateUpdated: time)        
          @subscribedUser.save 
        
          #Get UserID for User to save user address details.
          user = SubscribedUser.find_by(UserName: @userName)
        
          #Save Address Details
          @userBussAddressDetail = UserAddressDetail.new(UserID: user.ID, AddressType: 'Business', Address: @userbussStreetAddress, City: @userbussCity, State: @userbussState, ZIPCode: @userbussZipCode, DateCreated: time, DateUpdated: time)
          @userBussAddressDetail.save
        
          @userMailAddressDetail = UserAddressDetail.new(UserID: user.ID, AddressType: 'Mailing' , Address: @usermailStreetAddress, City: @usermailCity, State: @usermailState, ZIPCode: @usermailZipCode, DateCreated: time, DateUpdated: time)
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
          @userbussCity = userBussAddressDetails.City + ', ' + userBussAddressDetails.State
          #@bussState = userBussAddressDetails.State
          @userbussZipCode = userBussAddressDetails.ZIPCode
          @usermailStreetAddress = userMailAddressDetails.Address
          @usermailCity = userMailAddressDetails.City + ', ' + userMailAddressDetails.State
          #@mailState = userMailAddressDetails.State
          @usermailZipCode = userMailAddressDetails.ZIPCode
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
  
  def GetSubscription
    @subscribedUser = SubscribedUser.find_by(EmailID: session[:email_id])
    itemprice = session[:itemprice]
    session[:email_id] = nil
    session[:itemprice] = nil
    currentTime = Time.new
    time = currentTime.strftime("%Y-%m-%d %H:%M:%S")
    
    @userPaymentDetails = UserPaymentDetail.new(UserID: @subscribedUser.ID, NumberOfItems: 1, ItemPrice: itemprice, PayerID: "", Token: "", TransactionID: "", ResponseString: "",  DateCreated: time, DateUpdated: time)
    @userPaymentDetails.save
    
    @paypal = PaypalInterface.new(@userPaymentDetails)
    @paypal.express_checkout
    if @paypal.express_checkout_response.success?
      @userPaymentDetails.Token = @paypal.express_checkout_response.Token
      @userPaymentDetails.DateUpdated= time
      @userPaymentDetails.save

      @paypal_url = @paypal.api.express_checkout_url(@paypal.express_checkout_response)      
      redirect_to @paypal_url
    else      
      @userPaymentDetails.PaymentStatus = 0
      @userPaymentDetails.ResponseString = @paypal.express_checkout_response.to_json
      @userPaymentDetails.DateUpdated = time
      @userPaymentDetails.save
      redirect_to user_registeration_GetRegister_url, :notice => "Unable to Process Request, contact Nickslist for help!"
    end
  end
  
  def paid
    if(!params[:token].blank? && !params[:PayerID].blank?)
      # success message
      @token = params[:token]
      @payerID = params[:PayerID]
      currentTime = Time.new
      time = currentTime.strftime("%Y-%m-%d %H:%M:%S")
      #begin
        @userPaymentDetails = UserPaymentDetail.find_by(Token: @token)
        @userPaymentDetails.PayerID = @payerID
        @userPaymentDetails.DateUpdated = time
        @userPaymentDetails.save
        
        @paypal = PaypalInterface.new(@userPaymentDetails)
        @response = @paypal.do_express_checkout
        if(!@response.blank?)
          @timestamp = @response.Timestamp
          @responseStatus = @response.Ack
          currentTime = Time.new
          time = currentTime.strftime("%Y-%m-%d %H:%M:%S")
          if(@responseStatus == "Failure")
            @userPaymentDetails.TransactionID = ""
            @userPaymentDetails.PaymentStatus = 0
            @userPaymentDetails.ResponseDateTime = @timestamp
            @userPaymentDetails.ResponseString = @response.to_json
            @userPaymentDetails.DateUpdated = time
            @userPaymentDetails.save
            redirect_to user_registeration_GetRegister_url, :notice => "Unable to Process Request, contact Nickslist for help!"
          else
            
            @PaymentInfo = @response.DoExpressCheckoutPaymentResponseDetails
            @transactionID = @PaymentInfo.PaymentInfo[0].TransactionID
            @PaymentInfo = @PaymentInfo.PaymentInfo[0].GrossAmount            
            @amount = @PaymentInfo.value
            @currency = @PaymentInfo.currencyID
            #@currency = @currency

            @userPaymentDetails.TransactionID = @transactionID
            @userPaymentDetails.PaymentStatus = 1
            @userPaymentDetails.ResponseDateTime = @timestamp
            @userPaymentDetails.ResponseString = @response.to_json
            @userPaymentDetails.DateUpdated = time
            @userPaymentDetails.save
            
            #Update the isSubscribed to true in User table
            @subscribedUser = SubscribedUser.find_by(ID: @userPaymentDetails.UserID)
            @subscribedUser.IsSubscribed = 1
            @subscribedUser.save
            
            #Send Welcome Mail
            mail = UserMailer.welcome_user(@subscribedUser.EmailID, @subscribedUser.FirstName,  @subscribedUser.LastName, @transactionID, @timestamp, @responseStatus, @amount)
            mail.deliver
         end
        end
    else
      # error message
    end
  end
  
  def Finish
    redirect_to root_url
  end
  
  def revoked
    #if order = Order.cancel_payment(params)
      # set a message for the user
    #end
    redirect_to user_registeration_GetRegister_path
  end
  
  def ipn
    #if (!params[:txn_id].blank? && !params[:token].blank?)
      #payment.receive_ipn(params)
     # txn_id = params[:txn_id]
     # currentTime = Time.new
     # time = currentTime.strftime("%Y-%m-%d %H:%M:%S")
     # userPaymentDetails = UserPaymentDetail.find_by(Token: token)
     # userPaymentDetails.TransactionID = txn_id
     # userPaymentDetails.UpdatedDate = time
     # userPaymentDetails.save
    #else
      #Payment.create_by_ipn(params)
    #end
  end
end