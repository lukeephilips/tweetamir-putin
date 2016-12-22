  $(document).ready(function() {
    $('select').material_select();
    $(".button-collapse").sideNav();

    $("#submit").click(function(){
       $(".progress").toggle();
   });
  });
