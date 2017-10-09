({
showDetail: function(component, event, helper) {
    var arr = [];
    arr = component.find("main").getElement().childNodes;

/*    console.log(event.target);
    var x = document.getElementById("4");
    alert(x);
    $A.util.addClass(x,"selectedRow"); 
    
    for(var i in component.find("main").getElement().childNodes) {
        alert(i);
//        $A.util.removeClass(arr[i], "selectedRow");
    }*/
    var targetElement = component.find("main").getElement().childNodes[3];
//    var targetElement = event.target;
    $A.util.addClass(targetElement,"selectedRow");
    }
	 
})