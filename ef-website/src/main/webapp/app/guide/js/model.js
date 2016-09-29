var PageVariable = {
    template: {
        homeRecommendList: "home-recommend-list",
        tenantBase: "tenant-base",
        tenantPraise: "tenant-praise",
        tenantProductList: "tenant-product-list",
        tenantPanelList: "tenant-panel-list",
        productBase: "product-base",
        productDetail: "product-detail",
        productBuy: "product-buy",
        productList: "product-list",
        tenantList: "tenant-list",
        tenantAudioList: "tenant-audio-list"
    },
    service: {
        login: "/wx/login",
        listProductModel: "/product/getProductModelList",
        listTenant: "/tenant/getTenantList",
        listRecommend: "/tenant/getRecommendList",
        viewTenantById: "/tenant/getTenantById",
        listTenantPraise: "/tenant/getTenantPraiseListByTenant",
        listTenantPanel: "/tenant/getImageTextListByTenant",
        viewProductModelById: "/product/getProductModelById",
        listProductModelPanel: "/product/getColumnListByProductModel"
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

    imageStyle: {},

    currentAudio: null,

    audioList: [],

    setCurrentAudio: function (audio) {
        if (PageVariable.currentAudio != null) {
            PageVariable.currentAudio.bodyStop();
        }
        PageVariable.currentAudio = audio;
        PageVariable.currentAudio.bodyPlay();
    },

    removeCurrentAudio: function (audio) {
        if (PageVariable.currentAudio == null) {
            audio.bodyStop();
        } else if (audio.id == PageVariable.currentAudio.id) {
            PageVariable.currentAudio.bodyStop();
            PageVariable.currentAudio = null;
        }
    }
};

//@TODO
function getTenantById(id, callback) {
    var success = function (data) {
        PageVariable.tenant = data;
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
        PageVariable.tenantPraiseList = data;
        if (typeof callback == "function") {
            callback();
        }
    };
    var requestParam = {};
    requestParam.id = id;
    ajaxRequest(PageVariable.service.listTenantPraise, requestParam, success);
}

//@TODO
function getProductModelById(id, callback) {
    var success = function (data) {
        PageVariable.productModel = data;
        if (typeof callback == "function") {
            callback();
        }
    };
    var requestParam = {};
    requestParam.id = id;
    ajaxRequest(PageVariable.service.viewProductModelById, requestParam, success);
}

//@TODO
function getColumnListByProductModel(id, callback) {
    var success = function (data) {
        PageVariable.productModelColumnList = data;
        if (typeof callback == "function") {
            callback();
        }
    };
    var requestParam = {};
    requestParam.id = id;
    ajaxRequest(PageVariable.service.listProductModelPanel, requestParam, success);
}

//@TODO
function getTenantList(param, limit, offset, callback) {
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


//demo
function getProductModelList(param, limit, offset, callback) {
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

//@TODO
function getImageTextListByTenant(id, callback) {
    var success = function (data) {
        PageVariable.imageTextList = data;
        if (typeof callback == "function") {
            callback();
        }
    };
    var requestParam = {};
    requestParam.id = id;
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


