const cds = require('@sap/cds');
const { validator } = require('./assets/validator')
const constants = require('./assets/constants')

class HRService extends cds.ApplicationService {
    async init() {
        this.on('setSalary', '*', async req => {
            try {
                const { ProjectsInfo_proj, Employee, Project } = this.entities;
                const { salary } = req.data;
                const [ID, { ID: projID }] = req.params;

                const [projectInfo] = await SELECT(ProjectsInfo_proj).where({ ID: projID });
                const [project] = await SELECT(Project).where({ ID: projectInfo.projects_ID });
                const [employee] = await SELECT(Employee).where({ ID: projectInfo.employees_ID });

                const dataForCPI = {
                    salary: salary,
                    salary_currency_code: project.salary_currency_code,
                    local_currency_code: employee.local_currency_code
                }

                const converterCPI = await cds.connect.to('CPIConverter');
                const converterResponse = await converterCPI.tx(req).post('/converter', dataForCPI);
                await UPDATE(ProjectsInfo_proj, { ID: projID }).set(converterResponse);
            } catch (error) {
                console.log(error);
                return req.error(400, constants.genericError.salaryNotSet);
            }

        });

        this.before('NEW', 'Employee', async req => {
            try {
                req.data.image = ''
            } catch (error) {
                console.log(error);
                return req.error(400, constants.genericError.unexpected);
            }
        });

        this.before('SAVE', 'Employee', async (req) => {
            try {
                if (req.data.imageUrl !== null && req.data.imageUrl !== '') {
                    const isURL = validator.isURL(req.data.imageUrl);

                    if (isURL) {
                        req.data.image = req.data.imageUrl;
                    } else {
                        return req.error(400, constants.genericError.invalidURL);
                    }
                }
            } catch (error) {
                console.log(error);
                return req.error(400, constants.genericError.unexpected);
            }
        })

        return await super.init()
    }
}

module.exports = { HRService };
// module.exports = cds.service.impl(function () {
//     // const { SELECT, UPDATE } = cds.ql;
//     const { E } = this.entities;
//     // this.on('orderBook', async (req) => {
//     //     try {
//     //         const [{ ID }] = req.params;

//     //         const order = await SELECT.one.from(BookOrder).where({ ID: ID });

//     //         if (order.status_ID !== '3') {
//     //             throw new Error("This order has been sent!")
//     //         }

//     //         const book = await SELECT.one.from(Library).where({ ID: order.book_ID });
//     //         const author = await SELECT.one.from(Authors).where({ ID: book.author_ID });

//     //         const cpiReqData = orderDataForCPI(order, book, author);
//     //         const cpiResponse = await requestToCPI(req, cpiReqData);

//     //         await UPDATE(BookOrder, ID).with({
//     //             CurrencyCode_code: cpiResponse.CurrencyCode_code,
//     //             LocalCurrencyCode_code: cpiResponse.LocalCurrencyCode_code,
//     //             totalPrice: cpiResponse.totalPrice,
//     //             totalLocal: cpiResponse.totalLocal,
//     //             status_ID: '2'
//     //         });
//     //     } catch (error) {
//     //         throw new Error(error.message)
//     //     }
//     // })
//     // this.before('NEW', 'BookOrder', async req => {
//     //     try {
//     //         const query = cds.parse.cql(`SELECT  MAX(ORDERCOUNT) as ORDERCOUNT FROM BookOrder`);
//     //         const [{ ORDERCOUNT }] = await this.run(query);
//     //         const order = ORDERCOUNT ? ORDERCOUNT : 0;

//     //         req.data.orderCount = order + 1;
//     //         req.data.orderEnable = true;
//     //     } catch (error) {
//     //         throw new Error(error.message)
//     //     }
//     // });

//     // this.before('SAVE', 'BookOrder', async req => {
//     //     try {
//     //         const order = req.data;
//     //         const book = await SELECT.one.from(Library).where({ ID: req.data.book_ID });
//     //         const cpiReqData = orderDataForCPI(order, book);
//     //         const cpiResponse = await requestToCPI(req, cpiReqData);



//     //         req.data.LocalCurrencyCode_code = cpiResponse.LocalCurrencyCode_code;
//     //         req.data.CurrencyCode_code = cpiResponse.CurrencyCode_code;
//     //         req.data.totalPrice = cpiResponse.totalPrice;
//     //         req.data.totalLocal = cpiResponse.totalLocal;
//     //         req.data.orderEnable = true;
//     //         req.data.status_ID = '3';

//     //     } catch (error) {
//     //         throw new Error(error.message)
//     //     }
//     // });


//     // this.after('READ', 'BookOrder', async req => {
//     //     try {
//     //         if (req.status_ID === '3') {
//     //             req.orderEnable = true;
//     //         } else {
//     //             req.orderEnable = false;
//     //         }
//     //     } catch (error) {
//     //         throw new Error(error.message)
//     //     }
//     // });

//     // this.before('EDIT', 'BookOrder', async req => {
//     //     try {
//     //         const ID = req.query.SELECT.from.ref[0].where[2].val;
//     //         const order = await SELECT.one.from(BookOrder).where({ ID: ID });

//     //         if (order.status_ID !== '3') {
//     //             const status = await SELECT.one.from(Statuses).where({ ID: order.status_ID });
//     //             throw new Error(`This order cannot be modified, because order status: '${status.name}'.`)
//     //         }

//     //     } catch (error) {
//     //         throw new Error(error.message)
//     //     }
//     // });

//     // this.before('NEW', ['Authors', 'Library'], async req => {
//     //     try {
//     //         req.data.image = ''

//     //     } catch (error) {
//     //         throw new Error(error.message)
//     //     }
//     // });

//     // this.before('SAVE', ['E', 'Library'], async req => {
//     //     try {
//     //         if (req.data.imageUrl !== null) {
//     //             const isURL = validator.isURL(req.data.imageUrl);

//     //             if (isURL) {
//     //                 req.data.image = req.data.imageUrl;
//     //             } else {
//     //                 throw new Error('Invalid Image URL. URL should have protocol(https:// or http://) and Fully Qualified Domain Name.')
//     //             }
//     //         }
//     //     } catch (error) {
//     //         throw new Error(error.message)
//     //     }
//     // });
// });