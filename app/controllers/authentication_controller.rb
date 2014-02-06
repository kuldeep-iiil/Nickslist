class AuthenticationController < ApplicationController
  skip_before_action :verify_authenticity_token
  def login
    userName = params[:textUserName]
    password = params[:textPassword]
 
      @firstName = params[:hidFirstName]
      @lastName = params[:hidLastName]
      @phoneNumber = params[:hidPhoneNumber]
      @streetAddress = params[:hidStreetAddress]
      @city = params[:hidselectCity]
      @state = params[:hidselectState]
      @zipCode = params[:hidZipCode]
      @redirectUrl = params[:hidredirectUrl]
      #@reviewerID = params[:hidReviewerID]
      #@reviewID = params[:hidReviewID]
      #@reviewCount = params[:hidReviewCount]
    
    @username = userName
    user = authenticate(userName, password)
    @user = user
    if user
      session[:last_seen] = Time.now
      session[:user_id] = user.id
      #session[:user_name] = user.FirstName + " " + user.LastName
      session[:user_name] = "Hi, " + user.FirstName
      
      @userLogin = UserLoginReport.find_by(UserID: user.id)
      if(@userLogin.blank?)
        @userLogin = UserLoginReport.new(UserID: user.id, LoginDateTime: Time.now)
        @userLogin.save
      else
        @userLogin.LoginDateTime = Time.now
        @userLogin.LogOutDateTime = 'NULL'
        @userLogin.save
      end
      
      @userLoginHistory = UserLoginReportHistory.new(UserID: user.id, LoginDateTime: Time.now)
      @userLoginHistory.save
      
      if(@redirectUrl.blank?)
        redirect_to root_url
      end          
    else
      redirect_to root_url, flash:{:hidFirstName => @firstName, :hidLastName => @lastName, :hidPhoneNumber => @phoneNumber, :hidStreetAddress => @streetAddress, :hidselectCity => @city, :hidselectState => @state, :hidZipCode => @zipCode, :redirectUrl => customer_search_GetDetails_url, :userName => @username, :error => "Invalid User Name or Password!"}
    end
  end
  
  def logout
    userID =session[:user_id]
    @userLogin = UserLoginReport.find_by(UserID: userID)
    if(!@userLogin.blank?)
      @userLogin.LogOutDateTime = Time.now
      @userLogin.save
      @userLoginHistory = UserLoginReportHistory.find_by(UserID: userID, LoginDateTime: @userLogin.LoginDateTime)
      if(!@userLoginHistory.blank?)
        @userLoginHistory.LogOutDateTime = Time.now
        @userLoginHistory.save
      end    
    end
      
    session[:user_id] = nil
    session[:user_name] = nil
    redirect_to root_url
  end
  
  def requestpassword
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    
    email_id = params[:textEmail]
    @messageString = ""
    if(!email_id.blank?)
      email = SubscribedUser.find_by(EmailID: email_id)
      if(email.blank?)
        redirect_to authentication_requestpassword_url, :notice => "Email ID is not valid!"
        return false
      else
        encryptedpassword = AuthenticationController.new()
        email_password = encryptedpassword.password_decryption(email.Password, email.Salt)      
        mail = UserMailer.ForgotPassword(email_id, email_password)
        mail.deliver        
        @messageString = "Thank you for submitting your request. Your password will be sent to you by email."
      end
    end 
  end
  
  def ChangePassword
    @banner = SiteContent.find_by(PageCode: 109)
    if(!@banner.blank?)
      @bannerContent = @banner.Content.html_safe
      @bannerHeader = @banner.Title.html_safe
    end
    
    if(!session[:user_id])
      redirect_to nicks_list_Index_url, flash:{:redirectUrl => authentication_SavePassword_url}
    end
  end
  
  def SavePassword
    @userID = session[:user_id]
    currentTime = Time.new
    time = currentTime.strftime("%Y-%m-%d %H:%M:%S")
    if(!@userID.blank?)
      @userDetails = SubscribedUser.find_by(ID: @userID)
      
      @oldPass = params[:textOldPassword]
      @newPass = params[:textPassword]

      if(password_decryption(@userDetails.Password, @userDetails.Salt) == @oldPass)
        if(password_decryption(@userDetails.Password, @userDetails.Salt) != @newPass)
          @userDetails.Password = password_encryption(@newPass, @userDetails.Salt)
          @userDetails.save
        else
          @error = "Old password can not be use to create a new password!"
        end
      else
        @error = "Old password is invalid!"
      end    
    end
    if(!@error.blank?)
      redirect_to authentication_ChangePassword_url, :notice => @error
    else    
      redirect_to user_profile_ViewProfile_url, :notice => "Password changed successfuly!"
    end 
  end
  
  def authenticate(userName, password)
   
    user = SubscribedUser.find_by(UserName: userName)

    #@pass = BCrypt::Engine.hash_secret(password, user.Salt)
    #if user && user.Password == BCrypt::Engine.hash_secret(password, user.Salt)
    if (user && password == password_decryption(user.Password, user.Salt) && user.IsSubscribed && user.IsActivated)
      user
    else
      nil
    end
  end

  def password_encryption(password, salt)
    pass_phrase = "userpassword"
    encrypter = OpenSSL::Cipher::Cipher.new 'AES-128-CBC'
    encrypter.encrypt
    encrypter.pkcs5_keyivgen pass_phrase, salt
    encrypted = encrypter.update password
    encrypted << encrypter.final
    password = encrypted    
    return password
  end
  
  def password_decryption(password, salt)
    pass_phrase = "userpassword"
    decrypter = OpenSSL::Cipher::Cipher.new 'AES-128-CBC'
    decrypter.decrypt
    decrypter.pkcs5_keyivgen pass_phrase, salt
    decrypted = decrypter.update password
    decrypted << decrypter.final
    password = decrypted    
    return password
  end

end
  