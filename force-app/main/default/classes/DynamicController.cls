public class DynamicController {
@AuraEnabled
    public static List<String> Object_Name(){
        List<String> object_c=new List<String>();
       List<Schema.SObjectType> get_id = Schema.getGlobalDescribe().Values();  
        for(SObjectType s:get_id){
           object_c.add(s.getDescribe().getName());
           object_c.sort();  
        }
        return object_c;
    }
    @AuraEnabled
    public static List<String> getObjectField(String object_Name){
        List<String> field_Name=new List<String>();
        Schema.SobjectType field_ob=Schema.getGlobalDescribe().get(object_Name);
        Schema.DescribeSObjectResult field_obj=field_ob.getDescribe();
        Map<String,Schema.SObjectField> map_obj=field_obj.fields.getMap();
        for(String data:map_obj.keyset())
        {
            Schema.DescribeFieldResult result=map_obj.get(data).getDescribe();
            field_Name.add(result.getName());
            
        }
       field_Name.sort();
       return field_Name;
    }
      @AuraEnabled
  public static List<Sobject> executeSoql(String  Query_push) {
      List<Sobject> Query_field=Database.query(Query_push);
      return Query_field;
      
  }
}