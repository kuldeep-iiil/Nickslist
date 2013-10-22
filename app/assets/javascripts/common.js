$(document).ready(function(){
 	$('.bxslider').bxSlider({
  		mode: 'horizontal',
  		speed:'500',
  		auto:'true',
  		pause:'5000'
  	});
  	$('.login-register a').click(function(){
		$('#signin_menu').toggle();
	});
});
		
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
	}
}

function Change_CheckCode(){
	document.getElementById('SignupCode').style.display = 'block';
    document.getElementById('SignupReadOnlyCode').style.display = 'none';
    document.getElementById('SignupForm').style.display = 'none';
    
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
    	document.getElementById('textMailCity').value= document.getElementById('textBussCity').value;
    	document.getElementById('textMailState').value= document.getElementById('textBussState').value;
    	document.getElementById('textMailZipCode').value= document.getElementById('textBussZipCode').value;
	}
	else
	{
		document.getElementById('textMailStreetAddress').value= '';
    	document.getElementById('textMailCity').value= '';
    	document.getElementById('textMailState').value= '';
    	document.getElementById('textMailZipCode').value= '';
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