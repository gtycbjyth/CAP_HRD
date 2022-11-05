using HRService as service from '../../srv/hrd-service';

annotate service.Employee with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : fullName,
            Label : '{i18n>fullName}',
        },
        {
            $Type : 'UI.DataField',
            Value : jobFunction_title,
            Label : '{i18n>jobFunction}',
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>jobStatus}',
            Value : jobStatus_status,
            Criticality : jobStatus.criticality,
            CriticalityRepresentation : #WithoutIcon,
        },
        {
            $Type : 'UI.DataField',
            Value : languageLevel_level,
            Label : '{i18n>languageLevel}',
            Criticality : languageLevel.criticality,
            CriticalityRepresentation : #WithoutIcon,
        },
        {
            $Type : 'UI.DataField',
            Value : country.name,
            Label : '{i18n>country}',
        },
    ]
);
annotate service.Employee with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>firstName}',
                Value : firstName,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>lastName}',
                Value : lastName,
            },
            {
                $Type : 'UI.DataField',
                Value : country_code,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Birthday}',
                Value : birthday,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>jobStatus}',
                Value : jobStatus_status,
                Criticality : jobStatus.criticality,
                CriticalityRepresentation : #WithoutIcon,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>jobFunction}',
                Value : jobFunction_title,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>imageUrl}',
                Value : imageUrl,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : '{i18n>employee}',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Admin Data',
            ID : 'AdminData',
            Target : '@UI.FieldGroup#AdminData',
        },
    ]
);
annotate service.Employee with @(
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'Employee',
            Target : '@UI.FieldGroup#Employee1',
        },],
    UI.FieldGroup #Employee : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    }
);
annotate service.Employee with @(
    UI.DataPoint #image : {
        $Type : 'UI.DataPointType',
        Value : image,
        Title : '{i18n>image}',
    },
    UI.DataPoint #fullName : {
        $Type : 'UI.DataPointType',
        Value : fullName,
        Title : '{i18n>fullName}',
    },
    UI.DataPoint #languageLevel_level : {
        $Type : 'UI.DataPointType',
        Value : languageLevel_level,
        Title : '{i18n>languageLevel}level}',
        Criticality : languageLevel.criticality,
    }
);
annotate service.Employee with @(
    UI.DataPoint #assesmentDate : {
        $Type : 'UI.DataPointType',
        Value : assesmentDate,
        Title : '{i18n>assesmentDate}',
    }
);

annotate service.Employee {
    ID            @(Common : {
        Text            : fullName,
        TextArrangement : #TextOnly,
    }, );

    jobStatus     @(Common : {
        Text            : jobStatus.status,
        TextArrangement : #TextOnly,
        ValueList       : {
            CollectionPath  : 'JobStatuses',
            Label           : '{i18n>jobStatus}',
            Parameters      : [{
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : jobStatus_status,
                ValueListProperty : 'status',
            }, ],
            SearchSupported : true,

        }
    });

    jobFunction   @(Common : {
        Text            : jobFunction.title,
        TextArrangement : #TextOnly,
        ValueList       : {
            CollectionPath  : 'JobFunction',
            // Label           : '{i18n>jobStatus}',
            Parameters      : [{
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : jobFunction_title,
                ValueListProperty : 'title',

            },

            ],
            SearchSupported : true,

        }
    });

    languageLevel @(Common : {ValueList : {
        $Type          : 'Common.ValueListType',
        CollectionPath : 'LanguageLevel',
        Parameters     : [{
            $Type             : 'Common.ValueListParameterInOut',
            LocalDataProperty : languageLevel_level,
            ValueListProperty : 'level',
        }, ],
    }, }, );

    country       @(Common : {Text : country.name, }, )

};  
annotate service.Employee with @(
    UI.FieldGroup #Employee1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : image,
            },{
                $Type : 'UI.DataField',
                Value : fullName,
                Criticality: 5,
                CriticalityRepresentation : #WithoutIcon,
            },{
                $Type : 'UI.DataField',
                Value : languageLevel_level,
                Label : '{i18n>languageLevel}',
                Criticality : languageLevel.criticality,
                CriticalityRepresentation : #WithoutIcon,
            },{
                $Type : 'UI.DataField',
                Value : assesmentDate,
                Label : '{i18n>assesmentDate}',
            },
            {
                $Type : 'UI.DataField',
                Value : projects.ID,
                Label : 'ID',
            },],
    }
);
annotate service.Employee with @(
    UI.FieldGroup #AdminData : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },{
                $Type : 'UI.DataField',
                Value : createdBy,
            },{
                $Type : 'UI.DataField',
                Value : modifiedAt,
            },{
                $Type : 'UI.DataField',
                Value : modifiedBy,
            },],
    }
);
