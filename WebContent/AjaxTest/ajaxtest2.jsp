<%@ page import="java.sql.*"%>  

<%  
String s=request.getParameter("selected");  

$(document).ready(function() {
    ajax_request($( "#type_service option:selected" ).val());
    
      $(".type_service").change(function() {
        var id = $(this).val();
        ajax_request(id);
      });
    
    });
    function ajax_request(id){
            var dataString = "id=" + id;
        $.ajax({
          type: "POST",
          url: "ajax/ajax_type.php",
          data: dataString,
          cache: false,
          success: function(html) {
            $(".result").html(html);
          }
        });
    }