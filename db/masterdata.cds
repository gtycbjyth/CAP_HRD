namespace masterdata;


entity LanguageLevel {
    key level          : String default 'N/A';
        criticality : Integer;
}

entity JobStatuses { 
    key status        : String(20);
        criticality : Integer;
}

entity JobFunction{ 
    key    title        : String(20);
        // criticality : Integer;
}
// entity LanguageLevel {
//     key level         : String;
//         criticality : Integer;
// }

// entity JobStatuses { 
//     key status        : String(20);
//         criticality : Integer;
// }

// entity JobFunction{ 
//     key ID          : String;
//         name        : String(20);
// }


