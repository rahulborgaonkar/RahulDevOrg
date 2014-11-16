trigger checkDuplicateLeads on Lead (before insert, before update)
{
    Map<String, Lead> leadMap = new Map<String, Lead>();

    system.debug('In checkDuplicateLeads');

    for (Lead lead : Trigger.new)
    {
        if(Trigger.isInsert || (lead.Company != Trigger.oldMap.get(lead.Id).Company) || (lead.Company != null))
        {
            if(leadMap.containsKey(lead.Company))
            {
                lead.Company.addError('Another (' + lead.Company + ') lead has the same Company Name');
            }
            else
            {
                leadMap.put(lead.Company, lead);
            }
        }
    }

    for(Account account : [SELECT Name, Owner.Id, Owner.email FROM Account WHERE Name IN :leadMap.KeySet()])
    {
        Lead newLead = leadMap.get(account.Name);

        if(account.Name == newLead.Company)
        {
            String Message = 'An Account (' + account.Name + ') with this Lead Name already exists';
            newLead.Company.addError(Message);
        }
    }

    for(Lead lead : [SELECT Company, OwnerId FROM Lead WHERE Company IN :leadMap.KeySet()])
    {       
        User Owner = [SELECT email FROM User WHERE Id = :lead.ownerid LIMIT 1];
        Lead newLead = leadMap.get(lead.Company);
        
        if(newLead.Company == lead.Company && newLead.Id != lead.Id)
        {
            String Message = 'A Lead (' + lead.Company + ') with this Name already exists';

            system.debug('Before Task - ' + lead);
            //updateActivityHistory.insertTask(lead.id, lead.ownerid);
            newLead.Company.addError(Message);
            system.debug('After Task - ' + lead);
        }
    }
}