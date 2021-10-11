trigger AccountAddressTrigger on Account (before insert, before update) {
    for (Account acc: Trigger.New) {
        if (acc.BillingPostalCode != null && acc.Match_Billing_Address__c) {
            acc.ShippingPostalCode = acc.BillingPostalCode;
        }
    }
}