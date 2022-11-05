using HRService as service from '../../srv/hrd-service';

annotate service.Accounting with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>projectLogo}',
            Value : projectLogo,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>projectTitle}',
            Value : projectTitle,
        },
        {
            $Type : 'UI.DataField',
            Value : employees.employees.fullName,
            Label : '{i18n>fullName}',
        },
    ]
);
annotate service.Accounting with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>projectLogo}',
                Value : projectLogo,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>projectTitle}',
                Value : projectTitle,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>members}',
            ID : 'i18nmembers',
            Target : 'employees/@UI.LineItem#i18nmembers',
        },
    ]
);
annotate service.ProjectsInfo_empl with @(
    UI.LineItem #i18nmembers : [
        {
            $Type : 'UI.DataField',
            Value : employees.fullName,
            Label : '{i18n>fullName}',
        },{
            $Type : 'UI.DataField',
            Value : employees.jobFunction_title,
            Label : '{i18n>jobFunction}',
        },{
            $Type : 'UI.DataField',
            Value : salary,
            Label : '{i18n>salary}',
        },{
            $Type : 'UI.DataField',
            Value : local_salary,
            Label : '{i18n>localSalary}',
        },]
);
annotate service.ProjectsInfo_empl with {
    local_salary @Common.Text : {
            $value : local_currency_code,
            ![@UI.TextArrangement] : #TextFirst,
        }
};
annotate service.ProjectsInfo_empl with {
    salary @Common.Text : {
            $value : salary_currency_code,
            ![@UI.TextArrangement] : #TextFirst,
        }
};
annotate service.Accounting with @(
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>project}',
            ID : 'i18nprojectTitle',
            Target : '@UI.FieldGroup#i18nprojectTitle',
        },
    ],
    UI.FieldGroup #i18nprojectTitle : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : employees.projects.projectLogo,
            },{
                $Type : 'UI.DataField',
                Value : employees.projects.projectTitle,
            },],
    }
);
