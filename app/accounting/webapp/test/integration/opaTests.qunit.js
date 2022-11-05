sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/accounting/test/integration/FirstJourney',
		'ns/accounting/test/integration/pages/AccountingList',
		'ns/accounting/test/integration/pages/AccountingObjectPage'
    ],
    function(JourneyRunner, opaJourney, AccountingList, AccountingObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/accounting') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheAccountingList: AccountingList,
					onTheAccountingObjectPage: AccountingObjectPage
                }
            },
            opaJourney.run
        );
    }
);