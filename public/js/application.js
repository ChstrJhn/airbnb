$(document).ready(function() {
  $("form.delete").submit(function(event) {
  	event.preventDefault();
  	var $target = $(event.target);
    $target.find("input[type=submit]").val("Deleting...");
    
    $.ajax({
    	type: "DELETE",
    	url: $target.attr("action"),
    }).done(function(response){
    	console.log(response);
    	$target.parent().parent().parent().remove();
    })
  });

});