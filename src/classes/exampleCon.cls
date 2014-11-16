public class exampleCon 
{
    public class BaseException extends Exception {}

    Integer count = 0;
    public PageReference incrementCounter() 
    {
        count++;
        return null;
    }
    public Integer getCount() 
    {
        return count;
    }
    public void buttonAction() 
    {
        try
        {
            system.debug('Hello');
            throw new baseexception('error');
        }
        catch (baseexception b)
        {
            system.debug('baseexception catched');
        }
    }   
}