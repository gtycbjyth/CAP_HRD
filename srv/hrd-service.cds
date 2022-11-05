using my.hr_department as hrd from '../db/schema';
using masterdata as masterdata from '../db/masterdata';


service HRService {
    entity Employee            as projection on hrd.Employee {
        *,
        projects                                 : redirected to ProjectsInfo_proj,
        firstName || ' ' || lastName as fullName : String
    };

    entity Project             as projection on hrd.Project {
        *,
        employees : redirected to ProjectsInfo_empl
    };

    entity ProjectsInfo_empl   as projection on hrd.ProjectInfo {
        *,
        employees : redirected to Employee
    };

    entity ProjectsInfo_proj   as projection on hrd.ProjectInfo {
        *,
        projects : redirected to Project
    };

    @readonly
    @cds.redirection.target
    entity Accounting          as projection on hrd.Project{
        *,
        employees : redirected to ProjectsInfo_empl
    };

    entity AssesmentDepartment as projection on hrd.AssesmentDepartment;
    entity LanguageLevel       as projection on masterdata.LanguageLevel;
    entity JobFunction         as projection on masterdata.JobFunction;
    entity JobStatuses         as projection on masterdata.JobStatuses;
}

annotate HRService.Project with @odata.draft.enabled;
annotate HRService.Employee with @odata.draft.enabled;


annotate HRService.ProjectsInfo_proj {
    projects @(Common : {
        Text            : projects.projectTitle,
        TextArrangement : #TextOnly,
        ValueList       : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'Project',
            Parameters     : [{
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : projects_ID,
                ValueListProperty : 'ID',
            }, ],
        },
    }, );
}

annotate HRService.ProjectsInfo_empl {
    employees @(Common : {
        Text            : employees.fullName,
        TextArrangement : #TextOnly,
        ValueList       : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'Employee',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : employees_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'fullName',
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'jobFunction_title',
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'jobStatus_status',
                },
            ],
        },

    }, )
};
