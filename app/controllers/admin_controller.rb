class AdminController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def AdminLogin
    userName = params[:textUserName]
    password = params[:textPassword]
    
    @username = userName
    user = authenticate(userName, password)
    @user = user
    if user
      session[:last_seen] = Time.now
      session[:user_id] = user.ID
      #session[:user_name] = user.FirstName + " " + user.LastName
      session[:user_name] = "Hi, " + user.FirstName
      redirect_to admin_AdminPanel_url
      
      #if(@redirectUrl.blank?)
        #redirect_to root_url
      #else
       # redirect_to @redirectUrl, flash:{:hidFirstName => @firstName, :hidLastName => @lastName, :hidPhoneNumber => @phoneNumber, :hidStreetAddress => @streetAddress, :hidselectCity => @citystateVal, :hidZipCode => @zipCode, :hidReviewerID => @reviewerID, :hidReviewID => @reviewID, :hidReviewCount => @reviewCount}  
      #end
    else
      @errorMessage = "Invalid User Name or Password!"
    end
  end
  
  def authenticate(userName, password)
   
    user = SiteUser.find_by(UserName: userName)

    #@pass = BCrypt::Engine.hash_secret(password, user.Salt)
    #if user && user.Password == BCrypt::Engine.hash_secret(password, user.Salt)
    @auth = authentication.new();
    if (user && password == @auth.password_decryption(user.Password, user.Salt) && user.IsSubscribed)
      user
    else
      nil
    end
  end
    
  def requestpassword
    email_id = params[:textEmail]
    if(!email_id.blank?)
      email = SubscribedUser.find_by(EmailID: email_id)
      if(email.blank?)
        redirect_to authentication_requestpassword_url, :notice => "Email ID is not valid!"
        return false
      else
        encryptedpassword = AuthenticationController.new()
        email_password = encryptedpassword.password_decryption(email.Password, email.Salt)      
        mail = UserMailer.forgot_password(email_id, email_password)
        mail.deliver        
        redirect_to root_url, :notice => "Password sent to your Email ID successfully!"
      end
    end 
  end
  
  def AdminPanel
    
  end
  
  def ListUsers
    @subscribedUsers = SubscribedUser.all
  end
  
end
