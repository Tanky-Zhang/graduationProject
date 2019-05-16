$(document).ready(function(){
	$.ajax({
		type : "GET",
		url : "./servlet/ajaxtest",
		success : function(backDate, textStatus, ajax){
					var lmlist = backDate;
					var inputArray = getAllInputById();
					var size = lmlist.length;
					for(var i = 0; i < size; i++){
						var content = lmlist[i];
						inputArray[i].value=""+content;
					}
				},
		error : function(XMLHttpRequest, textStatus, errorThrown){
		                    alert(XMLHttpRequest.status);
		                    alert(XMLHttpRequest.readyState);
		                    alert(textStatus);
		         }
	});
	
	$(".Noprn").click(function(){
		window.location.href = "./servlet/SaveMessage";
		window.print();
	});
});
function getAllInputById(){
	return $('input[type=text]');
}
