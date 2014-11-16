function listViewPhoneController() {

    this.replacePhoneNumbers = function() {

        var j$ = jQuery.noConflict();
		var phIndex = 0;
		j$(document).ready(function()
		{
			var objDesc=''; 
			var objectPefix = window.location.href.substring( window.location.href.indexOf('.com/') + 5, window.location.href.indexOf('.com/') + 8 );
			
			var result = sforce.connection.describeGlobal();
			var sobjects = result.getArray("sobjects");  
			for (var i=0; i<sobjects.length; i++) 
			{    
				if(sobjects[i].keyPrefix == objectPefix) 
				{ 
					var result1 = sforce.connection.describeSObject(sobjects[i].name); 
					 
					for (var a=0; a<result1.fields.length; a++) 
					{    
						
						var field = result1.fields[a];    
						if(field.name == "synety__Custom_Phone__c")
							alert(field);
						//objDesc+=field.name + ":" + field.label + ", ";  
						if(field.type == "phone")
						{
							phoneFieldsName[phIndex] = field.name;
							phoneFieldsLabel[phIndex] = field.label;
							phIndex++;
						}
					}
					alert(phoneFieldsName);
					//document.getElementById('objectDesc').innerHTML=objDesc; 
				}  
			}
		});
    }
}