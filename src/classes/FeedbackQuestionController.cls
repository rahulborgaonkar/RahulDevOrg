public class FeedbackQuestionController
{        
    String Id = System.currentPageReference().getParameters().get('id'); //
    public Feedback__c feedback {get; set;}    
    public String StudentRollNo { get; set;}
    public String[] rating = new String[]{};
    List<Grouped_Question__c> Question;
    public List<SelectOption> options = new List<SelectOption>();

    String forceURL = URL.getSalesforceBaseUrl().toExternalForm();

    public String[] getRating()
    {
        system.debug('getRating');
        return rating;
    }

    public void setRating(String[] rate)
    {
        system.debug('setRating array');
        rating = rate;
    }

    
    public void setRating(String rate)
    {
        system.debug('setRating single');
        rating.add(rate);
    }

    public FeedbackQuestionController(ApexPages.StandardController stdController)
    {
        system.debug('a');
        StudentRollNo = null;        
        feedback = [ SELECT name, Department__r.name, CreatedDate, Feedback_Link__c, Feedback_Validity_Date__c, Staff__c, Staff_Email__c, Staff_Name__c, Rating_Group__c FROM Feedback__c WHERE Id = :Id ];
        system.debug(feedback);        
    }

    public List<Grouped_Question__c> getQuestion()
    {
        system.debug('c');
        Question = [ SELECT Question__r.name, Group__r.name, Question__r.rating__c FROM Grouped_Question__c where Group__c in (SELECT Group__c FROM Feedback_Group__c WHERE Feedback__c = :Id ) ORDER BY Group__r.name, Question__r.name ];
        system.debug('Question : ' + Question);        
        return Question ;
    }

    public List<SelectOption> getItems()
    {
        system.debug('form rating');
        for ( Related_Rating_Group__c rating : [ SELECT Rating__r.name FROM Related_Rating_Group__c where rating_group__c = :feedback.Rating_Group__c ORDER BY Rating__r.name ] )
        {
            options.add(new SelectOption(rating.Rating__r.name, rating.Rating__r.name));
        
        }    
        system.debug('options :' + options);
        return options;
    }

    public PageReference validate()
    {
        system.debug('validate');

        if (feedback.Feedback_Validity_Date__c < system.now())
        {
            PageReference pageRef = new PageReference(forceURL+'/FeedbackValidatePage?id='+Id);
            return pageRef;
        }
        return null;        
    }

    public PageReference submitfeedback()
    {
        system.debug('submitfeedback');
       
        if ( [ SELECT count() FROM Feedback_Data__c where student_roll_number__c = :StudentRollNo and feedback_name__c = :feedback.name ] == 0 )
        {
            system.debug('Roll no and feedback not exists');
        
            List<Feedback_Data__c> feedbackdata = new List<Feedback_Data__c> ();
            Integer cnt = 0;
            
            system.debug('Question : ' + Question);
            for ( Grouped_Question__c grQ : Question )
            {
                feedbackdata.add( new Feedback_Data__c(feedback_name__c = feedback.name, Student_Roll_Number__c = StudentRollNo, Group_Name__c = grQ.group__r.name, Question_Name__c = grQ.question__r.name, Rating__c = rating[cnt] ));
                cnt++;
            }
            system.debug(feedbackdata);            
            insert feedbackdata;
        }
        PageReference pageRef = new PageReference(forceURL+'/FeedbackThankyouPage?id='+Id);
        return pageRef;
    }
    
    public PageReference sendLink()
    {
        system.debug('Inside sendLink ' + feedback.Staff_Email__c);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSenderDisplayName('clouddev@surashriconsultants.com');
        mail.setToAddresses(new String[] { feedback.Staff_Email__c });
        mail.setSubject('Your Feedback Link Attached');
        mail.setPlainTextBody('Please forward this link to your students for getting Feedback\nhttp://' + feedback.Feedback_Link__c);
        List <Messaging.SendEmailResult> results = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });
        system.debug('Result ' + results);       
        return null;    
    }  
    
}