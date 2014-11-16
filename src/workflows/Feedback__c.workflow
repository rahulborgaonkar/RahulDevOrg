<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Get Staff Email</fullName>
        <field>Staff_Email__c</field>
        <formula>Staff__r.Staff_Email__c</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Get Staff Name</fullName>
        <field>Staff_Name__c</field>
        <formula>Staff__r.Staff_Full_Name__c</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Feedback URL</fullName>
        <field>Feedback_Link__c</field>
        <formula>&quot;borgaonkar-developer-edition.ap1.force.com/FeedbackPage?id=&quot; + Id</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Feedback Link</fullName>
        <actions>
            <name>Update Feedback URL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT( ISNULL( Name) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Staff Details</fullName>
        <actions>
            <name>Get Staff Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Get Staff Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISBLANK( Staff__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
