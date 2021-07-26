public with sharing class DealSplitCalculatorController {

    static String THIRD_PARTY_TRAINING_SERVICES = '3rd Party Training and Services'; 
    static String AXALTA_TRAINING_SERVICES = 'Axalta Training and Services';
    static String CONSOLIDATOR_PREBATE = 'Consolidator Prebate';
    static String CONSOLIDATOR_REBATE_PERCENT = 'Consolidator Rebate %';
    static String CONSOLIDATOR_TO_SHOP_REBATE_PERCENT = 'Consolidator to Shop Rebate %';
    static String CUSTOM_EQUIPMENT_BUNDLE = 'Custom Equipment Bundle';
    static String BUY_AXALTA_EQUIPMENT = 'Buy Axalta Equipment'; // This is also a custom equipment bundle
    static String DISCOUNT_PERCENT_REFINISHER = 'Discount % - Refinisher';
    static String EXISTING_EQUIPMENT = 'Existing Equipment';
    static String IRREGULAR_CASH = 'Irregular Cash';
    static String REBATE_PERCENT_REFINISHER = 'Rebate % - Refinisher';
    static String REBATE_PERCENT_STATEMENT = 'Rebate % - Statement';
    static String RECURRING_FIXED_PREBATE = 'Recurring Fixed Rebate';
    static String RECURRING_PREBATE = 'Recurring Prebate'; 
    static String SUPPORT_FEES = 'Support Fees';
    static String TERMINATION_CHARGES = 'Termination Charges';
    static String UPFRONT_PREBATE = 'Upfront Prebate';

    
    @TestVisible static List<String> listTotalRebateNames = new List<String>{
        CONSOLIDATOR_REBATE_PERCENT, 
        CONSOLIDATOR_TO_SHOP_REBATE_PERCENT, 
        DISCOUNT_PERCENT_REFINISHER,
        REBATE_PERCENT_REFINISHER, 
        REBATE_PERCENT_STATEMENT, 
        RECURRING_FIXED_PREBATE,
        SUPPORT_FEES
    };

    
    @TestVisible static List<String> listTotalInvestmentsNames = new List<String>{
        TERMINATION_CHARGES,
        EXISTING_EQUIPMENT,
        THIRD_PARTY_TRAINING_SERVICES, 
        AXALTA_TRAINING_SERVICES, 
        CONSOLIDATOR_PREBATE, 
        CUSTOM_EQUIPMENT_BUNDLE, 
        BUY_AXALTA_EQUIPMENT, 
        EXISTING_EQUIPMENT, 
        IRREGULAR_CASH, 
        RECURRING_PREBATE,
        TERMINATION_CHARGES, 
        UPFRONT_PREBATE
    };
    @TestVisible static List<String> listTotalCashIvestment = new List<String>{
        THIRD_PARTY_TRAINING_SERVICES, 
        AXALTA_TRAINING_SERVICES, 
        CONSOLIDATOR_PREBATE, 
        CUSTOM_EQUIPMENT_BUNDLE, 
        BUY_AXALTA_EQUIPMENT, 
        EXISTING_EQUIPMENT, 
        IRREGULAR_CASH, 
        RECURRING_PREBATE,
        TERMINATION_CHARGES, 
        UPFRONT_PREBATE
    };

    @testVisible static List<String> listUSHierarchy = new List<String>{
        TERMINATION_CHARGES,
        EXISTING_EQUIPMENT,
        CONSOLIDATOR_PREBATE,
        CUSTOM_EQUIPMENT_BUNDLE,
        BUY_AXALTA_EQUIPMENT,
        AXALTA_TRAINING_SERVICES,
        UPFRONT_PREBATE,
        RECURRING_PREBATE,
        IRREGULAR_CASH,
        THIRD_PARTY_TRAINING_SERVICES,
        CONSOLIDATOR_TO_SHOP_REBATE_PERCENT,
        CONSOLIDATOR_REBATE_PERCENT,
        REBATE_PERCENT_STATEMENT,
        REBATE_PERCENT_REFINISHER,
        DISCOUNT_PERCENT_REFINISHER,
        RECURRING_FIXED_PREBATE,
        SUPPORT_FEES
    };

    @testVisible static List<String> listCAHierarchy = new List<String>{
        TERMINATION_CHARGES,
        EXISTING_EQUIPMENT,
        CONSOLIDATOR_PREBATE,
        CUSTOM_EQUIPMENT_BUNDLE,
        BUY_AXALTA_EQUIPMENT,
        AXALTA_TRAINING_SERVICES,
        UPFRONT_PREBATE,
        RECURRING_PREBATE,
        IRREGULAR_CASH,
        THIRD_PARTY_TRAINING_SERVICES,
        CONSOLIDATOR_REBATE_PERCENT,
        CONSOLIDATOR_TO_SHOP_REBATE_PERCENT,
        SUPPORT_FEES,
        RECURRING_FIXED_PREBATE,
        REBATE_PERCENT_STATEMENT,
        REBATE_PERCENT_REFINISHER,
        DISCOUNT_PERCENT_REFINISHER
    };

    @testVisible static List<String> listNAHierarchy = new List<String>{
        TERMINATION_CHARGES,
        EXISTING_EQUIPMENT,
        CONSOLIDATOR_PREBATE,
        CUSTOM_EQUIPMENT_BUNDLE,
        BUY_AXALTA_EQUIPMENT,
        AXALTA_TRAINING_SERVICES,
        RECURRING_PREBATE,
        IRREGULAR_CASH,
        UPFRONT_PREBATE,
        THIRD_PARTY_TRAINING_SERVICES,
        CONSOLIDATOR_REBATE_PERCENT,
        CONSOLIDATOR_TO_SHOP_REBATE_PERCENT,
        RECURRING_FIXED_PREBATE,
        REBATE_PERCENT_STATEMENT,
        REBATE_PERCENT_REFINISHER,
        DISCOUNT_PERCENT_REFINISHER,
        SUPPORT_FEES
    };

    public static Map<String, SpecialSplitRuleFactors> mapSpecialSplitRuleFactorsByProductCode = new Map<String, SpecialSplitRuleFactors>{
        THIRD_PARTY_TRAINING_SERVICES =>         new SpecialSplitRuleFactors( 0.5,  1.0,  1.0 ),
        AXALTA_TRAINING_SERVICES =>              new SpecialSplitRuleFactors( 0.5,  1.0,  1.0 ),
        CONSOLIDATOR_PREBATE =>                  new SpecialSplitRuleFactors( 1.0,  1.0,  1.0 ),
        CONSOLIDATOR_REBATE_PERCENT =>           new SpecialSplitRuleFactors( 0.5,  1.0,  0.5 ),
        CONSOLIDATOR_TO_SHOP_REBATE_PERCENT =>   new SpecialSplitRuleFactors( 0.5,  1.0,  0.5 ),
        CUSTOM_EQUIPMENT_BUNDLE =>               new SpecialSplitRuleFactors( 0.5,  1.0,  1.0 ),
        BUY_AXALTA_EQUIPMENT =>                  new SpecialSplitRuleFactors( 0.5,  1.0,  1.0 ),
        DISCOUNT_PERCENT_REFINISHER =>           new SpecialSplitRuleFactors( 1.0,  1.0,  1.0 ),
        EXISTING_EQUIPMENT =>                    new SpecialSplitRuleFactors( 0.5,  1.0,  1.0 ),
        IRREGULAR_CASH =>                        new SpecialSplitRuleFactors( 0.5,  1.0,  0.5 ),
        REBATE_PERCENT_REFINISHER =>             new SpecialSplitRuleFactors( 0.5,  1.0,  1.0 ),
        REBATE_PERCENT_STATEMENT =>              new SpecialSplitRuleFactors( 0.5,  1.0,  1.0 ),
        RECURRING_FIXED_PREBATE =>               new SpecialSplitRuleFactors( 0.5,  1.0,  0.5 ),
        RECURRING_PREBATE =>                     new SpecialSplitRuleFactors( 0.5,  1.0,  0.5 ),
        SUPPORT_FEES =>                          new SpecialSplitRuleFactors( 0.5,  1.0,  1.0 ),
        TERMINATION_CHARGES =>                   new SpecialSplitRuleFactors( 0.5,  1.0,  1.0 ),
        UPFRONT_PREBATE =>                       new SpecialSplitRuleFactors( 0.5,  1.0,  1.0 )
    };


    static DealSplitOptimizerSettings__c dealSplitOptimizerCustomSettings {
        get {
            if(dealSplitOptimizerCustomSettings == null){
                dealSplitOptimizerCustomSettings = DealSplitOptimizerSettings__c.getInstance();
            }
            return dealSplitOptimizerCustomSettings;
        } set;
    }

    public class DealSplitCalculatorModel{
        @AuraEnabled public Map<String, List<SBQQ__QuoteLine__c>> mapListQuoteLinesByProductCode;
        @AuraEnabled public Map<Id, Decimal> mapSpecialSplitValueByQuoteLineId;
        @AuraEnabled public SBQQ__Quote__c quote;
        @AuraEnabled public List<String> listProductHierarchy;
        @AuraEnabled public List<String> listRebateNames;

        @AuraEnabled public String timeValueMoney = 'On';
        @AuraEnabled public Double totalIncentiveAmount = 0;
        @AuraEnabled public Double totalRebateIncentiveAmount = 0;
        @AuraEnabled public Double totalInvestmentsIncentiveAmount = 0;
        @AuraEnabled public Double totalPurchasesAmount = 0;
        @AuraEnabled public Double totalCashIvestment =0;
        @AuraEnabled public Double costOfCapital;
        @AuraEnabled public Double upfrontInvestmentPercent;
        @AuraEnabled public Double maxInvestment;

        @AuraEnabled public Double percentAxaltaTotal;
        

        //used in frontend
        @AuraEnabled public Double totalRebates;
        @AuraEnabled public Double investmentExchangeRate;
        @AuraEnabled public double maxCashInvestment;

    }

    public class SpecialSplitRuleFactors{
        public Decimal canada;
        public Decimal unitedStates;
        public Decimal northAmerica;

        public SpecialSplitRuleFactors(Decimal canadaSplit, Decimal unitedStatesSplit, Decimal northAmericaSplit){
            this.canada = canadaSplit;
            this.unitedStates = unitedStatesSplit;
            this.northAmerica = northAmericaSplit;
        }

        public Decimal getSpecialSplitFromCountry( String country ){
            if( country == 'Canada' ){
                return this.canada;
            } else if( country == 'United States'){
                return this.unitedStates;
            } else {
                return this.unitedStates;
            }
        }
    }

    @AuraEnabled
    public static DealSplitCalculatorModel getQuoteData(Id quoteId){
        DealSplitCalculatorModel dataModel = new DealSplitCalculatorModel();
        dataModel.quote = quoteSelector(quoteId);
        dataModel.mapListQuoteLinesByProductCode = getMapQuoteLines(quoteId);
        dataModel.totalPurchasesAmount = dataModel.quote.Final_Purchase_Agreement__c;

        dataModel.listRebateNames = listTotalRebateNames;

        invokeCalculations( dataModel );

        return dataModel;
    }

    @AuraEnabled
    public static DealSplitCalculatorModel recalculateDealSplicModel( Id quoteId, String timeValueMoneyInput){
        DealSplitCalculatorModel dataModel = new DealSplitCalculatorModel();
        dataModel.quote = quoteSelector(quoteId);
        dataModel.mapListQuoteLinesByProductCode = getMapQuoteLines(quoteId);
        dataModel.totalPurchasesAmount = dataModel.quote.Final_Purchase_Agreement__c;
        dataModel.timeValueMoney = timeValueMoneyInput;

        dataModel.listRebateNames = listTotalRebateNames;
        
        invokeCalculations( dataModel );

        return dataModel;
    }

    private static void invokeCalculations( DealSplitCalculatorModel dataModel ){
        /** Add logic to use NA hierarchy in this if/else block */
        if(dataModel.quote.SBQQ__ShippingCountry__c == 'Canada'){
            dataModel.listProductHierarchy = listCAHierarchy;
        } else if( dataModel.quote.SBQQ__ShippingCountry__c == 'United States'){
            dataModel.listProductHierarchy = listUSHierarchy;
        } else {
            dataModel.listProductHierarchy = listUSHierarchy;
        }

        calculateStandardValuesForOptimizer(dataModel);
        initialCalculation(dataModel);
    }


    @AuraEnabled
    public static void saveQuoteData(List<SBQQ__QuoteLine__c> listQuoteLines){
        List<SBQQ__QuoteLine__c> listQuoteLinesToUpdate = new List<SBQQ__QuoteLine__c>();
        try{
            saveQuoteLines(listQuoteLines);
        } catch( DmlException e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static List<SBQQ__QuoteLine__c> quoteLineSelector(Id quoteId){
        return [SELECT  Id, Name, SBQQ__Product__r.Name, SBQQ__ProductCode__c, 
                        Incentive__c, Axalta_Split__c, Axalta_Value__c, Distributor_Split__c, 
                        Distributor_Value__c, Incentive_Effective_Discount__c, Incentive_Value__c,
                        SBQQ__TotalDiscountAmount__c, SBQQ__TotalDiscountRate__c, Total_Effective_Discount__c
                 FROM SBQQ__QuoteLine__c 
                 WHERE SBQQ__Quote__c = :quoteId AND SBQQ__ProductCode__c IN :mapSpecialSplitRuleFactorsByProductCode.keySet()];
    }

    private static SBQQ__Quote__c quoteSelector(Id quoteId){
        return [SELECT  Id, Account_Annual_Revenue__c, Final_Purchase_Agreement__c,Volume_Growth_Adjustment__c,
                        SBQQ__SubscriptionTerm__c, Axalta_Split__c, Distributor_Split__c,
                        Axalta_Threshold__c, Distributor_Threshold__c, Cost_of_Capital__c,
                        Actual_NPV__c, Distributor_HQ_ID__c,
                        SBQQ__BillingCountry__c, CurrencyIsoCode, Annual_Purchase_Agreement__c, 
                        Volume_Growth__c, TED__c, Axalta_Discount_Points__c, SBQQ__ShippingCountry__c
                 FROM SBQQ__Quote__c 
                 WHERE Id =:quoteId];
    }

    private static Map<String, List<SBQQ__QuoteLine__c>> getMapQuoteLines(Id quoteId){
        Map<String, List<SBQQ__QuoteLine__c>> mapListQuoteLineByProductname = new Map<String, List<SBQQ__QuoteLine__c>>();
        for( SBQQ__QuoteLine__c thisQuoteLine : quoteLineSelector(quoteId)){
            if( mapListQuoteLineByProductname.containsKey( thisQuoteLine.SBQQ__ProductCode__c ) ){
                mapListQuoteLineByProductname.get( thisQuoteLine.SBQQ__ProductCode__c ).add( thisQuoteLine );
            } else {
                mapListQuoteLineByProductname.put(thisQuoteLine.SBQQ__ProductCode__c, new List<SBQQ__QuoteLine__c>{ thisQuoteLine });
            }
        }
        return mapListQuoteLineByProductname;
    }

    
    private static void saveQuoteLines(List<SBQQ__QuoteLine__c> listQuoteLines){
        update listQuoteLines;
    }

    private static void initialCalculation(DealSplitCalculatorModel dataModel){
        Map<Id, Decimal> mapSpecialSplitValueByQuoteLineId = new Map<Id, Decimal>();
        Decimal axaltaCummutativePercent = 0;
        Decimal finalPurchaseAgreement = dataModel.quote.Final_Purchase_Agreement__c;
        
        Decimal axaltaTotalCashIvestment = dataModel.totalCashIvestment / 2;
        Decimal remainingAxaltaTotalCashInvestment = axaltaTotalCashIvestment;
        Decimal cummativeAxaltaTotalCashInvestment = 0;
        
        Decimal percentAxaltaTotal = datamodel.percentAxaltaTotal;

        String country = dataModel.quote.SBQQ__ShippingCountry__c;
        
        
        for(String productName : dataModel.listProductHierarchy){
            List<SBQQ__QuoteLine__c> listQuoteLines = dataModel.mapListQuoteLinesByProductCode.get( productName );
            if( listQuoteLines != null ){

                for( SBQQ__QuoteLine__c thisQuoteLine : listQuoteLines ){
        System.debug('********** '+productName+'*********');
                        Decimal incentiveValue = thisQuoteLine.Incentive_Value__c;
                        Decimal axaltaValue = thisQuoteLine.Axalta_Value__c;
        
                        SpecialSplitRuleFactors thisSpecialSplitRuleFactor = mapSpecialSplitRuleFactorsByProductCode.get( productName ); 
                        Decimal specialSplit = thisSpecialSplitRuleFactor.getSpecialSplitFromCountry( country );
                        Decimal specialSplitValue = incentiveValue * specialSplit;
                        mapSpecialSplitValueByQuoteLineId.put(thisQuoteLine.Id, specialSplitValue);

                        Decimal axaltaPortion;
        System.debug('percentAxaltaTotal: '+percentAxaltaTotal);
        System.debug('axaltaCummutativePercent: '+axaltaCummutativePercent);
                        Decimal axaltaRemainingPercent = percentAxaltaTotal - axaltaCummutativePercent < 0 ? 0 : percentAxaltaTotal - axaltaCummutativePercent;
                        Decimal effectiveDiscount = finalPurchaseAgreement > 0 ? incentiveValue / finalPurchaseAgreement : 0;
                        Decimal axaltaDollarPortion;
                        if( productName == TERMINATION_CHARGES){
                            System.debug('Termination Charge');
                            axaltaPortion = axaltaValue > 0 ? axaltaValue / finalPurchaseAgreement : 0;
        System.debug('TErmination Charge - axaltaPortion:'+axaltaPortion);
                            axaltaDollarPortion = division(axaltaPortion, effectiveDiscount ) * incentiveValue;
                            axaltaDollarPortion.setScale(2);
        System.debug('TErmination Charge - axaltaDollarPortion:'+axaltaDollarPortion);
                            double cashInvestment = axaltaDollarPortion;
        System.debug('TErmination Charge - cashInvestment:'+cashInvestment);
                            cummativeAxaltaTotalCashInvestment += cashInvestment ;
                            remainingAxaltaTotalCashInvestment = remainingAxaltaTotalCashInvestment - cashInvestment;
        
                        } else if( productName == EXISTING_EQUIPMENT ) { //Existing Equipment
                            System.debug('Existing Equipment');
                            axaltaPortion = axaltaValue > 0 ? axaltaValue / finalPurchaseAgreement : 0;
                            axaltaDollarPortion = division(axaltaPortion, effectiveDiscount ) * incentiveValue;
                            axaltaDollarPortion.setScale(2);
                            double cashInvestment;
        
                            if(remainingAxaltaTotalCashInvestment < 0){
                                cashInvestment = 0;
                            } else {
                                if(axaltaDollarPortion + cummativeAxaltaTotalCashInvestment < axaltaTotalCashIvestment) {
                                    cashInvestment = incentiveValue;
                                } else {
                                    cashInvestment = remainingAxaltaTotalCashInvestment;
                                }
                            }
                            cummativeAxaltaTotalCashInvestment += cashInvestment ;
                            remainingAxaltaTotalCashInvestment = remainingAxaltaTotalCashInvestment - cashInvestment;
        
                        } else if( listTotalInvestmentsNames.contains( productName )){
        System.debug('Investment');
                            double cashInvestment;
                            if( remainingAxaltaTotalCashInvestment < 0 ){
                                cashInvestment = 0;
                            }  else {
                                if(specialSplitValue + cummativeAxaltaTotalCashInvestment < axaltaTotalCashIvestment){
                                    cashInvestment = specialSplitValue;  
                                } else {
                                    cashInvestment = remainingAxaltaTotalCashInvestment;
                                }
                                
                            }
                            cummativeAxaltaTotalCashInvestment += cashInvestment ;
                            double cashInvestmentPortion = division(cashInvestment, finalPurchaseAgreement);
                            axaltaPortion = cashInvestmentPortion < axaltaRemainingPercent ? cashInvestmentPortion : axaltaRemainingPercent;
                            axaltaDollarPortion = division(axaltaPortion, effectiveDiscount ) * incentiveValue;
                            axaltaDollarPortion.setScale(2);
                            remainingAxaltaTotalCashInvestment = remainingAxaltaTotalCashInvestment - axaltaDollarPortion;
        
                        } else if( listTotalRebateNames.contains( productName )){
                            System.debug('Rebate');
                            axaltaPortion =  ( specialSplitValue / finalPurchaseAgreement ) < axaltaRemainingPercent ? ( specialSplitValue / finalPurchaseAgreement ) : axaltaRemainingPercent;
                            axaltaDollarPortion = division(axaltaPortion, effectiveDiscount ) * incentiveValue;
                            axaltaDollarPortion.setScale(2);
                        } else {
        
                            continue;
        
                        }
                        
                        
                        
                        axaltaCummutativePercent += axaltaPortion;
        System.debug('specialSplit: '+specialSplit);
        System.debug('specialSplitValue: '+specialSplitValue);
        System.debug('axaltaPortion: '+axaltaPortion);               
        System.debug('axaltaRemainingPercent: '+axaltaRemainingPercent);
        System.debug('axaltaDollarPortion: '+ axaltaDollarPortion);
        System.debug('axaltaCummutativePercent: '+axaltaCummutativePercent);
                        thisQuoteLine.Axalta_Value__c = AxaltaDollarPortion.setScale(2);
        System.debug( 'quoteline '+ productName +' : '+thisQuoteLine);
                }
            }
        }

        dataModel.mapSpecialSplitValueByQuoteLineId = mapSpecialSplitValueByQuoteLineId;

    }

    private static void calculateStandardValuesForOptimizer(DealSplitCalculatorModel dataModel){
    
        System.debug('dataModel '+ dataModel);
        SBQQ__Quote__c quote = dataModel.quote;
        Set<String> setAllProductNames = mapSpecialSplitRuleFactorsByProductCode.keySet();
        List<SBQQ__QuoteLine__c> listAllQuoteLines = new List<SBQQ__QuoteLine__c>();
        for(List<SBQQ__QuoteLine__c> listProductCodeQuoteLines : dataModel.mapListQuoteLinesByProductCode.values()){
            listAllQuoteLines.addAll( listProductCodeQuoteLines );
        }

        for(SBQQ__QuoteLine__c thisQuoteline : listAllQuoteLines ){
            if( setAllProductNames.contains( thisQuoteline.SBQQ__ProductCode__c ) ){
                dataModel.totalIncentiveAmount += thisQuoteline.Incentive_Value__c;
            }
            if( listTotalRebateNames.contains( thisQuoteline.SBQQ__ProductCode__c ) ){
                dataModel.totalRebateIncentiveAmount += thisQuoteline.Incentive_Value__c;
            }
            if( listTotalInvestmentsNames.contains( thisQuoteline.SBQQ__ProductCode__c ) ){
                dataModel.totalInvestmentsIncentiveAmount += thisQuoteline.Incentive_Value__c;
            }
            if( listTotalCashIvestment.contains( thisQuoteline.SBQQ__ProductCode__c )){
                dataModel.totalCashIvestment += thisQuoteline.Incentive_Value__c;
            }
        }
        Double npvInvestments = dataModel.totalInvestmentsIncentiveAmount;
System.debug('npvInvestments: '+npvInvestments);

        Double npvPurchases;
        if(quote.Distributor_HQ_ID__c == dealSplitOptimizerCustomSettings.Finish_Master_HQ__c){
            npvPurchases = quote.Final_Purchase_Agreement__c;
        } else {
            npvPurchases= calculateNPV(dataModel); 
        }
System.debug('npvPurchases: '+npvPurchases);
        //Naming conventions reflect the cell locations on the Deal Split Optimizer Excel Sheet
        Double ae109 = division(dataModel.totalRebateIncentiveAmount, quote.Final_Purchase_Agreement__c) + division(dataModel.totalInvestmentsIncentiveAmount, npvPurchases); 
        Double jobberThreshold = quote.Distributor_Threshold__c==null?quote.Distributor_Threshold__c / 100:0;
        Double axaltaThreshold = quote.Axalta_Threshold__c==null?quote.Axalta_Threshold__c / 100:0;

        
        Double remainingSplit = .5; //default 50/50 split from the Spreadsheet

        Double effectiveJobberThreshold = jobberThreshold > ae109 ? ae109 : jobberThreshold;

        Double ae117 = ae109 - effectiveJobberThreshold;
        Double effectiveAxaltaThreshold = ae117 < axaltaThreshold ? ae117 : axaltaThreshold;
        Double ae119 = ae117 - effectiveAxaltaThreshold;
        Double ae121 = ae119 * remainingSplit;

        Double ae123 = ae121 + effectiveAxaltaThreshold; 
        
        Double npvUpfrontInvestmentPercent = division(npvInvestments, npvPurchases);
        Double upfrontInvestmentPercent = division(npvInvestments, quote.Final_Purchase_Agreement__c);
        Double upfrontInvestmentNpvInvestmentRation = division(upfrontInvestmentPercent, npvUpfrontInvestmentPercent);
        Double maxInvestment = (ae123 >= npvUpfrontInvestmentPercent) ? (ae123 - npvUpfrontInvestmentPercent + upfrontInvestmentPercent) : (( division(ae123, npvUpfrontInvestmentPercent)) * upfrontInvestmentPercent);
        Double percentInvestmentForAxalta = division( ae123, npvUpfrontInvestmentPercent);
        System.debug('npvUpfrontInvestmentPercent: '+npvUpfrontInvestmentPercent);
        System.debug('upfrontInvestmentPercent: '+upfrontInvestmentPercent);
        System.debug('upfrontInvestmentNpvInvestmentRation: '+upfrontInvestmentNpvInvestmentRation);
        System.debug('maxInvestment: '+maxInvestment);
        System.debug('percentInvestmentForAxalta: '+percentInvestmentForAxalta);

        dataModel.totalRebates = (maxInvestment > upfrontInvestmentPercent) ? ( ( maxInvestment - upfrontInvestmentPercent ) * quote.Final_Purchase_Agreement__c)  : 0;
        dataModel.maxCashInvestment = percentInvestmentForAxalta > 1 ? npvInvestments : npvInvestments * percentInvestmentForAxalta;
        dataModel.investmentExchangeRate = division( 1, upfrontInvestmentNpvInvestmentRation );

        double totalEffectiveDiscount = quote.TED__c / 100;
        double ab116 = jobberThreshold > totalEffectiveDiscount ? totalEffectiveDiscount : jobberThreshold;
        double ab117 = totalEffectiveDiscount - ab116;
        double ab118 = ab117 < axaltaThreshold ? ab117 : axaltaThreshold;
        double ab119 = ab117 - ab118;
        double ab120 = ab119 * remainingSplit;
        System.debug('jobberThreshold: '+jobberThreshold);
        System.debug('totalEffectiveDiscount: '+totalEffectiveDiscount);
        System.debug('ab116: '+ab116);
        System.debug('ab117: '+ab117);
        System.debug('ab118: '+ab118);
        System.debug('ab119: '+ab119);
        System.debug('ab120: '+ab120);
        dataModel.percentAxaltaTotal = ab120 + ab118;
        
    }

    private static Double division( object numerator, object denominator ){
        if( double.valueOf(denominator) <= 0 ){
            return 0;
        } else {
            return  double.valueOf(numerator) / double.valueOf(denominator);
        }
    }
    private static Double getCostOfCapital(DealSplitCalculatorModel dataModel){
        Double costOfCaptial = 0;
        if( dataModel.timeValueMoney == 'On'){
            costOfCaptial = Double.ValueOf(dataModel.quote.Cost_of_Capital__c / 100);
        }
        return costOfCaptial;
    }

    private static Decimal calculateNPV(DealSplitCalculatorModel dataModel) {
        SBQQ__Quote__c quote = dataModel.quote;
        List<Double> listCashFlow = generateCashFlow(quote);
        Double costOfCapital = getCostOfCapital( dataModel );
        System.debug('costOfCapital '+costOfCapital);
        Decimal npvPurchases = netPresentValue(costOfCapital, listCashFlow);

        return npvPurchases;
    }
    private static List<Double> generateCashFlow(SBQQ__Quote__c quote){
        List<Double> listYearlyPurchasesAtR = new List<Double>();
        Double fySales = quote.Annual_Purchase_Agreement__c;
        Decimal subscriptionTermInMonths = quote.SBQQ__SubscriptionTerm__c;
        Double growthRate = quote.Volume_Growth_Adjustment__c / 100;
        Integer currentMonth = 0;
        while( currentMonth <= subscriptionTermInMonths){
            currentMonth += 12;
            if( currentMonth > 12) {
                fySales = fySales * ( 1 + .05 ) * ( 1 + growthRate );
            }
            if( subscriptionTermInMonths > currentMonth){
                listYearlyPurchasesAtR.add( fySales );
            } else {
                Double test =  currentMonth - 12;
                if(subscriptionTermInMonths < 12 && (subscriptionTermInMonths - 12) < 12 ){
                    listYearlyPurchasesAtR.add( 0 );
                } else if( ( subscriptionTermInMonths - ( currentMonth - 12 ) ) < 0) {
                    listYearlyPurchasesAtR.add( 0 );
                } else {
                    Double yearlyPurchaseAtR = ( subscriptionTermInMonths - (  currentMonth - 12 ) ) * fySales / 12;
                    listYearlyPurchasesAtR.add( yearlyPurchaseAtR );
                }
            }
            
        }
        return listYearlyPurchasesAtR;


    }

    private static Decimal netPresentValue(Double discountRate, List<Double> listCashFlow){

        Decimal value = 0;
        for(Integer i = 0; i < listCashFlow.size(); i++){
            value += listCashFlow[i] / Math.pow(1 + discountRate, Double.valueOf(i + 1) );
        }
        return value;

    }
}