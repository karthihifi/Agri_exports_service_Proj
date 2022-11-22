using my.agri_exports as Agri_exp from '../db/data-model';

service AgriExports @(path : '/service') {

    type Actionret {
        Area        : String;
        Review_Stat : String;
        Comments    : String
    }

    entity Procurement @(restrict : [
        {
            grant : ['READ'],
            to    : ['Agri_Exp_Viewer']
        },
        {
            grant : ['*'],
            to    : ['Agri_Exp_Manager']
        }
    ])                  as projection on Agri_exp.Procurement;

    @odata.draft.enabled
    @cds.redirection.target
    entity Products     as projection on Agri_exp.Product

    // @odata.draft.enabled
    entity YieldPerArea1 @(restrict : [
        {
            grant : ['READ'],
            to    : ['Agri_Exp_Viewer']
        },
        {
            grant : ['*'],
            to    : ['Agri_Exp_Manager']
        }
    ])                  as projection on Agri_exp.YieldPerArea

    entity ReviewStatus as projection on Agri_exp.ReviewStatus

    entity ExtYieldperArea @(restrict : [
        {
            grant : ['READ'],
            to    : ['Agri_Exp_Viewer']
        },
        {
            grant : ['*'],
            to    : ['Agri_Exp_Manager']
        }
    ])                  as projection on Agri_exp.ExtYieldPerArea

    // @cds.redirection.target
    @readonly
    // @odata.draft.enabled
    entity YieldPerArea                                         @(restrict : [
        {
            grant : ['READ'],
            to    : ['Agri_Exp_Viewer']
        },
        {
            grant : ['*'],
            to    : ['Agri_Exp_Manager']
        }
    ])                  as
            select from Agri_exp.Product {
                    // key ID          as id,
                key Area        as Area,
                key Year        as Year,
                key Product     as Product,
                    Variety     as Variety,
                    count( * )  as TotalQty     : Integer,
                    SUM(Weight) as NetWeight    : Integer       @Measures.Unit                   : 'Kg',
                    AVG(Weight) as AvgWeight    : Integer       @Measures.Unit                   : 'Kg',
                    Products                    : Association to many AgriExports.Products
                                                      on Products.Area = $self.Area,
                    Reviews                     : Association to AgriExports.YieldPerArea1
                                                      on Reviews.Area = $self.Area
            }
            group by
                Year,
                Area,
                Product,
                Variety
        union
            select from Agri_exp.ExtYieldPerArea {
                    // key ID             as id,
                key Area           as Area,
                key Year           as Year,
                key Product        as Product,
                    Variety        as Variety,
                    count( * )     as TotalQty  : Integer,
                    SUM(NetWeight) as NetWeight : Integer       @Measures.Unit                   : 'Kg',
                    AVG(NetWeight) as AvgWeight : Integer       @Measures.Unit                   : 'Kg',
                    Products                    : Association to many AgriExports.Products
                                                      on Products.Area = $self.Area,
                    Reviews                     : Association to AgriExports.YieldPerArea1
                                                      on Reviews.Area = $self.Area
            }
            group by
                Year,
                Area,
                Product,
                Variety
            actions {
                @cds.odata.bindingparameter.name : '_it'
                // @Common.DefaultValuesFunction    : 'getYieldArea'
                action   ReviewState(Area : AgriExports.Actionret:Area
                                                                @UI.ParameterDefaultValue        : _it.Area
                                                                @Common                          : {FieldControl : #ReadOnly, },
                Review_Stat : AgriExports.Actionret:Review_Stat @Common.ValueListWithFixedValues : true
                                                                @Common.ValueList                : {
                    $Type          : 'Common.ValueListType',
                    CollectionPath : 'ReviewStatus',
                    Parameters     : [{
                        $Type             : 'Common.ValueListParameterInOut',
                        LocalDataProperty : 'Review_Stat',
                        ValueListProperty : 'descr',
                    }, ]

                }  @title : 'Review Status',
                Comments : AgriExports.Actionret:Comments       @UI.MultiLineText );
                function getYieldArea() returns Actionret;
            };

    @odata.draft.enabled
    entity BuyerData    as projection on Agri_exp.Buyers;

    entity BuyerInfo    as
        select from Agri_exp.Buyers {
            key ID,
                CustomerName,
                Contactno,
                Email,
                Website,
                Country,
                Address
        }

// entity BuyerInfo    as projection on Agri_exp.BuyerInfo;
}
