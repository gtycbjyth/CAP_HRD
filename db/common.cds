namespace common;
 
using { cuid, managed, Currency, Country } from '@sap/cds/common';

extend sap.common.Currencies with {
    numcode  : Integer;
    exponent : Integer;
    minor    : String; 
}
 
    // sap.common.Currencies.code:  default 'BYN';
type CurrencyType : Decimal(15, 2)@(
        Semantics.amount.currencyCode : 'CURRENCY_code',
        sap.unit                      : 'CURRENCY_code'
    );

