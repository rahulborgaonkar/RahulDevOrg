public class myAccountsCon 
{
    public List<Account> accounts 
    {
        get {
            accounts = [select name, billingcity, billingstate, billingstreet, billingpostalcode from account];
            return accounts;
        }
        set;
    }
}