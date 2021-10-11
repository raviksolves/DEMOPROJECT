trigger Student_History on Student__c (after update) {
    List<Student_History__c> Record=new List<Student_History__c>();
        if(Trigger.isafter){
        Student__c Newvalue=Trigger.New[0];
        Student__c Oldvalue=Trigger.Old[0];   
        Map<String,Schema.SObjectField> Field=Schema.SObjectType.Student__c.fields.getMap();
        for(string Keys:Field.keyset()){
            if (Newvalue.get(Keys) !=Oldvalue.get(Keys) && Keys!='systemmodstamp' && Keys!='lastmodifieddate'){         
                            Student_History__c recordToInsert=new Student_History__c();
                           recordToInsert.Field_Name__c=String.valueOf(Keys);
                            recordToInsert.Old_Value__c=String.valueOf(Oldvalue.get(Keys));
                            recordToInsert.New_Value__c=string.valueOf(Newvalue.get(Keys));
                           recordToInsert.Record_Id__c=String.valueOf(Newvalue.get('Id'));               
                            Record.add(recordToInsert);               
            }
        }
           insert Record;     
        }
}