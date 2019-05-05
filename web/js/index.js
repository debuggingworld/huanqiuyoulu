$(function(){
    //菜单点击J_iframe
 
	 $(".J_menuItem").on('click',function(){
	   return false;
	    });
    
    $("ul.nav li a.top_menu").click(function(){
    	
    	 var txt=$(this).text();
       // $("#jm_show").html("/&nbsp;<a href=''>"+txt+"</a>");
       $("#one_show").html("");
       $("#jm_show").html("/&nbsp;"+txt);
    	 var url = $(this).attr('href');
        $("#J_iframe").attr('src',url);
        return false;
    });
    
      $("ul.nav li a.hassubs_menu").click(function(){
    	
    	 var txt=$(this).text();
       // $("#jm_show").html("/&nbsp;<a href=''>"+txt+"</a>");
    	 $("#jm_show").html("");
       $("#one_show").html("/&nbsp;"+txt);
   
        return false;
    });
    
    
    $("ul.nav-second-level li a.J_menuItem").click(function(){
    	
    	 var txt=$(this).text();
    	$("#jm_show").html("/&nbsp;"+txt);
    	 var url = $(this).attr('href');
        $("#J_iframe").attr('src',url);
        return false;
    });
    
});