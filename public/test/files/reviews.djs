$BV.Internal.ajaxCallback(function(url,apiConfig){
if(!/(^|\.)(adidas\.com|adidas\.fr|bazaarvoice\.com)(:\d+)?$/.test(location.hostname)){
throw "Bazaarvoice: Permission denied";
}
$BV.Internal.configureAppLoader("rr",false,{"cmn/1576/analyticsInternalHooks":"analyticsHooks","cmn/1576/ratingControls":"ratingControls","cmn/1576redesnew/injection":"injection","rr/1576/contentDisplayRR":"rr/contentDisplayRR"});
$BV.analytics = $BV.analytics || {};
$BV.analytics.piiRegion = 'EU';
$BV.Internal.require(["rr/injection.rr","requester","feedback","domUtils","rr/analyticsInternalLegacyHooksRR","browserVersion","rr/analyticsHooksRR","rr/contentFocusingSupportRR","contentDisplay","jquery.core","dropdown","parseUri","cookies","analyticsVersioning","analyticsHooks","cmn/1576/selectReplacer","cmn/1576/analyticsInternalHooks","magpie","magpieTracking","analyticsAutoTagHooks","animationOptions","socialConnect","facebookConnect","facebookOpenGraph","jquery.effects.core","contentFocusingSupport"],function(Injection){
var materials={"BVRRRatingSummarySourceID":" <div class=\"BVRRRootElement\">\n <div class=\"BVRRRatingSummary BVRRPrimarySummary BVRRPrimaryRatingSummary\">\r\n<div class=\"BVRRRatingSummaryStyle2\"> \r\n\r\n<div class=\"BVRRRatingSummaryNoReviews\"> <div id=\"BVRRRatingSummaryNoReviewsWriteImageLinkID\" class=\"BVRRRatingSummaryLink BVRRRatingSummaryNoReviewsWriteImageLink\">\n<a data-bvjsref=\"http://adidas.ugc.bazaarvoice.com/1576-fr_fr/KDD46/writereview.djs?authsourcetype=__AUTHTYPE__&amp;campaignid=BV_RATING_SUMMARY_ZERO_REVIEWS&amp;format=embeddedhtml&amp;innerreturn=http%3A%2F%2Fadidas.ugc.bazaarvoice.com%2F1576-fr_fr%2FKDD46%2Freviews.djs%3Fformat%3Dembeddedhtml&amp;return=__RETURN__&amp;sessionparams=__BVSESSIONPARAMS__&amp;submissionparams=__BVSUBMISSIONPARAMETERS__&amp;submissionurl=__BVSUBMISSIONURL__&amp;user=__USERID__\" data-bvcfg=\"__CONFIGKEY__\" onclick=\"bvShowContentOnReturnPRR('1576-fr_fr', 'KDD46', 'BVRRWidgetID');\" name=\"BV_TrackingTag_Rating_Summary_1_WriteReview_KDD46\" href=\"javascript://\" title=\"écrire un avis\"> <img src=\"http://adidas.ugc.bazaarvoice.com/static/1576-fr_fr/translucent.gif\" alt=\"Écrire un avis\" />\n<\/a> <\/div>\n <div id=\"BVRRRatingSummaryLinkWriteFirstID\" class=\"BVRRRatingSummaryLink BVRRRatingSummaryLinkWriteFirst\">\n <span class=\"BVRRRatingSummaryLinkWriteFirstPrefix\"><\/span>\n<a data-bvjsref=\"http://adidas.ugc.bazaarvoice.com/1576-fr_fr/KDD46/writereview.djs?authsourcetype=__AUTHTYPE__&amp;campaignid=BV_RATING_SUMMARY_ZERO_REVIEWS&amp;format=embeddedhtml&amp;innerreturn=http%3A%2F%2Fadidas.ugc.bazaarvoice.com%2F1576-fr_fr%2FKDD46%2Freviews.djs%3Fformat%3Dembeddedhtml&amp;return=__RETURN__&amp;sessionparams=__BVSESSIONPARAMS__&amp;submissionparams=__BVSUBMISSIONPARAMETERS__&amp;submissionurl=__BVSUBMISSIONURL__&amp;user=__USERID__\" data-bvcfg=\"__CONFIGKEY__\" onclick=\"bvShowContentOnReturnPRR('1576-fr_fr', 'KDD46', 'BVRRWidgetID');\" name=\"BV_TrackingTag_Rating_Summary_1_WriteReview_KDD46\" href=\"javascript://\">Écrivez le premier avis<\/a><span class=\"BVRRRatingSummaryLinkWriteFirstSuffix\"><\/span> <\/div>\n<\/div><\/div> <\/div>\r\n<a data-bvjsref=\"http://adidas.ugc.bazaarvoice.com/1576-fr_fr/KDD46/writereview.djs?authsourcetype=__AUTHTYPE__&amp;campaignid=BV_SUBMISSIONLINK&amp;format=embeddedhtml&amp;innerreturn=http%3A%2F%2Fadidas.ugc.bazaarvoice.com%2F1576-fr_fr%2FKDD46%2Freviews.djs%3Fformat%3Dembeddedhtml&amp;return=__RETURN__&amp;sessionparams=__BVSESSIONPARAMS__&amp;submissionparams=__BVSUBMISSIONPARAMETERS__&amp;submissionurl=__BVSUBMISSIONURL__&amp;user=__USERID__\" data-bvcfg=\"__CONFIGKEY__\" onclick=\"bvShowContentOnReturnPRR('1576-fr_fr', 'KDD46', '');\" style=\"display: none;\" href=\"javascript://\" id=\"BVSubmissionLink\"><\/a>\n <\/div>\n","BVRRSecondaryRatingSummarySourceID":" <div class=\"BVRRRootElement\">\n<div class=\"BVRRRatingSummary BVRRSecondaryRatingSummary\">\n\n <div class=\"BVRRRatingSummary BVRRPrimaryRatingSummary\">\r\n<div class=\"BVRRRatingSummaryStyle2\"> \r\n\r\n<div class=\"BVRRRatingSummaryNoReviews\"> <div id=\"BVRRRatingSummaryNoReviewsWriteImageLinkID\" class=\"BVRRRatingSummaryLink BVRRRatingSummaryNoReviewsWriteImageLink\">\n<a data-bvjsref=\"http://adidas.ugc.bazaarvoice.com/1576-fr_fr/KDD46/writereview.djs?authsourcetype=__AUTHTYPE__&amp;campaignid=BV_RATING_SUMMARY_ZERO_REVIEWS&amp;format=embeddedhtml&amp;innerreturn=http%3A%2F%2Fadidas.ugc.bazaarvoice.com%2F1576-fr_fr%2FKDD46%2Freviews.djs%3Fformat%3Dembeddedhtml&amp;return=__RETURN__&amp;sessionparams=__BVSESSIONPARAMS__&amp;submissionparams=__BVSUBMISSIONPARAMETERS__&amp;submissionurl=__BVSUBMISSIONURL__&amp;user=__USERID__\" data-bvcfg=\"__CONFIGKEY__\" onclick=\"bvShowContentOnReturnPRR('1576-fr_fr', 'KDD46', 'BVRRWidgetID');\" name=\"BV_TrackingTag_Rating_Summary_2_WriteReview_KDD46\" href=\"javascript://\" title=\"écrire un avis\"> <img src=\"http://adidas.ugc.bazaarvoice.com/static/1576-fr_fr/translucent.gif\" alt=\"Écrire un avis\" />\n<\/a> <\/div>\n <div id=\"BVRRRatingSummaryLinkWriteFirstID\" class=\"BVRRRatingSummaryLink BVRRRatingSummaryLinkWriteFirst\">\n <span class=\"BVRRRatingSummaryLinkWriteFirstPrefix\"><\/span>\n<a data-bvjsref=\"http://adidas.ugc.bazaarvoice.com/1576-fr_fr/KDD46/writereview.djs?authsourcetype=__AUTHTYPE__&amp;campaignid=BV_RATING_SUMMARY_ZERO_REVIEWS&amp;format=embeddedhtml&amp;innerreturn=http%3A%2F%2Fadidas.ugc.bazaarvoice.com%2F1576-fr_fr%2FKDD46%2Freviews.djs%3Fformat%3Dembeddedhtml&amp;return=__RETURN__&amp;sessionparams=__BVSESSIONPARAMS__&amp;submissionparams=__BVSUBMISSIONPARAMETERS__&amp;submissionurl=__BVSUBMISSIONURL__&amp;user=__USERID__\" data-bvcfg=\"__CONFIGKEY__\" onclick=\"bvShowContentOnReturnPRR('1576-fr_fr', 'KDD46', 'BVRRWidgetID');\" name=\"BV_TrackingTag_Rating_Summary_2_WriteReview_KDD46\" href=\"javascript://\">Écrivez le premier avis<\/a><span class=\"BVRRRatingSummaryLinkWriteFirstSuffix\"><\/span> <\/div>\n<\/div><\/div> <\/div>\r\n<\/div> <\/div>\n","BVRRSourceID":" <div id=\"BVRRWidgetID\" class=\"BVRRRootElement BVRRWidget\">\n\n<div id=\"BVRRContentContainerID\" class=\"BVRRContainer\">\n\n\n\n\n\n\n<div id=\"BVRRDisplayContentID\" class=\"BVRRDisplayContent BVRRNoContent\"><div class=\"BVRRDisplayContentHeaderContent\"><div class=\"BVRRTitle BVRRDisplayContentTitle\">Avis clients<\/div><\/div>\n<div id=\"BVRRDisplayContentNoReviewsImageID\" class=\"BVRRDisplayContentNoReviewsImage\"><a data-bvjsref=\"http://adidas.ugc.bazaarvoice.com/1576-fr_fr/KDD46/writereview.djs?authsourcetype=__AUTHTYPE__&amp;campaignid=BV_REVIEW_DISPLAY_ZERO_REVIEWS&amp;format=embeddedhtml&amp;innerreturn=http%3A%2F%2Fadidas.ugc.bazaarvoice.com%2F1576-fr_fr%2FKDD46%2Freviews.djs%3Fformat%3Dembeddedhtml&amp;return=__RETURN__&amp;sessionparams=__BVSESSIONPARAMS__&amp;submissionparams=__BVSUBMISSIONPARAMETERS__&amp;submissionurl=__BVSUBMISSIONURL__&amp;user=__USERID__\" data-bvcfg=\"__CONFIGKEY__\" onclick=\"bvShowContentOnReturnPRR('1576-fr_fr', 'KDD46', '');\" name=\"BV_TrackingTag_Review_Display_WriteReview\" href=\"javascript://\" title=\"Écrivez le premier avis\"><img src=\"http://adidas.ugc.bazaarvoice.com/static/1576-fr_fr/translucent.gif\" alt=\"Écrivez le premier avis\" /><\/a><\/div>\n<div id=\"BVRRDisplayContentNoReviewsID\" class=\"BVRRDisplayContentNoReviews\"><a data-bvjsref=\"http://adidas.ugc.bazaarvoice.com/1576-fr_fr/KDD46/writereview.djs?authsourcetype=__AUTHTYPE__&amp;campaignid=BV_REVIEW_DISPLAY_ZERO_REVIEWS&amp;format=embeddedhtml&amp;innerreturn=http%3A%2F%2Fadidas.ugc.bazaarvoice.com%2F1576-fr_fr%2FKDD46%2Freviews.djs%3Fformat%3Dembeddedhtml&amp;return=__RETURN__&amp;sessionparams=__BVSESSIONPARAMS__&amp;submissionparams=__BVSUBMISSIONPARAMETERS__&amp;submissionurl=__BVSUBMISSIONURL__&amp;user=__USERID__\" data-bvcfg=\"__CONFIGKEY__\" onclick=\"bvShowContentOnReturnPRR('1576-fr_fr', 'KDD46', '');\" name=\"BV_TrackingTag_Review_Display_WriteReview\" href=\"javascript://\" title=\"Écrivez le premier avis\">Écrivez le premier avis<\/a> <ul id=\"BVSEO_meta\" style=\"display:none!important\">\n <li data-bvseo=\"bvDateModified\">2016-08-11 T07:51:07.364-05:00<\/li>\n <li data-bvseo=\"ps\">bvseo_pps, prod_bvrr, vn_prr_5.6<\/li>\n <li data-bvseo=\"cp\">cp-1, bvpage1<\/li>\n <li data-bvseo=\"co\">co_noreviews, tv_0, tr_0<\/li>\n <li data-bvseo=\"cf\">loc_en_US, sid_KDD46, prod, sort_default<\/li>\n <\/ul>\n<\/div><\/div>\n<div id=\"BVRRFilteringBusyOverlayHighlightID\" class=\"BVDI_FBOverlayHighlight BVDIOverlay BVDIHidden\"><div class=\"BVDI_FBImage\"><img src=\"http://adidas.ugc.bazaarvoice.com/static/1576-fr_fr/filteringBusy.gif\" alt=\"Filtrage en cours. Veuillez attendre qu\u2019il soit terminé.\" title=\"Filtrage en cours. Veuillez attendre qu\u2019il soit terminé.\"/><\/div><\/div><\/div>\n <\/div>\n"},
initializers={"BVRRRatingSummarySourceID":[{"init":"bindJsLinks","data":{},"module":"requester"}],"BVRRSecondaryRatingSummarySourceID":[{"init":"bindJsLinks","data":{},"module":"requester"}],"BVRRSourceID":[{"init":"bindJsLinks","data":{},"module":"requester"}]},
widgets={};
widgets["content"]={"sourceId":"BVRRSourceID","handledContentTypes":["Review","Comment"],"containerId":"BVRRContainer"};
widgets["secondarySummary"]={"sourceId":"BVRRSecondaryRatingSummarySourceID","containerId":"BVRRSecondarySummaryContainer"};
widgets["summary"]={"sourceId":"BVRRRatingSummarySourceID","containerId":"BVRRSummaryContainer"};
var injectionData={
apiConfig:apiConfig,
bvstateInfo:"p/KDD46",
canonicalTags:false,
containerInitializer:false,
cookiePath:"/",
crossDomainUrl:"http://adidas.ugc.bazaarvoice.com/1576-fr_fr/crossdomain.htm?format=embedded",
embeddedUrl:url,
globalInitializers:[{"module":"browserVersion","init":"initialize","data":{"useBodyTag":false,"containerId":"BVRRSummaryContainer"}},{"module":"browserVersion","init":"initialize","data":{"useBodyTag":false,"containerId":"BVRRSecondarySummaryContainer"}},{"module":"browserVersion","init":"initialize","data":{"useBodyTag":false,"containerId":"BVRRContainer"}},{"module":"dropdown","init":"addSelectHandlers","data":{"dropdownsName":"BV_TrackingTag_Review_Display_Sort"}},{"module":"feedback","init":"onInjection","data":{"options":{"cookiePrefixes":{"Voting":"pfv"},"contentFocusing":{"args":["1576-fr_fr","KDD46"],"fn":"bvShowContentOnReturnPRR"},"cookiePath":"/"},"id":"Product_a6qyh221m73ytc7kmiarmwngq"}},{"module":"feedback","init":"onInjection","data":{"options":{"cookiePrefixes":{"Voting":"rfv","Inappropriate":"rif"},"contentFocusing":{"args":["1576-fr_fr","KDD46"],"fn":"bvShowContentOnReturnPRR"},"cookiePath":"/"},"id":"Review_a6qyh221m73ytc7kmiarmwngq"}},{"module":"feedback","init":"onInjection","data":{"options":{"cookiePrefixes":{"Voting":"cfv","Inappropriate":"cif"},"contentFocusing":{"args":["1576-fr_fr","KDD46"],"fn":"bvShowContentOnReturnPRR"},"cookiePath":"/"},"id":"ReviewComment_a6qyh221m73ytc7kmiarmwngq"}},{"module":"rr/contentFocusingSupportRR","init":"postInjection","data":{"application":"PRR","defaultContentContainerId":"BVRRContainer","displayCode":"1576-fr_fr","tabSwitcher":"bvShowTab","source":"readLink"}}],
gotoCookieRegexp:/^https?:\/\/[^/?#]+(\/[^?#]*)\//,
inFrameSubmissionEnabled:false,
pageIdPrefix:"BVRR",
pageTrackers:["http://adidas.ugc.bazaarvoice.com/static/1576-fr_fr/r_0_ispacer.gif"],
postInjectionFunction:function(Inject){
window.bvScrollToElement();
},
productId:"KDD46",
replaceDisplayTokens:true,
replacementsPrefix:"BVRR",
replaceSessionParameters:false,
returnURLFixedValue:"",
returnURLForceRelativeToRoot:true,
setWindowTitle:false,
soiContainerID:"BVRRContentValidationID_KDD46",
soiContentIDs:[],
sviParameterName:"bvrrp",
sviRedirectBaseUrl:"http://adidas.ugc.bazaarvoice.com/1576-fr_fr/",
webAnalyticsConfig:{"customTrackedObjectsSelector":"","jsonData":{"bvDisplayCode":"1576-fr_fr","autoTagAnalyticsConfiguration":{"trackSubmissionPageLoads":true,"trackFormActions":false,"autoTagAnalyticsVersion":"4.9","vendors":[{"vendorName":"coremetrics","signature":"pageCategorySearch"},{"vendorName":"magpie","anonymous":false,"brandDomain":"adidas.fr","defaultClassesOnly":false}],"productTracking":{"tracking":true,"initialProductDisplay":false}},"productId":"KDD46","eType":"Read","subjectType":"Product","bvAnalyticsVersion":"4.8","rootCategoryId":"men","analyticsWhitespaceTrackingEnabled":false,"bvProduct":"RatingsAndReviews","attributes":{"numReviews":0,"avgRating":0E-12,"numRatingsOnlyReviews":0,"percentRecommend":0},"ciTrackingEnabled":false,"bvClientName":"AdidasGlobal","brand":"Adidas Originals","leafCategoryId":"men-Shoes-Originals","bvExtension":{}},"customizersName":"BVRRAnalyticsCustomizers","SIWZeroDeployEnabled":false,"conversionTracking":{"conversionTrackingElementSelector":null,"conversionTrackingMetadataSelector":null,"conversionTrackingParseRegexp":null,"conversionTrackingName":"AddToCart"},"maxTrackingTagTraversalDepth":3,"customContainersFnName":"BVRRAnalyticsCustomContainers","customTrackedObjects":""},
widgetInitializers:initializers,
widgetLimit:1,
widgetMaterials:materials,
widgetMetadata:widgets,
windowTitle:null};
Injection.newInstance().apiInjection(injectionData);
});
});