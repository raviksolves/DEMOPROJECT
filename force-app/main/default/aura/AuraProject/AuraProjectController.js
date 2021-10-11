({
    init: function(component, event, helper) {
        var action = component.get("c.Object_Name");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {           
                var allValues = response.getReturnValue();
                component.set("v.object", allValues);
            }                    
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } 
                else {
                    console.log("Unknown Error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    handleChange:function(component,event,helper)
    {
        component.set("v.selectedlist",null);
        component.set("v.Boolean",false);
        component.set("v.Query",null);
        console.log(event.getParam("value"));
        var obj=component.find('objId').get('v.value');
        component.set('v.selectedObj',JSON.parse(JSON.stringify(obj))[0]); 
        var ob1=component.get('v.selectedObj');
        console.log(ob1);
        
        var action = component.get("c.getObjectField");
        action.setParams({
            "object_Name" : ob1
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var plValues = [];
                for (var i = 0; i < result.length; i++) {
                    plValues.push({
                        label: result[i],
                        value: result[i]
                    });
                }
                component.set("v.options", plValues);
                //console.log("{!v.selectedlist}");
           
          
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " +
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);
    },
    getSelectedQuery:function(component,event){
        
        let arr=event.getParam("arr");
        var selectedOptionValue = event.getParam("value");
        var result=(`SELECT ${selectedOptionValue.toString()} FROM ${component.find("objId").get("v.value")}`);
        component.set("v.Query", result);
        
        
        
},

    getResult : function(component, event,helper) {
        component.set("v.Boolean",true);
        var Query1=component.get("v.Query");
        let column=component.get("v.selectedlist");
        var arrcpy=[]
        arrcpy.push(column);
        component.set("v.columns",arrcpy);
        let action=component.get("c.executeSoql");
        console.log(action);
        action.setParams({
                Query_push:Query1
            });
            action.setCallback(this, function(response){
                let state = response.getState();
                var query_result = response.getReturnValue();
                if (state === "SUCCESS"){
                    component.set("v.data",query_result);
                    var fieldValues1 = [];
                    for(var key in column)
                    {
                        fieldValues1.push({label:column[key],fieldName: column[key]});
                    }
                }
                component.set("v.columns", fieldValues1);
                console.log(fieldValues1);
        
        
        });
  		$A.enqueueAction(action);
    }
})