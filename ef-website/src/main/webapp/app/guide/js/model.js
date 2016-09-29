var PageVariable = {
    template: {
        productModelList: "productModelList",
        tenantList: "tenantList",
        homeRecommendList: "home-recommend-list",
        tenantBase: "tenant-base",
        tenantPraise: "tenant-praise"
    },
    service: {
        login: "/wx/login",
        listProductModel: "/product/getProductModelList",
        listTenant: "/tenant/getTenantList",
        listRecommend: "/tenant/getRecommendList",
        viewTenantById: "/tenant/getTenantById",
        listTenantPraise: "/tenant/getTenantPraiseListByTenant",
        listTenantPanel: "/tenant/getImageTextListByTenant"
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
function getTenantById(id, callback) {
    var success = function (data) {
        PageVariable.productModelList = data;
        if (typeof callback == "function") {
            callback();
        }
    };
    var requestParam = {};
    requestParam.id = id;
    ajaxRequest(PageVariable.service.viewTenantById, requestParam, success);
}

//@TODO
function getColumnListByTenant(id) {

}

//@TODO
function getTenantPraiseListByTenant(id, callback) {
    var success = function (data) {
        PageVariable.productModelList = data;
        if (typeof callback == "function") {
            callback();
        }
    };
    var requestParam = {};
    requestParam.tenantId = id;
    ajaxRequest(PageVariable.service.listTenantPraise, requestParam, success);
}

//@TODO
function getProductModelById(id) {

}

//@TODO
function getColumnListByProductModel(id) {

}

//@TODO
function getTenantList(param, limit, offset, callback) {
    var success = function (data) {
        PageVariable.productModelList = data;
        if (typeof callback == "function") {
            callback();
        }
    };
    var requestParam = {};
    requestParam.param = param;
    requestParam.limit = limit;
    requestParam.offset = offset;
    ajaxRequest(PageVariable.service.listProductModel, requestParam, success);
}


//demo
function getProductModelList(param, limit, offset, callback) {
    var success = function (data) {
        PageVariable.tenantList = data;
        if (typeof callback == "function") {
            callback();
        }
    };
    var requestParam = {};
    requestParam.param = param;
    requestParam.limit = limit;
    requestParam.offset = offset;
    ajaxRequest(PageVariable.service.listTenant, requestParam, success);
}

//@TODO
function getImageTextListByTenant(id, callback) {
    var success = function (data) {
        PageVariable.productModelList = data;
        if (typeof callback == "function") {
            callback();
        }
    };
    var requestParam = {};
    requestParam.tenantId = id;
    ajaxRequest(PageVariable.service.listTenantPanel, requestParam, success);
}

//@TODO
function getImageTextById(id) {

}

//@TODO
function getRecommendList(param, limit, offset, callback) {
    var success = function (data) {
        PageVariable.recommendList = data;
        if (typeof callback == "function") {
            callback();
        }
    };
    var requestParam = {};
    requestParam.param = param;
    requestParam.limit = limit;
    requestParam.offset = offset;
    ajaxRequest(PageVariable.service.listRecommend, requestParam, success);
}


