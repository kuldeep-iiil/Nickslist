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
    
    @userPaymentDetails = UserPaymentDetail.new(UserID: @subscribedUser.ID, TransactionAmount: @amount, PayTransactionID: "", ResponseString: "",  DateCreated: time, DateUpdated: time)
    @userPaymentDetails.save
    
    
    
    @sequence = @userPaymentDetails.ID
    @apiLoginId = AUTHORIZE_NET_CONFIG['api_login_id']
    @txnKey = AUTHORIZE_NET_CONFIG['api_transaction_key'] 
    #@invoiceNumber = HMAC-MD5(@apiLoginId + "^" + @sequence  + "^" +  @amount  + "^" +  @txnKey + "^")
    
    uid = Time.now.to_i
    @uid = uid.to_s[6,9]
    @invoiceNumber = @uid + @userPaymentDetails.ID.to_s + @userPaymentDetails.UserID.to_s
    @userPaymentDetails.TransactionAmount = @amount
    @userPaymentDetails.BLTransactionID = @invoiceNumber
    @userPaymentDetails.save
    #https://developer.authorize.net/tools/paramdump/index.php
    @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :relay_url => "AUTHORIZE_NET_CONFIG['relay_response_url']")
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
      render :text => sim_response.direct_post_reply(AUTHORIZE_NET_CONFIG['receipt_url'])
    else
      render :text => sim_response.direct_post_reply(AUTHORIZE_NET_CONFIG['error_url'])
    end
  end

  # GET
  # Displays a receipt.
  def receipt
    sim_response = AuthorizeNet::SIM::Response.new(params)
    currentTime = Time.new
    time = currentTime.strftime("%Y-%m-%d %H:%M:%S")
    if(sim_response.approved?)
      @invoiceNumber = sim_response.invoice_num
      @transaction_id = sim_response.transaction_id
      @response = sim_response.to_json
      @userPaymentDetails = UserPaymentDetail.find_by(BLTransactionID: @invoiceNumber)
      if(!@userPaymentDetails.blank?)
        @userPaymentDetails.PayTransactionID = @transaction_id
        @userPaymentDetails.ResponseString = @response
        @userPaymentDetails.PaymentStatus = 1  
        @userPaymentDetails.ResponseDateTime = time 
        @userPaymentDetails.DateUpdated = time
        @userPaymentDetails.save
        
        @subscribedUser = SubscribedUser.find_by(ID: @userPaymentDetails.UserID)
        @subscribedUser.IsSubscribed = 1
        @subscribedUser.DateUpdated = time
        @subscribedUser.save
      end
    else
      render :text => 'Sorry, we failed to validate your response. Please check that your "Merchant Hash Value" is set correctly in the config/authorize_net.yml file.'
    end
  end

  # GET
  # Displays an error page.
  def error
    sim_response = AuthorizeNet::SIM::Response.new(params)
    currentTime = Time.new
    time = currentTime.strftime("%Y-%m-%d %H:%M:%S")
    if(!sim_response.blank?)
      @reason = sim_response.response_reason_text
      #@reason_code = sim_response.response_reason_code
      #@response_code = sim_response.response_code
      @invoiceNumber = sim_response.invoice_num
      #@transaction_id = sim_response.transaction_id
      #@response = sim_response.to_json
      @userPaymentDetails = UserPaymentDetail.find_by(BLTransactionID: @invoiceNumber)
      if(!@userPaymentDetails.blank?)
        @userPaymentDetails.PayTransactionID = @transaction_id
        @userPaymentDetails.ResponseString = @reason
        @userPaymentDetails.PaymentStatus = 0  
        @userPaymentDetails.ResponseDateTime = time 
        @userPaymentDetails.DateUpdated = time
        @userPaymentDetails.save
      end
    else
      render :text => 'Sorry, we failed to validate your response. Please check that your "Merchant Hash Value" is set correctly in the config/authorize_net.yml file.'
    end
  end

end
