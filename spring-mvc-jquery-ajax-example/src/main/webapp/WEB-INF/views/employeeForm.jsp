<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BORAJI.COM</title>

<style type="text/css">
  span.error{
    color: red;
    margin-left: 5px;
  }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	/*  Submit form using Ajax */
	$('button[type=submit]').click(function(e) {
		
		//Prevent default submission of form
		e.preventDefault();
		
		//Remove all errors
		$('input').next().remove();
		
		$.post({
			url : 'saveEmployee',
			data : $('form[name=employeeForm]').serialize(),
			success : function(res) {
				
				if(res.validated){
					//Set response
					$('#resultContainer pre code').text(JSON.stringify(res.employee));
					$('#resultContainer').show();
					
				}else{
					//Set error messages
					$.each(res.errorMessages,function(key,value){
						$('input[name='+key+']').after('<span class="error">'+value+'</span>');
					});
				}
			}
		})
	});
});
</script>
</head>
<body>
  <h1>Employee Input Form</h1>
  <hr />

  <form action="saveEmployee" method="post" name="employeeForm">
    <table>
      <tr>
        <td>First Name</td>
        <td><input name="firstName" type="text" /></td>
      </tr>
      <tr>
        <td>Last Name</td>
        <td><input name="lastName" type="text" /></td>
      </tr>
      <tr>
        <td>Email</td>
        <td><input name="email" type="text" /></td>
      </tr>
      <tr>
        <td>Designation</td>
        <td><input name="designation" type="text" /></td>
      </tr>
      <tr>
        <td></td>
        <td><button type="submit">Submit</button></td>
      </tr>
    </table>
  </form>

<!-- Result Container  -->
<div id="resultContainer" style="display: none;">
 <hr/>
 <h4 style="color: green;">JSON Response From Server</h4>
  <pre style="color: green;">
    <code></code>
   </pre>
</div>
</body>
</html>