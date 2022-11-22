using AgriExports as service from './cat-service';

annotate service.Products with @(UI : {
    SelectionFields : [
        Area,
        Year,
        Product,
        Variety
    ],
    Identification  : [{
        Value : Area,
        Label : 'Area Name'
    }],
    LineItem        : [
        {
            $Type : 'UI.DataField',
            Label : 'Area',
            Value : Area,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Year',
            Value : Year,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Product',
            Value : Product,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Variety',
            Value : Variety,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Net Weight',
            Value : Weight,
        },
        {
            $Type : 'UI.DataField',
            Label : 'No of Leaves',
            Value : NoofLeaves,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Length',
            Value : length,
        }
    ]
});

annotate service.Products with @(
    UI.HeaderInfo                  : {
        TypeName       : 'Product Info',
        TypeNamePlural : 'Product Info',
        ImageUrl       : 'https://images.immediate.co.uk/production/volatile/sites/30/2017/01/Bananas-218094b-scaled.jpg',
        Title          : {
            $Type : 'UI.DataField',
            Label : 'ID',
            Value : ID,
        },
        Description    : {
            $Type : 'UI.DataField',
            Label : 'Product',
            Value : Product,
        },
    },
    UI.Facets                      : [{
        $Type  : 'UI.ReferenceFacet',
        ID     : 'GeneratedFacet5',
        Label  : 'Product Information',
        Target : '@UI.FieldGroup#GeneratedGroup5',
    }],
    UI.FieldGroup #GeneratedGroup5 : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            // {
            //     $Type  : 'UI.DataFieldForAction',
            //     Label  : 'Review Data',
            //     Action : 'AgriExports.EntityContainer/ReviewState',
            // },
            {
                $Type : 'UI.DataField',
                Label : 'Year',
                Value : Year,
            // @cds.odata.bindingparameter.name : '_it'
            },
            {
                $Type : 'UI.DataField',
                Label : 'Variety',
                Value : Variety,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Net Weight',
                Value : Weight,
            },
            {
                $Type : 'UI.DataField',
                Label : 'No of Leaves',
                Value : NoofLeaves,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Length of Product',
                Value : length,
            }
        ]
    },
);

annotate service.BuyerData with @(UI : {
    SelectionFields : [
        Region.Code,
        CustomerName,
        Country.code,
        BuyerType,
        PaymentTerm
    ],
    Identification  : [{
        Value : CustomerName,
        Label : 'Buyer Name'
    }],
    LineItem        : [
        {
            $Type : 'UI.DataField',
            Label : 'Region',
            Value : Region.Code,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Country',
            Value : Country_code,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Buyer Name',
            // Target: 'BuyerInfo.@Communication',
            Value : CustomerName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Buyer Type',
            Value : BuyerType,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Contact No',
            Value : Contactno,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Email',
            Value : Email,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Buyer Rating',
            Value : Buyer_Rating,
        },
    ]
});

annotate service.BuyerInfo with @(Communication : {Contact : {
    fn    : CustomerName,
    email : [{
        $Type   : 'Communication.EmailAddressType',
        address : Email,
        type    : #work,
    }, ],
    tel   : [{
        $Type : 'Communication.PhoneNumberType',
        uri   : Contactno,
        type  : #cell,
    }, ],

}, });
