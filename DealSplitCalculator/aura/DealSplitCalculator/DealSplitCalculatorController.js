({
    onInit : function(component, event, helper){
        helper.getQuoteData(component);
    },
    onClickOptimize: function(component, event, helper){
        helper.handleOptimize(component);
    },

    onClickSave: function(component, event, helper){
        helper.handleOnSave(component);
    },

    onClickReset: function(component, event, helper){
        helper.handleOnReset(component);
    },
    onClickCancel: function(component, event, helper){
        helper.navigateToQuoteLineEditor(component, 'none');
    },
    onChangeTimeValueMoney: function(component, event, helper) {
        helper.showSpinner(component);
        helper.handleRecalculate(component);
    }
})