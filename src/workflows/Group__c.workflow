<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update Group Name</fullName>
        <field>Group_Name_Unique__c</field>
        <formula>Name</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Group Name Unique</fullName>
        <actions>
            <name>Update Group Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(ISNEW() ,ISCHANGED( Name ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
