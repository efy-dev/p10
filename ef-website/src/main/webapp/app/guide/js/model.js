var PageVariable = {
    template: {productModelList: "productModelList"},
    service: {
        login: "/wx/login",
        listProductModel: "/product/getProductModelList"
    },

    userId: "",
    tenant: {},
    productModelList: [],
    tenantColumnList: [],
    tenantPraiseList: [],
    productModel: {},
    productModelColumnList: [],
    tenantList: [],
    master: {},
    project: {},
    imageTextList: [],
    imageText: {},
    recommendList: [],

    imageStyle: {}
};

//@TODO
function getTenantById(id) {

}

//@TODO
function getTenantColumnListByTenant(id) {

}

//@TODO
function getTenantPraiseListByTenant(id) {

}

//@TODO
function getProductModelById(id) {

}

//@TODO
function getColumnListByProductModel(id) {

}

//@TODO
function getTenantList(param, limit, offset) {

}


//demo
function getProductModelList(param, limit, offset) {
    var success = function (data) {
        PageVariable.productModelList = data;
        renderProductModelList();
    };
    var requestParam = {};
    requestParam.param = param;
    requestParam.limit = limit;
    requestParam.offset = offset;
    ajaxRequest(PageVariable.service.listProductModel, requestParam, success);
}

//@TODO
function getImageTextListByTenant(id) {

}

//@TODO
function getImageTextById(id) {

}

//@TODO
function getRecommendList(param, limit, offset) {

}


