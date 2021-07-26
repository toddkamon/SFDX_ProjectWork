@isTest
public with sharing class DealSplitCalculatorControllerTest {

   @isTest static void quoteLineSelectorTest(){

        Account distributorAccount = new Account(
            name = 'distributorAccount'
        );
        insert distributorAccount;

        SBQQ__Quote__c quote = (SBQQ__Quote__c)TDF.createSObject('SBQQ__Quote__c', new Map<String,Object> {
            'SBQQ__Primary__c' => true,
                'SBQQ__StartDate__c' => Date.newInstance(2019, 12, 01),
                'SBQQ__ShippingName__c' => 'Ship To Name',
                'SBQQ__ShippingCountry__c' => 'United States',
                'RecordTypeId' => Schema.SObjectType.SBQQ__Quote__c.getRecordTypeInfosByDeveloperName().get('Quote_Draft').getRecordTypeId(),
                'SBQQ__SalesRep__c' => UserInfo.getUserId(),
                'Channel__c' => 'Distribution',
                'SBQQ__Status__c' => 'Draft',
                'AuthorityCode__c' => 'S080',
                'Axalta_Cash_SV__c' => 1000,
                'SBQQ__Primary__c' => false,
                'SBQQ__Distributor__c' => distributorAccount.Id,
                'Channel__c' => 'Distribution',
                'Pricing_Cadence__c' => null,
                'SBQQ__SubscriptionTerm__c' => 60,
                'Volume_Growth__c' => 'Flat (0%)',
                'Volume_Growth_Adjustment__c' => 0,
                'Cost_of_Capital__c' => 10,
                'TED__c' => 50,
                'Distributor_Threshold__c' => 10,
                'Axalta_Threshold__c' => 0,
                'Final_Purchase_Agreement__c' => 1326152
                },true);

        List<SBQQ__QuoteLine__c> listQuoteLines = new List<SBQQ__QuoteLine__c>();

        Id pricebookId = Test.getStandardPricebookId();
        List<Product2> listProducts = new List<Product2>();
        for(String productCode : DealSplitCalculatorController.mapSpecialSplitRuleFactorsByProductCode.keySet()){
            Product2 testProduct = new Product2(
                Name = productCode,
                ProductCode = productCode
            );
        }
        insert listProducts;

        for(Product2 thisProduct : listProducts){
            listQuoteLines.add(new SBQQ__QuoteLine__c(
                SBQQ__Quote__c=quote.Id,
                SBQQ__Product__c = thisProduct.Id,
                SBQQ__Description__c = 'test description',
                Incentive_Value__c =  1000
            
            ));

        }
        insert listQuoteLines;

        Test.startTest();
            DealSplitCalculatorController.DealSplitCalculatorModel result = DealSplitCalculatorController.getQuoteData(quote.Id);
        Test.stopTest();

        System.assertEquals(listQuoteLines.size(), result.mapListQuoteLinesByProductCode.size(), 'We expect all the quote lines to be returned');
    }

    @isTest static void quoteSelectorTest(){
      
        
        Account distributorAccount = new Account(
            name = 'distributorAccount'
        );
        insert distributorAccount;

        SBQQ__Quote__c quote = (SBQQ__Quote__c)TDF.createSObject('SBQQ__Quote__c', new Map<String,Object> {
            'SBQQ__Primary__c' => true,
                'SBQQ__StartDate__c' => Date.newInstance(2019, 12, 01),
                'SBQQ__ShippingName__c' => 'Ship To Name',
                'SBQQ__ShippingCountry__c' => 'United States',
                'RecordTypeId' => Schema.SObjectType.SBQQ__Quote__c.getRecordTypeInfosByDeveloperName().get('Quote_Draft').getRecordTypeId(),
                'SBQQ__SalesRep__c' => UserInfo.getUserId(),
                'Channel__c' => 'Distribution',
                'SBQQ__Status__c' => 'Draft',
                'AuthorityCode__c' => 'S080',
                'Axalta_Cash_SV__c' => 1000,
                'SBQQ__Primary__c' => false,
                'SBQQ__Distributor__c' => distributorAccount.Id,
                'Channel__c' => 'Distribution',
                'Pricing_Cadence__c' => null,
                'SBQQ__SubscriptionTerm__c' => 60,
                'Volume_Growth__c' => 'Flat (0%)',
                'Volume_Growth_Adjustment__c' => 0,
                'TED__c' => 50,
                'Cost_of_Capital__c' => 10,
                'Distributor_Threshold__c' => 10,
                'Axalta_Threshold__c' => 0,
                'Final_Purchase_Agreement__c' => 1326152
                },true);

        List<SBQQ__QuoteLine__c> listQuoteLines = new List<SBQQ__QuoteLine__c>();

        Id pricebookId = Test.getStandardPricebookId();
        List<Product2> listProducts = new List<Product2>();
        for(String productCode : DealSplitCalculatorController.mapSpecialSplitRuleFactorsByProductCode.keySet()){
            Product2 testProduct = new Product2(
                Name = productCode,
                ProductCode = productCode
            );
        }
        insert listProducts;

        for(Product2 thisProduct : listProducts){
            listQuoteLines.add(new SBQQ__QuoteLine__c(
                SBQQ__Quote__c=quote.Id,
                SBQQ__Product__c = thisProduct.Id,
                SBQQ__Description__c = 'test description',
                Incentive_Value__c =  1000
            
            ));

        }
        insert listQuoteLines;

        Test.startTest();
            DealSplitCalculatorController.DealSplitCalculatorModel result = DealSplitCalculatorController.getQuoteData(quote.Id);
        Test.stopTest();

        System.assertEquals(quote.Id, result.quote.Id, 'We expect the quote to be returned in the data model');
    }

    @isTest static void calculateStandardValuesForOptimizer_Test(){

        Double expectedTotalIncentiveAmount = 0;
        Double expectedTotalRebateIncentiveAmount = 0;
        Double expectedTotalInvestmentsIncentiveAmount = 0;

        Account customerAccount = new Account(
            name = 'Customer Account',
            AnnualRevenue = 240000
        );
        insert customerAccount;

        Account distributorAccount = new Account(
            name = 'distributorAccount'
        );
        insert distributorAccount;

        SBQQ.TriggerControl.disable();

        SBQQ__Quote__c quote = (SBQQ__Quote__c)TDF.createSObject('SBQQ__Quote__c', new Map<String,Object> {
            'SBQQ__Primary__c' => true,
                'SBQQ__StartDate__c' => Date.newInstance(2019, 12, 01),
                'SBQQ__ShippingName__c' => 'Ship To Name',
                'SBQQ__ShippingCountry__c' => 'United States',
                'RecordTypeId' => Schema.SObjectType.SBQQ__Quote__c.getRecordTypeInfosByDeveloperName().get('Quote_Draft').getRecordTypeId(),
                'SBQQ__SalesRep__c' => UserInfo.getUserId(),
                'Channel__c' => 'Distribution',
                'SBQQ__Status__c' => 'Draft',
                'AuthorityCode__c' => 'S080',
                'Axalta_Cash_SV__c' => 1000,
                'SBQQ__Primary__c' => false,
                'SBQQ__Distributor__c' => distributorAccount.Id,
                'Channel__c' => 'Distribution',
                'Pricing_Cadence__c' => null,
                'SBQQ__SubscriptionTerm__c' => 60,
                'Volume_Growth__c' => 'Flat (0%)',
                'Volume_Growth_Adjustment__c' => 0,
                'TED__c' => 50,
                'Cost_of_Capital__c' => 10,
                'Distributor_Threshold__c' => 10,
                'SBQQ__Account__c' => customerAccount.Id,
                'Axalta_Threshold__c' => 0,
                'Final_Purchase_Agreement__c' => 1326152
                },true);

        List<SBQQ__QuoteLine__c> listQuoteLines = new List<SBQQ__QuoteLine__c>();

        Id pricebookId = Test.getStandardPricebookId();
        List<Product2> listProducts = new List<Product2>();
        for(String productCode : DealSplitCalculatorController.mapSpecialSplitRuleFactorsByProductCode.keySet()){
            Product2 testProduct = new Product2(
                Name = productCode,
                ProductCode = productCode
            );
            listProducts.add(testProduct);
        }
        insert listProducts;

        for(Product2 thisProduct : listProducts){
            SBQQ__QuoteLine__c thisQuoteLine = new SBQQ__QuoteLine__c(
                SBQQ__Quote__c=quote.Id,
                SBQQ__Product__c = thisProduct.Id,
                SBQQ__Description__c = 'test description',
                Incentive_Value__c =  10000,
                BIP_Credit_Type__c = 'One-Time'
            );
            listQuoteLines.add(thisQuoteLine);

            expectedTotalIncentiveAmount += thisQuoteLine.Incentive_Value__c;

            if(DealSplitCalculatorController.listTotalRebateNames.contains(thisProduct.ProductCode)){
                expectedTotalRebateIncentiveAmount += thisQuoteLine.Incentive_Value__c;
            }

            if(DealSplitCalculatorController.listTotalInvestmentsNames.contains(thisProduct.ProductCode)){
                expectedTotalInvestmentsIncentiveAmount += thisQuoteLine.Incentive_Value__c;
            }

        }
        insert listQuoteLines;
        SBQQ.TriggerControl.enable();

        Test.startTest();
            DealSplitCalculatorController.DealSplitCalculatorModel result = DealSplitCalculatorController.getQuoteData(quote.Id);
        Test.stopTest();

        System.assertEquals(expectedTotalIncentiveAmount, result.totalIncentiveAmount, 'We expect the Total Incentive amount to be calculated in the Data Model');
        System.assertEquals(expectedTotalRebateIncentiveAmount, result.totalRebateIncentiveAmount, 'We expect the Total Rebate Amount to be calculated in the Data Model');
        System.assertEquals(expectedTotalInvestmentsIncentiveAmount, result.totalInvestmentsIncentiveAmount, 'We expect the Total Investment amount to be calculated in the Data Model');

        System.assert(result.maxCashInvestment  > 0, 'We expect the Max Cash Investment to return a value');
        System.assert(result.investmentExchangeRate   > 0, 'We expect the Investment Exchange Rate to return a value');
        System.assertEquals(0, result.totalRebates , 'We expect the the Total Rebates to return 0');
    }


    @isTest static void calculateStandardValuesForOptimizer_FinishMasterLogicTest(){

        Double expectedTotalIncentiveAmount = 0;
        Double expectedTotalRebateIncentiveAmount = 0;
        Double expectedTotalInvestmentsIncentiveAmount = 0;

        Account customerAccount = new Account(
            name = 'Customer Account',
            AnnualRevenue = 240000
        );
        insert customerAccount;

        Account distributorAccount = new Account(
            name = 'distributorAccount'
        );
        insert distributorAccount;

        DealSplitOptimizerSettings__c finishMaster = new DealSplitOptimizerSettings__c(
            Finish_Master_HQ__c = String.valueOf(distributorAccount.Id).substring(0, 15)
        );
        insert finishMaster;

        SBQQ.TriggerControl.disable();

        SBQQ__Quote__c quote = (SBQQ__Quote__c)TDF.createSObject('SBQQ__Quote__c', new Map<String,Object> {
            'SBQQ__Primary__c' => true,
                'SBQQ__StartDate__c' => Date.newInstance(2019, 12, 01),
                'SBQQ__ShippingName__c' => 'Ship To Name',
                'SBQQ__ShippingCountry__c' => 'United States',
                'RecordTypeId' => Schema.SObjectType.SBQQ__Quote__c.getRecordTypeInfosByDeveloperName().get('Quote_Draft').getRecordTypeId(),
                'SBQQ__SalesRep__c' => UserInfo.getUserId(),
                'Channel__c' => 'Distribution',
                'SBQQ__Status__c' => 'Draft',
                'AuthorityCode__c' => 'S080',
                'Axalta_Cash_SV__c' => 1000,
                'SBQQ__Primary__c' => false,
                'SBQQ__Distributor__c' => distributorAccount.Id,
                'Channel__c' => 'Distribution',
                'Pricing_Cadence__c' => null,
                'SBQQ__SubscriptionTerm__c' => 60,
                'Volume_Growth__c' => 'Flat (0%)',
                'Volume_Growth_Adjustment__c' => 0,
                'TED__c' => 50,
                'Cost_of_Capital__c' => 10,
                'Distributor_Threshold__c' => 10,
                'SBQQ__Account__c' => customerAccount.Id,
                'Axalta_Threshold__c' => 0,
                'Final_Purchase_Agreement__c' => 1326152
                },true);

        List<SBQQ__QuoteLine__c> listQuoteLines = new List<SBQQ__QuoteLine__c>();

        Id pricebookId = Test.getStandardPricebookId();
        List<Product2> listProducts = new List<Product2>();
        for(String productCode : DealSplitCalculatorController.mapSpecialSplitRuleFactorsByProductCode.keySet()){
            Product2 testProduct = new Product2(
                Name = productCode,
                ProductCode = productCode
            );
            listProducts.add(testProduct);
        }
        insert listProducts;

        for(Product2 thisProduct : listProducts){
            SBQQ__QuoteLine__c thisQuoteLine = new SBQQ__QuoteLine__c(
                SBQQ__Quote__c=quote.Id,
                SBQQ__Product__c = thisProduct.Id,
                SBQQ__Description__c = 'test description',
                Incentive_Value__c =  10000,
                BIP_Credit_Type__c = 'One-Time'
            );
            listQuoteLines.add(thisQuoteLine);

            expectedTotalIncentiveAmount += thisQuoteLine.Incentive_Value__c;

            if(DealSplitCalculatorController.listTotalRebateNames.contains(thisProduct.ProductCode)){
                expectedTotalRebateIncentiveAmount += thisQuoteLine.Incentive_Value__c;
            }

            if(DealSplitCalculatorController.listTotalInvestmentsNames.contains(thisProduct.ProductCode)){
                expectedTotalInvestmentsIncentiveAmount += thisQuoteLine.Incentive_Value__c;
            }

        }
        insert listQuoteLines;
        SBQQ.TriggerControl.enable();

        Test.startTest();
            DealSplitCalculatorController.DealSplitCalculatorModel result = DealSplitCalculatorController.getQuoteData(quote.Id);
        Test.stopTest();

        System.assertEquals(expectedTotalIncentiveAmount, result.totalIncentiveAmount, 'We expect the Total Incentive amount to be calculated in the Data Model');
        System.assertEquals(expectedTotalRebateIncentiveAmount, result.totalRebateIncentiveAmount, 'We expect the Total Rebate Amount to be calculated in the Data Model');
        System.assertEquals(expectedTotalInvestmentsIncentiveAmount, result.totalInvestmentsIncentiveAmount, 'We expect the Total Investment amount to be calculated in the Data Model');

        System.assert(result.maxCashInvestment  > 0, 'We expect the Max Cash Investment to return a value');
        System.assert(result.investmentExchangeRate   > 0, 'We expect the Investment Exchange Rate to return a value');
        System.assertEquals(0, result.totalRebates , 'We expect the the Total Rebates to return 0');
    }

    @isTest static void saveQuoteDataTest(){

        Double expectedTotalIncentiveAmount = 0;
        Double expectedTotalRebateIncentiveAmount = 0;
        Double expectedTotalInvestmentsIncentiveAmount = 0;

        Double expectedSplitNumber = 5000;

        Account customerAccount = new Account(
            name = 'Customer Account',
            AnnualRevenue = 240000
        );
        insert customerAccount;

        Account distributorAccount = new Account(
            name = 'distributorAccount'
        );
        insert distributorAccount;

        DealSplitOptimizerSettings__c finishMaster = new DealSplitOptimizerSettings__c(
            Finish_Master_HQ__c = String.valueOf(distributorAccount.Id).substring(0, 15)
        );
        insert finishMaster;

        SBQQ.TriggerControl.disable();

        SBQQ__Quote__c quote = (SBQQ__Quote__c)TDF.createSObject('SBQQ__Quote__c', new Map<String,Object> {
            'SBQQ__Primary__c' => true,
                'SBQQ__StartDate__c' => Date.newInstance(2019, 12, 01),
                'SBQQ__ShippingName__c' => 'Ship To Name',
                'SBQQ__ShippingCountry__c' => 'United States',
                'RecordTypeId' => Schema.SObjectType.SBQQ__Quote__c.getRecordTypeInfosByDeveloperName().get('Quote_Draft').getRecordTypeId(),
                'SBQQ__SalesRep__c' => UserInfo.getUserId(),
                'Channel__c' => 'Distribution',
                'SBQQ__Status__c' => 'Draft',
                'AuthorityCode__c' => 'S080',
                'Axalta_Cash_SV__c' => 1000,
                'SBQQ__Primary__c' => false,
                'SBQQ__Distributor__c' => distributorAccount.Id,
                'Channel__c' => 'Distribution',
                'Pricing_Cadence__c' => null,
                'SBQQ__SubscriptionTerm__c' => 60,
                'Volume_Growth__c' => 'Flat (0%)',
                'Volume_Growth_Adjustment__c' => 0,
                'TED__c' => 50,
                'Cost_of_Capital__c' => 10,
                'Distributor_Threshold__c' => 10,
                'SBQQ__Account__c' => customerAccount.Id,
                'Axalta_Threshold__c' => 0,
                'Final_Purchase_Agreement__c' => 1326152
                },true);

        List<SBQQ__QuoteLine__c> listQuoteLines = new List<SBQQ__QuoteLine__c>();

        Id pricebookId = Test.getStandardPricebookId();
        List<Product2> listProducts = new List<Product2>();
        for(String productCode : DealSplitCalculatorController.mapSpecialSplitRuleFactorsByProductCode.keySet()){
            Product2 testProduct = new Product2(
                Name = productCode,
                ProductCode = productCode
            );
            listProducts.add(testProduct);
        }
        insert listProducts;

        for(Product2 thisProduct : listProducts){
            SBQQ__QuoteLine__c thisQuoteLine = new SBQQ__QuoteLine__c(
                SBQQ__Quote__c=quote.Id,
                SBQQ__Product__c = thisProduct.Id,
                SBQQ__Description__c = 'test description',
                Incentive_Value__c =  10000,
                BIP_Credit_Type__c = 'One-Time'
            );
            listQuoteLines.add(thisQuoteLine);

            expectedTotalIncentiveAmount += thisQuoteLine.Incentive_Value__c;

            if(DealSplitCalculatorController.listTotalRebateNames.contains(thisProduct.ProductCode)){
                expectedTotalRebateIncentiveAmount += thisQuoteLine.Incentive_Value__c;
            }

            if(DealSplitCalculatorController.listTotalInvestmentsNames.contains(thisProduct.ProductCode)){
                expectedTotalInvestmentsIncentiveAmount += thisQuoteLine.Incentive_Value__c;
            }

        }
        insert listQuoteLines;
        SBQQ.TriggerControl.enable();
        List<SBQQ__QuoteLine__c> listQuoteLinesToUpdate = new List<SBQQ__QuoteLine__c>();
        for(SBQQ__QuoteLine__c thisQuoteLine : listQuoteLines){
            listQuoteLinesToUpdate.add(
                new SBQQ__QuoteLine__c(
                    Id = thisQuoteLine.Id,
                    Axalta_Split_Number__c = expectedSplitNumber
                )
            );
        }

        Test.startTest();
            DealSplitCalculatorController.saveQuoteData(listQuoteLinesToUpdate);
        Test.stopTest();

        List<SBQQ__QuoteLine__c> resultQuoteLines = [SELECT Axalta_Split_Number__c FROM SBQQ__QuoteLine__c];

        System.assertEquals( listQuoteLines.size(), resultQuoteLines.size(), 'We expect all the quote lines to be returned');
        for(SBQQ__QuoteLine__c result : resultQuoteLines){
            System.assertEquals(expectedSplitNumber, result.Axalta_Split_Number__c, 'We expect the Axalta Split Number to be updated');
        }
    }
}