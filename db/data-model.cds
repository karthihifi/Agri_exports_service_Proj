namespace my.agri_exports;

// entity Books {
//   key ID : Integer;
//   title  : String;
//   stock  : Integer;
// }

using {
  cuid,
  managed,
  Currency,
  Country,
  sap.common.CodeList

} from '@sap/cds/common';

type Address {
  street  : String;
  town    : String;
  Pincode : Integer;
  country : Country; //> pre-defined reuse type
  region  : String;
}


entity ReviewStatus : CodeList {
  key code  : Integer;
      descr : String;
};

entity Procurement : cuid, managed {
  key ID                  : UUID @(Core.Computed : true);
  key Year                : Integer;
  key Area                : String(10);
      Product             : String(10);
      Grade               : String(5);
      Area_size           : Integer;
      Area_Qauality       : Integer;
      Utlization          : Integer;
      Sapling_qty         : Integer;
      Sapling_price       : Integer;
      Fertilizers_qty     : Integer;
      Fertilizers_price   : Integer;
      Labour_price        : Integer;
      Readiness_cost      : Integer;
      Water_cost          : Integer;
      Electricity_cost    : Integer;
      Govt_allowances     : Integer;
      Other_expenses      : Integer;
      Total_cost          : Integer;
      Expense_curr_key    : Currency;
      Area_Dimen_key      : String(5);
      Fertilizer_Meas_key : String(5);
}

entity Harvesting : cuid, managed {
  key ID             : UUID @(Core.Computed : true);
  key Year           : Integer;
  key Area           : String(10);
      Product        : String(10);
      Variety        : String(10);
      Grade          : String(5);
      Color          : String(7);
      Maturity       : Integer;
      NetWeight      : Integer;
      Labour_cost    : Integer;
      Machinery_cost : Integer;
      Other_expenses : Integer;
      TotalExpense   : Integer;
}

@Aggregation.CustomAggregate #TotalQty : 'Edm.Decimal'
entity YieldPerArea : cuid, managed {
  key ID                 : UUID       @(Core.Computed : true);
  key Year               : Integer    @(
        assert.range : [
          2000,
          9999
        ],
        title        : 'Year'
      );
  key Area               : String(10) @title : 'Area';
      Product            : String(10);
      Variety            : String(10);
      @Measures.Unit       : 'Kg'
      @Aggregation.default : #SUM
      NetWeight          : Integer    @Common.IsUnit;
      TotalQty           : Integer;
      @Measures.Unit       : 'Kg'
      AvgWeight          : Integer;
      Review_Stat        : String;
      Review_Criticality : Integer;
      @title               : 'Rework Required'
      Comments           : String;
      Products           : Association to many Product
                             on Products.ProductItem = $self

}

entity ExtYieldPerArea : cuid, managed {
  key ID                 : UUID       @(Core.Computed : true);
  key Year               : Integer    @(
        assert.range : [
          2000,
          9999
        ],
        title        : 'Year'
      );
  key Area               : String(10) @title : 'Area';
      Product            : String(10);
      Variety            : String(10);
      @Measures.Unit       : 'Kg'
      @Aggregation.default : #SUM
      NetWeight          : Integer    @Common.IsUnit;
      TotalQty           : Integer;
      @Measures.Unit       : 'Kg'
      AvgWeight          : Integer;
      Review_Stat        : String(15);
      Review_Criticality : Integer;
      @title               : 'Rework Required'
      Comments           : String(300);
// Products           : Association to many Product
//                          on Products.ProductItem = $self

}

entity Product : cuid, managed {
  key ID          : UUID       @(Core.Computed : true);
  key Year        : Integer    @title         : 'Year';
  key Area        : String(10) @title         : 'Area';
  key Product     : String(10) @title         : 'Product';
      Variety     : String(15) @title         : 'Variety/SubGroup';
      @Measures.Unit : 'Kg'
      Weight      : Integer    @title         : 'Net Weight';
      NoofLeaves  : Integer    @title         : 'Total Leaves';
      @Measures.Unit : 'cm'
      length      : Integer    @title         : 'Length';
      user        : String     @cds.on.insert : $user;
      ProductItem : Association to YieldPerArea
// up_        : Association to YieldPerArea;
}

type Region {
  Code  : String(5);
  descr : String
}

entity Regions : CodeList {
  key Code  : String(10);
      name  : String;
      descr : String;
}

entity Buyers : cuid, managed {
  key ID               : UUID @(Core.Computed : true);
      Region           : Association to Regions;
      CustomerName     : String;
      customerinfo     : Association to BuyerInfo;
      TradingCurrency  : String(3) default 'USD';
      TradingCommodity : String;
      NearestPort      : String;
      // Country          : Country;
      // Address          : Address;
      BuyerType        : String;
      BuyerCapacity    : Integer;
      BuyingFrequency  : Integer;
      PackingType      : String;
      // Contactno        : String;
      // Email            : String;
      // Website          : String;
      PaymentTerm      : String;
      Buyer_Rating     : Integer;
      Activity_months  : String;
}

entity BuyerInfo : managed {
  key ID           : UUID @(Core.Computed : true);
      CustomerName : String;
      Email        : String;
      Contactno    : String;
      Website      : String;
}
