@isTest (SeeAllData=true)
private class TestUpdateGroupName 
{
    static testmethod void InsertGroupedQuestion()
	{
        Grouped_Question__c TestGrQ = new Grouped_Question__c(Group__c='a0A900000082NjF', Question__c='a03900000036j9V');
        Test.startTest();
		Database.SaveResult Sresult = Database.insert(TestGrQ, true);
		Test.stopTest();
        System.assert(Sresult.isSuccess());
	}

    static testmethod void DeleteGroupedQuestion()
	{
        Grouped_Question__c TestGrQ = new Grouped_Question__c(Group__c='a0A900000082NjF', Question__c='a03900000036j9V');
        Test.startTest();
		Database.SaveResult Sresult = Database.insert(TestGrQ, true);
        Database.DeleteResult Dresult = Database.delete(TestGrQ, true);
		Test.stopTest();
        System.assert(Dresult.isSuccess());
	}

}