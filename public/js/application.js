$(document).ready(function() {
  $(".delete").click(function() {
    if(confirm("Sure you want to delete?")){
    	$(this).closest('tr').delay().fadeOut();
    }
    else {
    	return false;
    }
  });

});


