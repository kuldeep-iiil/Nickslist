class UserMailer < ActionMailer::Base
  skip_before_action :verify_authenticity_token
  default from: 'kuldeep.it2008@gmail.com'
  
  def ForgotPassword(email_to, email_password)         
      @password = email_password      
      email_subject = "Password details for the Nicklists login account"        
      @email_message = "Your password is :" + email_password
      mail(to: email_to, subject: email_subject)  
  end  
  
  def WelcomeUser(userfirstName, userlastName, userEmail, invoiceNumber, amount)         
      @userfirstName = userfirstName
      @userlastName = userlastName
      @userEmail = userEmail
      @invoiceNumber = invoiceNumber
      @amount = amount
      email_to = userEmail      
      email_subject = "Welcome to Nickslist!"
      mail(to: email_to, subject: email_subject)  
  end
  
  def NewUserNotification(userfirstName, userlastName, userEmail, invoiceNumber, amount)         
      @userfirstName = userfirstName
      @userlastName = userlastName
      @userEmail = userEmail
      @invoiceNumber = invoiceNumber
      @amount = amount
      email_to = "kuldeep.it2008@gmail.com"      
      email_subject = "User Registration Notification mail!"
      mail(to: email_to, subject: email_subject)  
  end
  
  def ContactUs_Email(userfirstName, userlastName, userEmail, comments, userContact)         
      @userfirstName = userfirstName
      @userlastName = userlastName
      @userEmail = userEmail
      @userContact = userContact
      @comments = comments
      email_to = "kuldeep.it2008@gmail.com"    
      email_subject = "Comment posted by " + userfirstName + " " + userlastName
      mail(to: email_to, subject: email_subject)  
  end
  
  def ReviewAdminNotification(userfirstName, userlastName, userEmail, firstName, lastName, phoneNumber, streetAddress, zipCode, cityState)
      @userfirstName = userfirstName
      @userlastName = userlastName
      @userEmail = userEmail
      @firstName = firstName
      @lastName = lastName
      @phoneNumber = phoneNumber
      @streetAddress = streetAddress
      @zipCode = zipCode
      @cityState = cityState
      email_to = "kuldeep.it2008@gmail.com"    
      email_subject = "Review Notification"
      mail(to: email_to, subject: email_subject)  
  end 
  
  def ReviewUserNotification(userfirstName, userlastName, userEmail, firstName, lastName, phoneNumber, streetAddress, zipCode, cityState)
      @userfirstName = userfirstName
      @userlastName = userlastName
      @userEmail = userEmail
      @firstName = firstName
      @lastName = lastName
      @phoneNumber = phoneNumber
      @streetAddress = streetAddress
      @zipCode = zipCode
      @cityState = cityState
      email_to = userEmail    
      email_subject = "Review Notification"
      mail(to: email_to, subject: email_subject)  
  end   
end
