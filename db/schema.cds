namespace riskmanagement;
using { managed } from '@sap/cds/common';

entity Risks : managed {
    key ID : UUID @ (Core.Computed : true);
    title : String(100);
    owner : String;
    prio : String(5);
    descr : String;
    miti : Association to Mitigations;
    impact :Integer;
    bp : Association to BusinessPartners;
    criticality : Integer;
}

entity Mitigations : managed {
    key ID : UUID @ (Core.Computed : true);
    descr : String;        
    owner : String;
    timeline : String;
    risks : Association to many Risks on risks.miti = $self;
}

// using an external service from S/4
using { OP_API_BUSINESS_PARTNER_SRV as external } from '../srv/external/OP_API_BUSINESS_PARTNER_SRV.csn';

entity BusinessPartners as projection on external.A_BusinessPartner {
    key BusinessPartner,
    FirstName,
    LastName,
}