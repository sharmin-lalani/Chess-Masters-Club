<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Chess Masters Club</title>
<link href="stylesheets/common.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="stylesheets/jquery-ui.css" />
<script src="js/jquery-1.8.3.js"></script>
  <script src="js/jquery-ui.js"></script>
  <script>
$(function() {
   // $( "#datepicker" ).datepicker();
});
</script>
<script language="javascript" type="text/javascript">
window.onload=function()
{
avail=0;
avil=0;
filter = /^([a-z0-9_\.\-])+\@(([a-z0-9\-])+\.)+([a-z0-9]{2,4})+$/;

emailid=document.getElementById("email"); 
uname=document.getElementById("uname"); 
}

function check()
{
var pass=document.getElementById("mypassword");
var repass=document.getElementById("repassword");


if(uname.value.length<4 && uname.value.length>20)
{
alert("Username should be of atleast 4 characters and not more than 20 characters!");
return false;
}

if(pass.value.length<5)
{
alert("Password should be of atleast 5 characters!");
return false;
}

if(pass.value.length>20)
{
alert("Password should not be more than 20 characters!");
return false;
}

if(pass.value!=repass.value)
{
alert("Enter the same password in both the fields!");
return false;
}

if (!filter.test(emailid.value)) 
{
alert('Please provide a valid email address. Email address should be in small case.');
return false;
}


if(emailid.value.length>30)
{
alert("Email should not be more than 30 characters!");
return false;
}
 
if(avail==0)
   {
    alert('Please provide another email address');
	return false;
	}
	
if(avil==0)
{
 alert('Please provide another username');
	return false;
	}
else return true;
};


function username(v1,id)
{

if(uname.value.length<4)
	return;
	
var xmlhttp;
if (window.XMLHttpRequest)
{
// code for IE7 , Firefox, Chrome, Opera, Safari
xmlhttp=new XMLHttpRequest();
}
else
{
// code for IE6, IE5
xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.onreadystatechange=function()
{
if (xmlhttp.readyState==4 && xmlhttp.status==200)
{
id=document.getElementById(id);
avil=xmlhttp.responseText;
if(avil==0)
id.innerHTML="Unavailable!"
else id.innerHTML="Available!"
// In this id is id of webpage part where the ajax update the content
}
}
xmlhttp.open("GET","check_username.jsp?value="+v1,true);
//here the url of server page and send required value to
xmlhttp.send();
}



function usermail(v1,id)
{

	if (!filter.test(emailid.value))
	return;
	
var xmlhttp;
if (window.XMLHttpRequest)
{
// code for IE7 , Firefox, Chrome, Opera, Safari
xmlhttp=new XMLHttpRequest();
}
else
{
// code for IE6, IE5
xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.onreadystatechange=function()
{
if (xmlhttp.readyState==4 && xmlhttp.status==200)
{
id=document.getElementById(id);
avail=xmlhttp.responseText;
if(avail==0)
id.innerHTML="Unavailable!"
else id.innerHTML="Available!"
// In this id is id of webpage part where the ajax update the content
}
}
xmlhttp.open("GET","check_email.jsp?value="+v1,true);
//here the url of server page and send required value to
xmlhttp.send();
}


function changeCaptcha()
{
	
var capt=document.getElementById("captcha");
capt.src="Cap_Img.jsp" ;
}


</script>

</head>
<body style="Background-color:#eee;">
	<!-- Start Header -->
	<div id="header">
    
		<div class="container">
            
	
    <jsp:include page="session.jsp" />
    
			<!-- top navigation -->
			<ul id="navigation">
				<li class="active"><a href="index.jsp">Home</a></li>
				<li><a href="game_play.jsp" >Game Play</a></li>
				<li><a href="tutorial.jsp" >Tutorials</a></li>
				<li><a href="tournaments.jsp" >Tournaments</a></li>
				<li><a href="faq.jsp" >FAQs</a></li>   
			</ul>
            
            
			<!-- banner message and building background -->
			<div id="banner">
				<p>
                An Online Chess Club where game lovers can learn and play Chess games with their friends or other players. 
                </p> 
			</div>
			<hr />
            
		</div>
	</div>

    
	<!-- Start Main Content -->
	<div id="main" class="container" style="Background-color:#fff;">
		<!-- left column -->
		 <div id="leftcolumn">
			
		</div>
		<!-- main content area -->
		<div id="center">
			<div class="article_wrapper">
				<div id="main" align="center" >
			<h2 style="color:#900; font-size:16px;">
	<% 
		String error=(String)request.getAttribute("error");
	if(error!=null)
	{
		out.println(error);
	}
	%></h2>
					<p style="color:#900; font-size:14px;">*Required Fields</p>
	<center>
	
	<form name="signup" action="Signup" method="post" onsubmit="return check();">
		<table id="signup" cellpadding="15px;">
			<tr>
				<td>First Name*</td>
				<td>:</td>
				<td><input type="text" name="fname" id="fname" required="required" /></td>
			</tr>
			<tr>
				<td>Last Name*</td>
				<td>:</td>
				<td><input type="text" name="lname" id="lname" required="required"/></td>
			</tr>
			<tr>
				<td>Username*</td>
				<td>:</td>
				<td><input type="text" name="uname" id="uname" pattern="[0-9a-zA-Z]*" autocomplete="off" required="required" onkeyup="username(this.value,'avil')"/></td>
				<td id="avil"></td>
			</tr>
			<tr>
				<td>Password*</td>
				<td>:</td>
				<td><input type="password" name="password" id="mypassword" required="required" /></td>
			</tr>
			<tr>
				<td>Re-type Password*</td>
				<td>:</td>
				<td><input type="password" id="repassword" required="required" /></td>
			</tr>
			
			<tr>
				<td>Phone</td>
				<td>:</td>
				<td><input type="text" name="phone" pattern="[0-9]{10}" /></td>
			</tr>
			<tr>
				<td>Email*</td>
				<td>:</td>
				<td><input type="text" name="email" id="email" autocomplete="off" required="required" onkeyup="usermail(this.value,'avail')" /></td>
                <td id="avail"></td>
			</tr>
			<tr>
				<td>Date of Birth</td>
				<td>:</td>
				<td>
				<input type="text" size="4" name="dob1" pattern=[0-9]{4} placeholder="YYYY"/>-
				<input type="text" size="2" name="dob2" pattern=[0-9]* placeholder="MM"/>-
				<input type="text" size="2" name="dob3" pattern=[0-9]* placeholder="DD"/>
				</td>
			</tr>
			<tr>
				<td>Country</td>
				<td>:</td> 
				<td>
				<select name="country">
<option value="">Country...</option>
<option value="Afganistan">Afghanistan</option>
<option value="Albania">Albania</option>
<option value="Algeria">Algeria</option>
<option value="American Samoa">American Samoa</option>
<option value="Andorra">Andorra</option>
<option value="Angola">Angola</option>
<option value="Anguilla">Anguilla</option>
<option value="Antigua &amp; Barbuda">Antigua &amp; Barbuda</option>
<option value="Argentina">Argentina</option>
<option value="Armenia">Armenia</option>
<option value="Aruba">Aruba</option>
<option value="Australia">Australia</option>
<option value="Austria">Austria</option>
<option value="Azerbaijan">Azerbaijan</option>
<option value="Bahamas">Bahamas</option>
<option value="Bahrain">Bahrain</option>
<option value="Bangladesh">Bangladesh</option>
<option value="Barbados">Barbados</option>
<option value="Belarus">Belarus</option>
<option value="Belgium">Belgium</option>
<option value="Belize">Belize</option>
<option value="Benin">Benin</option>
<option value="Bermuda">Bermuda</option>
<option value="Bhutan">Bhutan</option>
<option value="Bolivia">Bolivia</option>
<option value="Bonaire">Bonaire</option>
<option value="Bosnia &amp; Herzegovina">Bosnia &amp; Herzegovina</option>
<option value="Botswana">Botswana</option>
<option value="Brazil">Brazil</option>
<option value="British Indian Ocean Ter">British Indian Ocean Ter</option>
<option value="Brunei">Brunei</option>
<option value="Bulgaria">Bulgaria</option>
<option value="Burkina Faso">Burkina Faso</option>
<option value="Burundi">Burundi</option>
<option value="Cambodia">Cambodia</option>
<option value="Cameroon">Cameroon</option>
<option value="Canada">Canada</option>
<option value="Canary Islands">Canary Islands</option>
<option value="Cape Verde">Cape Verde</option>
<option value="Cayman Islands">Cayman Islands</option>
<option value="Central African Republic">Central African Republic</option>
<option value="Chad">Chad</option>
<option value="Channel Islands">Channel Islands</option>
<option value="Chile">Chile</option>
<option value="China">China</option>
<option value="Christmas Island">Christmas Island</option>
<option value="Cocos Island">Cocos Island</option>
<option value="Colombia">Colombia</option>
<option value="Comoros">Comoros</option>
<option value="Congo">Congo</option>
<option value="Cook Islands">Cook Islands</option>
<option value="Costa Rica">Costa Rica</option>
<option value="Cote DIvoire">Cote D'Ivoire</option>
<option value="Croatia">Croatia</option>
<option value="Cuba">Cuba</option>
<option value="Curaco">Curacao</option>
<option value="Cyprus">Cyprus</option>
<option value="Czech Republic">Czech Republic</option>
<option value="Denmark">Denmark</option>
<option value="Djibouti">Djibouti</option>
<option value="Dominica">Dominica</option>
<option value="Dominican Republic">Dominican Republic</option>
<option value="East Timor">East Timor</option>
<option value="Ecuador">Ecuador</option>
<option value="Egypt">Egypt</option>
<option value="El Salvador">El Salvador</option>
<option value="Equatorial Guinea">Equatorial Guinea</option>
<option value="Eritrea">Eritrea</option>
<option value="Estonia">Estonia</option>
<option value="Ethiopia">Ethiopia</option>
<option value="Falkland Islands">Falkland Islands</option>
<option value="Faroe Islands">Faroe Islands</option>
<option value="Fiji">Fiji</option>
<option value="Finland">Finland</option>
<option value="France">France</option>
<option value="French Guiana">French Guiana</option>
<option value="French Polynesia">French Polynesia</option>
<option value="French Southern Ter">French Southern Ter</option>
<option value="Gabon">Gabon</option>
<option value="Gambia">Gambia</option>
<option value="Georgia">Georgia</option>
<option value="Germany">Germany</option>
<option value="Ghana">Ghana</option>
<option value="Gibraltar">Gibraltar</option>
<option value="Great Britain">Great Britain</option>
<option value="Greece">Greece</option>
<option value="Greenland">Greenland</option>
<option value="Grenada">Grenada</option>
<option value="Guadeloupe">Guadeloupe</option>
<option value="Guam">Guam</option>
<option value="Guatemala">Guatemala</option>
<option value="Guinea">Guinea</option>
<option value="Guyana">Guyana</option>
<option value="Haiti">Haiti</option>
<option value="Hawaii">Hawaii</option>
<option value="Honduras">Honduras</option>
<option value="Hong Kong">Hong Kong</option>
<option value="Hungary">Hungary</option>
<option value="Iceland">Iceland</option>
<option value="India">India</option>
<option value="Indonesia">Indonesia</option>
<option value="Iran">Iran</option>
<option value="Iraq">Iraq</option>
<option value="Ireland">Ireland</option>
<option value="Isle of Man">Isle of Man</option>
<option value="Israel">Israel</option>
<option value="Italy">Italy</option>
<option value="Jamaica">Jamaica</option>
<option value="Japan">Japan</option>
<option value="Jordan">Jordan</option>
<option value="Kazakhstan">Kazakhstan</option>
<option value="Kenya">Kenya</option>
<option value="Kiribati">Kiribati</option>
<option value="Korea North">Korea North</option>
<option value="Korea Sout">Korea South</option>
<option value="Kuwait">Kuwait</option>
<option value="Kyrgyzstan">Kyrgyzstan</option>
<option value="Laos">Laos</option>
<option value="Latvia">Latvia</option>
<option value="Lebanon">Lebanon</option>
<option value="Lesotho">Lesotho</option>
<option value="Liberia">Liberia</option>
<option value="Libya">Libya</option>
<option value="Liechtenstein">Liechtenstein</option>
<option value="Lithuania">Lithuania</option>
<option value="Luxembourg">Luxembourg</option>
<option value="Macau">Macau</option>
<option value="Macedonia">Macedonia</option>
<option value="Madagascar">Madagascar</option>
<option value="Malaysia">Malaysia</option>
<option value="Malawi">Malawi</option>
<option value="Maldives">Maldives</option>
<option value="Mali">Mali</option>
<option value="Malta">Malta</option>
<option value="Marshall Islands">Marshall Islands</option>
<option value="Martinique">Martinique</option>
<option value="Mauritania">Mauritania</option>
<option value="Mauritius">Mauritius</option>
<option value="Mayotte">Mayotte</option>
<option value="Mexico">Mexico</option>
<option value="Midway Islands">Midway Islands</option>
<option value="Moldova">Moldova</option>
<option value="Monaco">Monaco</option>
<option value="Mongolia">Mongolia</option>
<option value="Montserrat">Montserrat</option>
<option value="Morocco">Morocco</option>
<option value="Mozambique">Mozambique</option>
<option value="Myanmar">Myanmar</option>
<option value="Nambia">Nambia</option>
<option value="Nauru">Nauru</option>
<option value="Nepal">Nepal</option>
<option value="Netherland Antilles">Netherland Antilles</option>
<option value="Netherlands">Netherlands (Holland, Europe)</option>
<option value="Nevis">Nevis</option>
<option value="New Caledonia">New Caledonia</option>
<option value="New Zealand">New Zealand</option>
<option value="Nicaragua">Nicaragua</option>
<option value="Niger">Niger</option>
<option value="Nigeria">Nigeria</option>
<option value="Niue">Niue</option>
<option value="Norfolk Island">Norfolk Island</option>
<option value="Norway">Norway</option>
<option value="Oman">Oman</option>
<option value="Pakistan">Pakistan</option>
<option value="Palau Island">Palau Island</option>
<option value="Palestine">Palestine</option>
<option value="Panama">Panama</option>
<option value="Papua New Guinea">Papua New Guinea</option>
<option value="Paraguay">Paraguay</option>
<option value="Peru">Peru</option>
<option value="Phillipines">Philippines</option>
<option value="Pitcairn Island">Pitcairn Island</option>
<option value="Poland">Poland</option>
<option value="Portugal">Portugal</option>
<option value="Puerto Rico">Puerto Rico</option>
<option value="Qatar">Qatar</option>
<option value="Republic of Montenegro">Republic of Montenegro</option>
<option value="Republic of Serbia">Republic of Serbia</option>
<option value="Reunion">Reunion</option>
<option value="Romania">Romania</option>
<option value="Russia">Russia</option>
<option value="Rwanda">Rwanda</option>
<option value="St Barthelemy">St Barthelemy</option>
<option value="St Eustatius">St Eustatius</option>
<option value="St Helena">St Helena</option>
<option value="St Kitts-Nevis">St Kitts-Nevis</option>
<option value="St Lucia">St Lucia</option>
<option value="St Maarten">St Maarten</option>
<option value="St Pierre &amp; Miquelon">St Pierre &amp; Miquelon</option>
<option value="St Vincent &amp; Grenadines">St Vincent &amp; Grenadines</option>
<option value="Saipan">Saipan</option>
<option value="Samoa">Samoa</option>
<option value="Samoa American">Samoa American</option>
<option value="San Marino">San Marino</option>
<option value="Sao Tome & Principe">Sao Tome &amp; Principe</option>
<option value="Saudi Arabia">Saudi Arabia</option>
<option value="Senegal">Senegal</option>
<option value="Seychelles">Seychelles</option>
<option value="Sierra Leone">Sierra Leone</option>
<option value="Singapore">Singapore</option>
<option value="Slovakia">Slovakia</option>
<option value="Slovenia">Slovenia</option>
<option value="Solomon Islands">Solomon Islands</option>
<option value="Somalia">Somalia</option>
<option value="South Africa">South Africa</option>
<option value="Spain">Spain</option>
<option value="Sri Lanka">Sri Lanka</option>
<option value="Sudan">Sudan</option>
<option value="Suriname">Suriname</option>
<option value="Swaziland">Swaziland</option>
<option value="Sweden">Sweden</option>
<option value="Switzerland">Switzerland</option>
<option value="Syria">Syria</option>
<option value="Tahiti">Tahiti</option>
<option value="Taiwan">Taiwan</option>
<option value="Tajikistan">Tajikistan</option>
<option value="Tanzania">Tanzania</option>
<option value="Thailand">Thailand</option>
<option value="Togo">Togo</option>
<option value="Tokelau">Tokelau</option>
<option value="Tonga">Tonga</option>
<option value="Trinidad &amp; Tobago">Trinidad &amp; Tobago</option>
<option value="Tunisia">Tunisia</option>
<option value="Turkey">Turkey</option>
<option value="Turkmenistan">Turkmenistan</option>
<option value="Turks &amp; Caicos Is">Turks &amp; Caicos Is</option>
<option value="Tuvalu">Tuvalu</option>
<option value="Uganda">Uganda</option>
<option value="Ukraine">Ukraine</option>
<option value="United Arab Erimates">United Arab Emirates</option>
<option value="United Kingdom">United Kingdom</option>
<option value="United States of America">United States of America</option>
<option value="Uraguay">Uruguay</option>
<option value="Uzbekistan">Uzbekistan</option>
<option value="Vanuatu">Vanuatu</option>
<option value="Vatican City State">Vatican City State</option>
<option value="Venezuela">Venezuela</option>
<option value="Vietnam">Vietnam</option>
<option value="Virgin Islands (Brit)">Virgin Islands (Brit)</option>
<option value="Virgin Islands (USA)">Virgin Islands (USA)</option>
<option value="Wake Island">Wake Island</option>
<option value="Wallis &amp; Futana Is">Wallis &amp; Futana Is</option>
<option value="Yemen">Yemen</option>
<option value="Zaire">Zaire</option>
<option value="Zambia">Zambia</option>
<option value="Zimbabwe">Zimbabwe</option>
</select>
				</td>
			</tr>
			<tr>
				<td>Gender</td>
				<td>:</td>
				<td><input type="radio" name="sex" value="m" />Male
					<input type="radio" name="sex" value="f" />Female
				</td>
			</tr>
			
			<!--tr>	
				<td>	
				<label for="file">Upload Photo</label>
				</td>
				<td>:</td>
				<td>
				<input type="file" name="image" id="image" /><br/>
				</td>
			</tr-->
			
			<tr>
				<td>Description</td>
				<td>:</td>
				<td><textarea name="desc" rows="2" cols="20"></textarea></td>
			</tr>
			
			<tr> <td colspan="2" ><br /><img id="captcha" src="Cap_Img.jsp" /></td>
			<td><input name="number" type="text" /></td>
			</tr>
			<tr>
			<td><input id="button" type="button" value="Refresh Image" onclick="window.location.href=window.location.href" /></td>
			<td colspan="2">Please enter the string shown in the image.</td>
			</tr>
		
		</table>
		<div>
			<input type="submit" id="button" name="submit" style="padding:5px 10px;" value="Sign Up"  />
		</div>
	</form>
	</center>
</div>


			</div>
			
			<hr />
		</div>
		<!-- product sales boxes -->
		<div id="rightcolumn">
			
		</div>
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
