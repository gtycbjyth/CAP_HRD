sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/project/test/integration/FirstJourney',
		'ns/project/test/integration/pages/ProjectList',
		'ns/project/test/integration/pages/ProjectObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProjectList, ProjectObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/project') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProjectList: ProjectList,
					onTheProjectObjectPage: ProjectObjectPage
                }
            },
            opaJourney.run
        );
    }
);