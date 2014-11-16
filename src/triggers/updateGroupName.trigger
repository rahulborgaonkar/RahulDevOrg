trigger updateGroupName on Grouped_Question__c (after insert, after update, after delete)
{

    if (Trigger.isUpdate || Trigger.isDelete)
    {
        for ( Grouped_Question__c grQ : Trigger.old)
        {    
            system.debug('Delete Update : ' + grQ.Question__c);
            Question__c qName = [ select name from Question__c where Id = :grQ.Question__c ];
            qName.Related_Group__c = null;    
            system.debug('qName : ' + qName);
            upsert qName;
        }
    }    

    if (Trigger.isUpdate || Trigger.isInsert)
    {
        for ( Grouped_Question__c grQ : Trigger.new)
        {    
            system.debug('Insert Update : ' + grQ.Question__c);
            Question__c qName = [ select name from Question__c where Id = :grQ.Question__c ];
            qName.Related_Group__c = [ select name from Group__c where Id = :grQ.Group__c ].name;    
            system.debug('qName : ' + qName);
            upsert qName;
        }
    }    
}