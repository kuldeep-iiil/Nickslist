class AuthorizePaymentController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  helper :authorize_net
  protect_from_forgery :except => :relay_response
  
  # POST
  # Displays a payment form.
  def payment
    @userCompanyName = params[:hidCompanyName]
    @userFirstName = params[:hidFirstName]
    @userLastName = params[:hidLastName]
    @userPhoneNumber = params[:hidPhoneNumber]
    @userEmail = params[:hidEmail]
    @userStreetAddress = params[:hidStreetAddress]
    @userCity = params[:hidCity]
    @userState = params[:hidState]
    @userZipCode = params[:hidZipCode]
    @amount = params[:hidPrice]
    
    @subscribedUser = SubscribedUser.find_by(EmailID: @userEmail)
    
    currentTime = Time.new
    time = currentTime.strftime("%Y-%m-%d %H:%M:%S")
    
    @userPaymentDetails = UserPaymentDetail.new(UserID: @subscribedUser.id, TransactionAmount: @amount, PayTransactionID: "", ResponseString: "",  DateCreated: time, DateUpdated: time)
    @userPaymentDetails.save
    
    
    
    @sequence = @userPaymentDetails.id
    @apiLoginId = AUTHORIZE_NET_CONFIG['api_login_id']
    @txnKey = AUTHORIZE_NET_CONFIG['api_transaction_key'] 
    #@invoiceNumber = HMAC-MD5(@apiLoginId + "^" + @sequence  + "^" +  @amount  + "^" +  @txnKey + "^")
    
    uid = Time.now.to_i
    @uid = uid.to_s[6,9]
    @invoiceNumber = @uid + @userPaymentDetails.id.to_s + @userPaymentDetails.UserID.to_s
    @userPaymentDetails.TransactionAmount = @amount
    @userPaymentDetails.BLTransactionID = @invoiceNumber
    @userPaymentDetails.save
    #https://developer.authorize.net/tools/paramdump/index.php
    @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :relay_url => AUTHORIZE_NET_CONFIG['relay_response_url'])
    #@sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :relay_url => "http://192.168.0.198:3000/authorize_payment/relay_response")
    
    if(@sim_transaction.blank?)     
      @userPaymentDetails.PaymentStatus = 0
      @userPaymentDetails.ResponseString = "Error occured while generating request for sim transaction."
      @userPaymentDetails.DateUpdated = time
      @userPaymentDetails.save
      redirect_to user_registeration_GetRegister_url, :notice => "Unable to Process Request, contact Nickslist for help!"
    end    
  end

  # POST
  # Returns relay response when Authorize.Net POSTs to us.
  def relay_response
    sim_response = AuthorizeNet::SIM::Response.new(params)
    if sim_response.approved?
      currentTime = Time.new
      time = currentTime.strftime("%Y-%m-%d %H:%M:%S")
      
      @invoiceNumber = sim_response.invoice_num
      @transaction_id = sim_response.transaction_id
      @response = sim_response.to_json
      hash = JSON.parse(@response)
      @response = '{"raw_response":{"x_response_code":"' + hash['raw_response']['x_response_code'] + 
      ' "," x_response_reason_code":"' + hash['raw_response']['x_response_reason_code'] + 
      ' "," x_response_reason_text":"' + hash['raw_response']['x_response_reason_text'] +
      ' "," x_avs_code":"' + hash['raw_response']['x_avs_code'] +
      ' "," x_auth_code":"' + hash['raw_response']['x_auth_code'] +
      ' "," x_trans_id":"' + hash['raw_response']['x_trans_id'] +
      ' "," x_method":"' + hash['raw_response']['x_method'] +
      ' "," x_card_type":"' + hash['raw_response']['x_card_type'] +
      ' "," x_account_number":"' + hash['raw_response']['x_account_number'] +
      '"}}'
      @userPaymentDetails = UserPaymentDetail.find_by(BLTransactionID: @invoiceNumber)
      if(!@userPaymentDetails.blank?)
        @userPaymentDetails.PayTransactionID = @transaction_id
        @userPaymentDetails.ResponseString = @response
        @userPaymentDetails.PaymentStatus = 1  
        @userPaymentDetails.ResponseDateTime = time 
        @userPaymentDetails.DateUpdated = time
        @userPaymentDetails.save
        
        @userID = @userPaymentDetails.UserID
        
        @subscribedUser = SubscribedUser.find_by(id: @userID)
        @subscribedUser.IsSubscribed = 1
        @subscribedUser.DateUpdated = time
        @subscribedUser.save
        
        
        @userfirstName = @subscribedUser.FirstName
        @userlastName = @subscribedUser.LastName
        @useremail = @subscribedUser.EmailID
        @amount = @userPaymentDetails.TransactionAmount
        @authCode = ""
        if(!@subscribedUser.AuthCodeUsed)
          @key = Key.find_by(UserID: @subscribedUser.id)
          if(!@key.blank?)
            @authCode = @key.Key
          end
        end
          
        mail_to_admin = UserMailer.NewUserNotification(@userfirstName, @userlastName, @useremail, @invoiceNumber, @amount)
        mail_to_admin.deliver 
          
        mail_to_user = UserMailer.WelcomeUser(@userfirstName, @userlastName, @useremail, @invoiceNumber, @amount, @authCode)
        mail_to_user.deliver        
                
      end
      render :text => sim_response.direct_post_reply(AUTHORIZE_NET_CONFIG['receipt_url'] + '?in=' + @invoiceNumber + '-' + @userID)
    else
      @reason = sim_response.response_reason_text      
      @userPaymentDetails = UserPaymentDetail.find_by(BLTransactionID: @invoiceNumber)
      if(!@userPaymentDetails.blank?)
        @userPaymentDetails.PayTransactionID = @transaction_id
        @userPaymentDetails.ResponseString = @response
        @userPaymentDetails.PaymentStatus = 0  
        @userPaymentDetails.ResponseDateTime = time 
        @userPaymentDetails.DateUpdated = time
        @userPaymentDetails.save
      end
      render :text => sim_response.direct_post_reply(AUTHORIZE_NET_CONFIG['error_url'] + '?msg=' + @reason)
    end
  end

  # GET
  # Displays a receipt.
  def receipt
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    
   @queryParam = request.query_parameters["in"]   
   @paramValues = @queryParam.split('-') 
   @invoiceNumber = @paramValues.at(0).strip() 
   @userID = @paramValues.at(1).strip() 
   if(!@userID.blank?)
    userDetails = SubscribedUser.find_by(ID: @userID)
    userBussAddressDetails = UserAddressDetail.find_by(UserID: @userID, AddressType: 'Business')
    userMailAddressDetails = UserAddressDetail.find_by(UserID: @userID, AddressType: 'Mailing')
    paymentDetail = UserPaymentDetail.find_by(BLTransactionID: @invoiceNumber);    
    @usercompanyName = userDetails.CompanyName
    @userfirstName = userDetails.FirstName
    @userlastName = userDetails.LastName
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
    @price = paymentDetail.TransactionAmount
   end
  end

  # GET
  # Displays an error page.
  def error
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    
    @reason = request.query_parameters["msg"]   
  end

end
