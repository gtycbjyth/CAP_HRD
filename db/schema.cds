namespace my.hr_department;

using {
    managed,
    Country
} from '@sap/cds/common';

using {masterdata} from './masterdata';
using {
       // sap.common.CodeList,
       Currency} from './common';

entity Employee : managed {
    key ID            : UUID;
        firstName     : String(20);
        lastName      : String(20);
        birthday      : Date;
        country       : Country;
        projects      : Composition of many ProjectInfo
                            on projects.employees = $self;
        jobStatus     : Association to masterdata.JobStatuses;
        jobFunction   : Association to masterdata.JobFunction;
        imageUrl      : String;
        image         : LargeString @Core.IsURL  @Core.MediaType : 'image/jpg';
        languageLevel : Association to masterdata.LanguageLevel;
        assesmentDate : Date;
}

entity Project : managed {
    key ID           : UUID;
        projectTitle : String(50);
        employees    : Composition of many ProjectInfo
                           on employees.projects = $self;
        projectLogo  : LargeString @Core.MediaType : 'image/jpg';
}

entity ProjectInfo: managed {
    key ID        : UUID;
        employees : Association to Employee;
        projects  : Association to Project;
        salary          : Decimal;
        local_salary    : Decimal;
        salary_currency : Currency;
        local_currency  : Currency;
}

entity AssesmentDepartment {
    key ID                 : UUID;
        employee           : Association to one Employee;
        level              : Association to masterdata.LanguageLevel;
        date               : Date;
        virtual isOutdated : Boolean;
}

// entity Accounting {
//     key ID              : UUID;
//         salary          : Decimal;
//         local_salary    : Decimal;
//         salary_currency : Currency;
//         local_currency  : Currency;
// }

