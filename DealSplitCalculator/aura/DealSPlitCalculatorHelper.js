({
    //ability to pick priority list

    getQuoteData : function(component){
        let recordId = component.get('v.recordId')
        let getQuoteData = component.get('c.getQuoteData');
        getQuoteData.setParams({
            quoteId: recordId
        });
        getQuoteData.setCallback( 
            this, 
            function(response){
                if(response.getState() === 'SUCCESS'){
                    debugger;
                    let returnValue = response.getReturnValue();
                    component.set('v.data', returnValue);
                    component.set('v.quote', returnValue.quote);
                    component.set('v.mapListQuoteLinesByProductCode', JSON.parse(JSON.stringify(returnValue.mapListQuoteLinesByProductCode)));
                  
                    this.setQuotelines(component);
                    this.hideSpinner(component);
                } else {
                    console.log(response.getError());
                }
            }
        );
        $A.enqueueAction(getQuoteData);
    },

    handleOnSave : function(component){
        let listQuoteLines = component.get('v.listQuoteLines') ;

        let listInputs = [];
        listQuoteLines.forEach(function(quoteLine){
            let splitNumber = quoteLine.Incentive__c * quoteLine.Axalta_Value__c / quoteLine.Incentive_Value__c;
            listInputs.push({
                Id : quoteLine.Id,
                Axalta_Split_Number__c : splitNumber ? splitNumber : 0
            });
        });
       
        let saveQuoteData = component.get('c.saveQuoteData');
        saveQuoteData.setParams({
            listQuoteLines: listInputs
        });
        saveQuoteData.setCallback(
            this,
            function(response){
                if(response.getState() === 'SUCCESS'){
                   
                    this.navigateToQuoteLineEditor(component, 'reload');
                    this.hideSpinner(component);
                } else {
                    console.log(response.getError());
                }
            }
        );
        $A.enqueueAction(saveQuoteData);
    },
    handleRecalculate: function(component){
        let recordId = component.get('v.recordId')
        let timeValueMoney = component.get('v.data.timeValueMoney');
        let recalculateData = component.get('c.recalculateDealSplicModel');
        recalculateData.setParams({
            quoteId: recordId,
            timeValueMoneyInput: timeValueMoney
        });
        recalculateData.setCallback( 
            this, 
            function(response){
                if(response.getState() === 'SUCCESS'){
                    let returnValue = response.getReturnValue();
                    component.set('v.data', returnValue);
                    component.set('v.quote', returnValue.quote);
                    component.set('v.mapListQuoteLinesByProductCode', JSON.parse(JSON.stringify(returnValue.mapListQuoteLinesByProductCode)));
                  
                    this.setQuotelines(component);
                    this.hideSpinner(component);

                } else {
                    console.log(response.getError());
                }
            }
        );
        $A.enqueueAction(recalculateData);
    },

    handleOnReset: function(component){
        let data = component.get('v.data');
        component.set('v.mapListQuoteLinesByProductCode', JSON.parse(JSON.stringify(data.mapListQuoteLinesByProductCode)));
        this.setQuotelines(component);
    },

    navigateToQuoteLineEditor: function(component, action){
     
        let dealSplitCalculatorEvent = $A.get("e.c:DealSplitCalculatorEvent");
        dealSplitCalculatorEvent.setParams({
            data: component.get('v.configData'),
            action: action
        });
        dealSplitCalculatorEvent.fire();
    },



    handleOptimize : function(component){
        let totalCashProductCodes = [   '3rd Party Training and Services', 
                                        'Axalta Training and Services', 
                                        'Consolidator Prebate', 
                                        'Custom Equipment Bundle', 
                                        'Buy Axalta Equipment',
                                        'Existing Equipment', 
                                        'Irregular Cash', 
                                        'Recurring Prebate',
                                        'Termination Charges',
                                        'Upfront Prebate'];

        let data = component.get('v.data');
        let mapListQuoteLinesByProductCode = component.get('v.mapListQuoteLinesByProductCode');
        let finalPurchaseAgreement = data.quote.Final_Purchase_Agreement__c;

        let totalRebates = data.totalRebates; 
        let investmentExchangeRate = data.investmentExchangeRate; 
        let maxCashInvestment = data.maxCashInvestment;  

        let mapSpecialSplitValueByQuotelineId = data.mapSpecialSplitValueByQuoteLineId;

        let actualCash = 0; 
        totalCashProductCodes.forEach( function( productCode ){
            let listProductQuoteLine = mapListQuoteLinesByProductCode[productCode];
            if( listProductQuoteLine ){
                listProductQuoteLine.forEach( function( quoteLine ){
                    if( !$A.util.isUndefinedOrNull(quoteLine) && quoteLine.Axalta_Value__c ){
                        actualCash = actualCash + parseFloat(quoteLine.Axalta_Value__c);
                    }
                });
            }
        } );


        let maxCashInvestmentOptimizationPercent = this.division(maxCashInvestment, finalPurchaseAgreement); 
        let actualCashOptimizationPercent = this.division(actualCash, finalPurchaseAgreement);
        let rebateOptimizer = ( maxCashInvestmentOptimizationPercent - actualCashOptimizationPercent) * investmentExchangeRate * finalPurchaseAgreement;

        let initalCashLeft = rebateOptimizer + totalRebates
        let cashLeft = initalCashLeft;

        let calculationOrder = data.listProductHierarchy;
        let listRebateProducts = data.listRebateNames;

        calculationOrder.forEach( function( productCode ){
            let listProductQuoteLine = mapListQuoteLinesByProductCode[productCode];
            if( listProductQuoteLine ){

                listProductQuoteLine.forEach( function( quoteLine ){
                    
                    if( !$A.util.isUndefinedOrNull(quoteLine) && listRebateProducts.includes( productCode )){
                        let quoteLineSpecialSplitValue = mapSpecialSplitValueByQuotelineId[ quoteLine.Id ];
                        let optimizationAmount = ( cashLeft > quoteLineSpecialSplitValue ) ? quoteLineSpecialSplitValue : cashLeft;
                        cashLeft = cashLeft - optimizationAmount;
                        let newDiscountPercent = (optimizationAmount / finalPurchaseAgreement > quoteLine.Incentive_Effective_Discount__c) ? quoteLine.Incentive_Effective_Discount__c : optimizationAmount / finalPurchaseAgreement;
                        let optimizedAxaltaAmount = finalPurchaseAgreement * newDiscountPercent;
                        quoteLine.Axalta_Value__c = optimizedAxaltaAmount.toFixed(2);
                     
                    }
                });
            }

        });

        this.setQuotelines(component);

    },
    setQuotelines: function(component) {
        let mapListQuoteLinesByProductCode = component.get('v.mapListQuoteLinesByProductCode');
        let listAllQuoteLines = [];
        for(let productKey in mapListQuoteLinesByProductCode){
            let listProductCodeQuoteline = mapListQuoteLinesByProductCode[productKey];
            if( listProductCodeQuoteline ){

                for( let arrayIndex = 0; arrayIndex < listProductCodeQuoteline.length; arrayIndex++ ){
                    
                    mapListQuoteLinesByProductCode[productKey][arrayIndex].ProductName = listProductCodeQuoteline[arrayIndex].SBQQ__Product__r.Name;
                    mapListQuoteLinesByProductCode[productKey][arrayIndex].Axalta_Split__c = listProductCodeQuoteline[arrayIndex].Axalta_Value__c ? parseFloat(listProductCodeQuoteline[arrayIndex].Axalta_Value__c) / parseFloat(listProductCodeQuoteline[arrayIndex].Incentive_Value__c) * 100 : 0; 
                    mapListQuoteLinesByProductCode[productKey][arrayIndex].Distributor_Value__c = listProductCodeQuoteline[arrayIndex].Incentive_Value__c - listProductCodeQuoteline[arrayIndex].Axalta_Value__c;
                    mapListQuoteLinesByProductCode[productKey][arrayIndex].Distributor_Split__c = listProductCodeQuoteline[arrayIndex].Distributor_Value__c ? parseFloat(listProductCodeQuoteline[arrayIndex].Distributor_Value__c) / parseFloat(listProductCodeQuoteline[arrayIndex].Incentive_Value__c) * 100 : 0;
    
                    listAllQuoteLines.push(mapListQuoteLinesByProductCode[productKey][arrayIndex]);
                }
            }
            
        }
        component.set("v.listQuoteLines", listAllQuoteLines);
    },

    
    division : function(numerator, denominator){
        if( denominator <= 0) {
            return 0;
        } else {
            let result = numerator/denominator;
            if(result < 0) {
                return 0;
            } else {
                return result;
            }
        }
    },

    showSpinner: function(component){
        let spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, 'slds-hide')
    },

    hideSpinner: function(component){
        let spinner = component.find("mySpinner");
        $A.util.addClass(spinner, 'slds-hide')
    }

})
