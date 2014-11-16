@isTest (SeeAllData=true)
private class TestFeedbackQuestionController
{
    static PageReference pref;
    static Feedback__c feedback = new Feedback__c();
    static String[] rating = new List<String> {'Two', 'Two', 'Two'};

    static testmethod void TestSubmitFeedback()
    {
        pref = new PageReference('FeedbackPage');
        pref.getParameters().put('id','a089000000BFXdx');
        Test.setCurrentPage(pref);
        ApexPages.StandardController stdController = new ApexPages.StandardController(feedback);
        FeedbackQuestionController FeedbackQC = new FeedbackQuestionController( stdController );
        Test.startTest();
        FeedbackQC.getItems();
        FeedbackQC.getquestion();
        FeedbackQC.studentrollno = '99';
        FeedbackQC.setrating(rating);
        FeedbackQC.setrating('Four');
        FeedbackQC.setrating('Four');
        FeedbackQC.submitfeedback();
        Test.stopTest();
    }
    
    static testmethod void TestPositiveValidate()
    {
        pref = new PageReference('FeedbackPage');
        pref.getParameters().put('id','a089000000BFXdx');
        Test.setCurrentPage(pref);
        ApexPages.StandardController stdController = new ApexPages.StandardController(feedback);
        FeedbackQuestionController FeedbackQC = new FeedbackQuestionController( stdController );
        Test.startTest();
        FeedbackQC.validate();
        Test.stopTest();
    }

    static testmethod void TestNegativeValidate()
    {
        pref = new PageReference('FeedbackPage');
        pref.getParameters().put('id','a089000000BFXbT');
        Test.setCurrentPage(pref);
        ApexPages.StandardController stdController = new ApexPages.StandardController(feedback);
        FeedbackQuestionController FeedbackQC = new FeedbackQuestionController( stdController );
        Test.startTest();
        FeedbackQC.validate();
        Test.stopTest();
    }
}