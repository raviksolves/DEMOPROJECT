public  class UserController 
{   public Institutes__c acc {get; set;}
    public String get_institute_id  {get;set;}  
    public String get_Mentor_id  {get;set;}
    public List<Student__c> relatedStudents{get;set;}
    public List<Student__c> get_students=new List<Student__c>();
    public List<Institutes__c> UserTemp = new List<Institutes__c>();
    public UserController()
 {
     
 } 
 public List<SelectOption> UserList
 {
     get
     {
         UserTemp = [Select Id, Name  From Institutes__c ];
         
         UserList = new List<SelectOption>();
         
         for(Institutes__c temp : UserTemp)
         {
             UserList.add(new SelectOption(temp.Id, temp.Name));
         }
         return UserList;
     }
     set;
 }
 public List<Mentor__c> relatedMentors
 {
     get
     {
         
       relatedMentors  =new List<Mentor__c>();
         
         relatedMentors = [Select Id, Name,Designation__c From Mentor__c Where Institute__c=:get_institute_id];
       
         
         return relatedMentors;
     }
     set;
 }

  public void info_student()
 {
         
    
         
         get_students = [Select Id, Name,Class__c,City__c,State__c From Student__c Where Students__c=:get_Mentor_id];
         if(get_students.size()!=0){
             relatedStudents=get_students;
             system.debug(get_students);
         }
       
 
 }
 
 
}