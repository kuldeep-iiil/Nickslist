class UserMailer < ActionMailer::Base
  skip_before_action :verify_authenticity_token
  default from: 'kuldeep.it2008@gmail.com'
  
  def forgot_password(email_id, email_password)         
      @password = email_password      
      email_subject = "Password details for the Nicklists login account"        
      email_message = "Your password is :" + email_password
      mail(to: email_id, subject: email_subject)  
  end  
  
  def welcome_user(email_id, firstName, lastName, transactionID, timestamp, responseStatus, amount)         
      @firstName = firstName
      @lastName = lastName
      @transactionID = transactionID
      @timestamp = timestamp
      @responseStatus = responseStatus
      @amount = amount      
      email_subject = "Welcome to Nickslist"        
     #email_message = "Your password is :" + email_password
      mail(to: email_id, subject: email_subject)  
  end
  
  def ContactUs_Email(userfirstName, userlastName, userEmail, comments, userContact)         
      @userfirstName = userfirstName
      @userlastName = userlastName
      @userEmail = userEmail
      @userContact = userContact
      @comments = comments   
      email_subject = "Comment posted by " + userfirstName + " " + userlastName        
      email_message = "Comments :" + comments
      mail(to: 'kuldeep.it2008@gmail.com', subject: email_subject)  
  end  
end
