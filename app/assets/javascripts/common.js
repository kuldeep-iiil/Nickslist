function SignupForm_visibility(chk) {
	var idSignupCode = document.getElementById('SignupCode');
    var idSignupReadOnlyCode = document.getElementById('SignupReadOnlyCode');
    var idSignupForm = document.getElementById('SignupForm');
    if(chk.checked)
    {
		idSignupCode.style.display = 'block';
        idSignupReadOnlyCode.style.display = 'none';
        idSignupForm.style.display = 'none';
	}
	else
	{
		idSignupCode.style.display = 'none';
		idSignupReadOnlyCode.style.display = 'none';
		idSignupForm.style.display = 'block';
		
		document.getElementById('chkAddress').checked = false;
		document.getElementById('chkAddress').disabled = false;
        document.getElementById('textCompany').value= '';
        document.getElementById('textCompany').readOnly = false;
        document.getElementById('textFirstName').value= '';
        document.getElementById('textFirstName').readOnly = false;
        document.getElementById('textLastName').value= '';
        document.getElementById('textLastName').readOnly = false;
    	document.getElementById('textIncorporationType').value= '';
		document.getElementById('textIncorporationType').readOnly = false;
		document.getElementById('textBussStreetAddress').value= '';
    	document.getElementById('textBussStreetAddress').readOnly = false;
    	document.getElementById('textBussCity').value= '';
    	document.getElementById('textBussCity').readOnly = false;
    	document.getElementById('textBussState').value= '';
    	document.getElementById('textBussState').readOnly = false;
    	document.getElementById('textBussZipCode').value= '';
    	document.getElementById('textBussZipCode').readOnly = false;
    	document.getElementById('textMailStreetAddress').value= '';
    	document.getElementById('textMailStreetAddress').readOnly = false;
    	document.getElementById('textMailCity').value= '';
    	document.getElementById('textMailCity').readOnly = false;
    	document.getElementById('textMailState').value= '';
    	document.getElementById('textMailState').readOnly = false;
    	document.getElementById('textMailZipCode').value= '';
    	document.getElementById('textMailZipCode').readOnly = false;
    	document.getElementById('textEmail').value= '';
        document.getElementById('textEmail').readOnly = false;
        document.getElementById('textConfirmEmail').value= '';
        document.getElementById('textConfirmEmail').readOnly = false;
    	document.getElementById('textPhoneNumber').value= '';
    	document.getElementById('textPhoneNumber').readOnly = false;
    	document.getElementById('textLicense').value= '';
    	document.getElementById('textLicense').readOnly = false;
    	document.getElementById('textUserName').value= '';
        document.getElementById('textUserName').readOnly = false;
        document.getElementById('textPassword').value= '';
        document.getElementById('textPassword').readOnly = false;
    	document.getElementById('textConfirmPassword').value= '';
    	document.getElementById('textConfirmPassword').readOnly = false;
	}
}

function Change_CheckCode(){
	document.getElementById('SignupCode').style.display = 'block';
    document.getElementById('SignupReadOnlyCode').style.display = 'none';
    document.getElementById('SignupForm').style.display = 'none';
    document.getElementById('chkCode').disabled = false;
    
    document.getElementById('textCode').value = '';
    document.getElementById('textCompany').value= '';
    document.getElementById('textIncorporationType').value= '';
    document.getElementById('textBussStreetAddress').value= '';
    document.getElementById('textBussCity').value= '';
    document.getElementById('textBussState').value= '';
    document.getElementById('textBussZipCode').value= '';
    document.getElementById('textMailStreetAddress').value= '';
    document.getElementById('textMailCity').value= '';
    document.getElementById('textMailState').value= '';
    document.getElementById('textMailZipCode').value= '';
    document.getElementById('textPhoneNumber').value= '';
    document.getElementById('textLicense').value= '';
}

function check_chkAddress(chk){
	var idSignupCode = document.getElementById('SignupCode');
    var idSignupReadOnlyCode = document.getElementById('SignupReadOnlyCode');
    var idSignupForm = document.getElementById('SignupForm');
    if(chk.checked)
    {
    	document.getElementById('textMailStreetAddress').value= document.getElementById('textBussStreetAddress').value;
		document.getElementById('textMailStreetAddress').readOnly= true;
    	document.getElementById('textMailCity').value= document.getElementById('textBussCity').value;
		document.getElementById('textMailCity').readOnly= true;
    	document.getElementById('textMailState').value= document.getElementById('textBussState').value;
		document.getElementById('textMailState').readOnly= true;
    	document.getElementById('textMailZipCode').value= document.getElementById('textBussZipCode').value;
		document.getElementById('textMailZipCode').readOnly= true;
	}
	else
	{
		document.getElementById('textMailStreetAddress').value= '';
		document.getElementById('textMailStreetAddress').readOnly= false;
    	document.getElementById('textMailCity').value= '';
    	document.getElementById('textMailCity').readOnly= false;
    	document.getElementById('textMailState').value= '';
    	document.getElementById('textMailState').readOnly= false;
    	document.getElementById('textMailZipCode').value= '';
    	document.getElementById('textMailZipCode').readOnly= false;
	}
}

function SignupForm_AuthUser(authCode, companyName, incorporationType, bussStreetAddress, bussCity, bussState, bussZipCode, mailStreetAddress, mailCity, mailState, mailZipCode, phoneNumber, email, license) {
	var idSignupCode = document.getElementById('SignupCode');
    var idSignupReadOnlyCode = document.getElementById('SignupReadOnlyCode');
    var idSignupForm = document.getElementById('SignupForm');
    
    if(authCode!= '')
    {
		idSignupCode.style.display = 'none';
        idSignupReadOnlyCode.style.display = 'block';
        idSignupForm.style.display = 'block';
        		
        document.getElementById('chkCode').checked = true;
        document.getElementById('chkCode').disabled = true;
        document.getElementById('textFilledCode').value = authCode;
        document.getElementById('hiddenFilledCode').value = authCode;
        document.getElementById('textFilledCode').readOnly = true;
        document.getElementById('textCompany').value= companyName;
        document.getElementById('textCompany').readOnly = true;
    	document.getElementById('textIncorporationType').value= incorporationType;
		document.getElementById('textIncorporationType').readOnly = true;
		document.getElementById('textBussStreetAddress').value= bussStreetAddress;
    	document.getElementById('textBussStreetAddress').readOnly = true;
    	document.getElementById('textBussCity').value= bussCity;
    	document.getElementById('textBussCity').readOnly = true;
    	document.getElementById('textBussState').value= bussState;
    	document.getElementById('textBussState').readOnly = true;
    	document.getElementById('textBussZipCode').value= bussZipCode;
    	document.getElementById('textBussZipCode').readOnly = true;
    	document.getElementById('textMailStreetAddress').value= mailStreetAddress;
    	document.getElementById('textMailStreetAddress').readOnly = true;
    	document.getElementById('textMailCity').value= mailCity;
    	document.getElementById('textMailCity').readOnly = true;
    	document.getElementById('textMailState').value= mailState;
    	document.getElementById('textMailState').readOnly = true;
    	document.getElementById('textMailZipCode').value= mailZipCode;
    	document.getElementById('textMailZipCode').readOnly = true;
    	document.getElementById('textPhoneNumber').value= phoneNumber;
    	document.getElementById('textPhoneNumber').readOnly = true;
    	document.getElementById('textLicense').value= license;
    	document.getElementById('textLicense').readOnly = true;
    			
    	if(bussStreetAddress==mailStreetAddress && bussCity==mailCity && bussState==mailState && bussZipCode==mailZipCode){
    		document.getElementById('chkAddress').checked = true;				    				
    	}
    	else
    	{
    		document.getElementById('chkAddress').checked = false;	
    	}
    		document.getElementById('chkAddress').disabled = true;
		}
	else
	{
		idSignupCode.style.display = 'none';
		idSignupReadOnlyCode.style.display = 'none';
		idSignupForm.style.display = 'block';
	}
}