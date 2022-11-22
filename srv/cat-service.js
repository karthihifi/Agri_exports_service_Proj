const cds = require("@sap/cds");

class AgriExports extends cds.ApplicationService {
    init() {
        const db = cds.connect.to("db");
        // const { YieldPerArea } = db.entities ('Agri_exp')

        // this.on("getYieldArea", "ReviewState", async (req) => {
        //   console.log(req.path, "function");
        // });

        // this.after("READ", "Products", (Products) => {
        //     if (Products.length != null) {
        //         console.log(typeof (Products), Products.length, Products, "Prodducts")
        //         Products.forEach(item => {
        //             item.createdBy = 'test'
        //         });
        //     }
        // });

        // this.on("ReviewState", async (req) => {
        //   const { Area, Review_Stat, Comments } = req.data;
        //   console.log(Review_Stat, Comments, req.user, "Action");
        //   console.log("reached", req.id, Area);
        //   const srv = await cds.connect.to("AgriExports");
        //   const { YieldPerArea1 } = srv.entities;
        //   const Yields = await srv.run(
        //     SELECT.from(YieldPerArea1).where({
        //       Area: Area,
        //     })
        //   );
        //   console.log("Yields", Yields);
        // });

        // this.before("ReviewState", async (req) => {
        //   console.log(req.data, "Before");
        // });

        // this.after("ReviewState", async (req) => {
        //   console.log(req.data,'After');
        // });
        return super.init();
    }
}

module.exports = { AgriExports };
