/**************************************************************
 * Description:
 * Some General Function
 *
 **************************************************************/

/*****************************************************************
*			GET CREDENTIAL
******************************************************************/
function getCred()
{
	var cred=document.getElementById("cred").value;
	if(cred!="null")
	{
		return cred;
	}
	
	return null;
}
/*****************************************************************
*			GET USER NAME
******************************************************************/
function getUserName()
{
	var user=document.getElementById("userName").value;
	if(user!="null")
	{
		return user;
	}
	
	return null;
}