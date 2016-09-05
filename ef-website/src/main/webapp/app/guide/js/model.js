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

function getTenantById(id) {

}

function getTenantColumnListByTenant(id) {

}

function getTenantPraiseListByTenant(id) {

}

function getProductModelById(id) {

}

function getColumnListByProductModel(id) {

}

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

function getImageTextListByTenant(id) {

}

function getImageTextById(id) {

}

function getRecommendList(param, limit, offset) {

}


