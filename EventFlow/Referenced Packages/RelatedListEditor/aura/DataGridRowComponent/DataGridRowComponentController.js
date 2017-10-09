({
    doInit : function(component, event, helper) {
        function getCellComponent(column, index){
            var columnType = column.type;
            if(index==0){
                columnType = "ItemLink";
            }         
            
            switch(columnType) {
                case 'Boolean':
                    return "OneDesk:DataGridBooleanCellComponent";
                case 'String':
                    return "OneDesk:DataGridStringCellComponent";                    
                case 'TextArea':
                    return "OneDesk:DataGridTextAreaCellComponent";
                case 'Phone':
                    return "OneDesk:DataGridPhoneCellComponent";
                case 'Email':
                    return "OneDesk:DataGridEmailCellComponent";
                case 'Url':
                    return "OneDesk:DataGridUrlCellComponent";
                case 'Currency':
                    return "OneDesk:DataGridCurrencyCellComponent";
                case 'Double':
                    return "OneDesk:DataGridDoubleCellComponent";
                case 'Integer':
                    return "OneDesk:DataGridIntegerCellComponent";
                case 'Percent':
                    return "OneDesk:DataGridPercentCellComponent";
                case 'Date':
                    return "OneDesk:DataGridDateCellComponent";
                case 'Datetime':
                    return "OneDesk:DataGridDatetimeCellComponent";
                case 'PickList':
                    return "OneDesk:DataGridPickListCellComponent";
                case 'Reference':
                    return "OneDesk:DataGridReferenceCellComponent";
                case 'ItemLink':
                    return "OneDesk:DataGridItemLinkCellComponent";
                case 'Formula':
                    return "OneDesk:DataGridFormulaCellComponent";
                default:
                    return "OneDesk:DataGridFormulaCellComponent";
            }            
        }
        var columns = component.get("v.columns");
        var cellComponents = columns.map(function(column, index){
            return [getCellComponent(column, index),{                
                "aura:id" : "cellWrapper",
                "displayMode" : component.get("v.displayMode"),
                "itemRank" : component.get("v.itemRank"),
                "item" : component.get("v.item"),
                "columnRank" : index,
                "column" : column				
            }];    
        });        
        
        $A.createComponents(
            cellComponents, 
            function(components, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    components.forEach(function(subCmp){
                        body.push(subCmp);
                    });
                    component.set("v.body", body);
                }                
                else {
                    if(status === "INCOMPLETE") {
                        console.log("No response from server or client is offline.")
                    }
                    else if (status === "ERROR") {
                        console.log("Error: " + errorMessage);
                    }                    
                }
            }
        );                            
    }
})