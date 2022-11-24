using HRService as service from '../../srv/hrd-service';

annotate service.Project with @(UI.LineItem : [
    {
        $Type             : 'UI.DataField',
        Label             : '{i18n>projectLogo}',
        Value             : projectLogo,
        ![@UI.Importance] : #High
    },
    {
        $Type             : 'UI.DataField',
        Label             : '{i18n>projectTitle}',
        Value             : projectTitle,
        ![@UI.Importance] : #High
    },
    {
        $Type             : 'UI.DataField',
        Label             : '{i18n>projectMembers}',
        Value             : employees.employees.fullName,
        ![@UI.Importance] : #High
    },
]);


annotate service.Project with @(UI : {
    FieldGroup #ProjectData        : {
        $Type : 'UI.FieldGroupType',
        Data  : [
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
                Label : '{i18n>members}',
                Value : employees.employees_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : salary_currency_code,
                Label : '{i18n>currency}',
            },
        ],
    },
    FieldGroup #AdministrativeData : {Data : [
        {
            $Type : 'UI.DataField',
            Value : createdBy
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt
        },
        {
            $Type : 'UI.DataField',
            Value : modifiedBy
        },
        {
            $Type : 'UI.DataField',
            Value : modifiedAt
        }
    ]},
});

annotate service.Project with @(UI : {Facets : [
    {
        $Type  : 'UI.CollectionFacet',
        ID     : 'EmployeeData',
        Label  : '{i18n>project}',
        Facets : [{
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#ProjectData',
            Label  : '{i18n>employee}',
        }, ]
    },
    {
        $Type  : 'UI.CollectionFacet',
        ID     : 'AdminData',
        Label  : '{i18n>adminInfo}',
        Facets : [{
            $Type                : 'UI.ReferenceFacet',
            Target               : '@UI.FieldGroup#AdministrativeData',
            Label                : '{i18n>adminInfo}',
            ![@UI.PartOfPreview] : true
        }, ]
    },
]});

annotate service.Project {
    ID @(Common : {
        Text            : projectTitle,
        TextArrangement : #TextOnly,
    }, )
};
