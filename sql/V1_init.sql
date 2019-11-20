
-- ----------------------------
-- Table structure for gateway_app_key
-- ----------------------------
DROP TABLE IF EXISTS `gateway_app_key`;
CREATE TABLE `gateway_app_key`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `app_key_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该表逻辑主键',
  `app_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'key名称',
  `app_key_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'key描述',
  `app_key_enabled` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否启用 Y-启用 N-禁用',
  `app_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '使用的key',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_key_id`(`app_key_id`) USING BTREE,
  UNIQUE INDEX `app_key`(`app_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway_app_key
-- ----------------------------
INSERT INTO `gateway_app_key` VALUES (1, 'AppKeyId_550758559327977472', '接入方示例', '接入方示例，可参考此处进行配置', 'Y', '2CUmp905X2VoLRY5fMbT1Rvzvin69K1d', '2019-02-28 19:17:53', '2019-02-28 19:17:53');

-- ----------------------------
-- Table structure for gateway_app_plugin
-- ----------------------------
DROP TABLE IF EXISTS `gateway_app_plugin`;
CREATE TABLE `gateway_app_plugin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `app_key_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'app_key表逻辑主键',
  `plugin_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该表逻辑主键',
  `plugin_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '插件名称',
  `plugin_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '插件类型',
  `plugin_param` json NULL COMMENT '插件参数,json类型',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `plugin_id`(`plugin_id`) USING BTREE,
  INDEX `app_key_id`(`app_key_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway_app_plugin
-- ----------------------------
INSERT INTO `gateway_app_plugin` VALUES (1, 'AppKeyId_525278155930337280', 'Plugin_525278155955503104', '访问API限流插件', 'RateLimitRequestPlugin', '{\"enabled\": \"N\"}', '2018-12-20 11:47:52', '2018-12-24 19:05:01');
INSERT INTO `gateway_app_plugin` VALUES (2, 'AppKeyId_525278155930337280', 'Plugin_525278156005834752', '访问API总流量限制插件', 'QuotaRequestPlugin', '{\"maxRequest\": -1}', '2018-12-20 11:47:52', '2018-12-24 19:05:01');
INSERT INTO `gateway_app_plugin` VALUES (3, 'AppKeyId_525278155930337280', 'Plugin_525278156022611968', '访问权限插件', 'AccessControlRequestPlugin', '{\"accessServices\": {}}', '2018-12-20 11:47:52', '2018-12-24 19:05:01');
INSERT INTO `gateway_app_plugin` VALUES (4, 'AppKeyId_526808682374103040', 'Plugin_526808682374103041', '访问API限流插件', 'RateLimitRequestPlugin', '{\"enabled\": \"N\"}', '2018-12-24 17:09:38', NULL);
INSERT INTO `gateway_app_plugin` VALUES (5, 'AppKeyId_526808682374103040', 'Plugin_526808682416046080', '访问API总流量限制插件', 'QuotaRequestPlugin', '{\"maxRequest\": -1}', '2018-12-24 17:09:38', NULL);
INSERT INTO `gateway_app_plugin` VALUES (6, 'AppKeyId_526808682374103040', 'Plugin_526808682437017600', '访问权限插件', 'AccessControlRequestPlugin', '{\"accessServices\": {}}', '2018-12-24 17:09:38', NULL);
INSERT INTO `gateway_app_plugin` VALUES (7, 'AppKeyId_527136128835256320', 'Plugin_527136128835256321', '访问API限流插件', 'RateLimitRequestPlugin', '{\"enabled\": \"N\"}', '2018-12-25 14:50:47', '2018-12-25 16:10:33');
INSERT INTO `gateway_app_plugin` VALUES (8, 'AppKeyId_527136128835256320', 'Plugin_527136128835256322', '访问API总流量限制插件', 'QuotaRequestPlugin', '{\"maxRequest\": -1}', '2018-12-25 14:50:47', '2018-12-25 16:10:33');
INSERT INTO `gateway_app_plugin` VALUES (9, 'AppKeyId_527136128835256320', 'Plugin_527136128835256323', '访问权限插件', 'AccessControlRequestPlugin', '{\"accessServices\": {}}', '2018-12-25 14:50:47', '2018-12-25 16:10:33');
INSERT INTO `gateway_app_plugin` VALUES (10, 'AppKeyId_532523146318708736', 'Plugin_532523146318708737', '访问API限流插件', 'RateLimitRequestPlugin', '{\"enabled\": \"N\"}', '2019-01-09 11:36:52', NULL);
INSERT INTO `gateway_app_plugin` VALUES (11, 'AppKeyId_532523146318708736', 'Plugin_532523146348068864', '访问API总流量限制插件', 'QuotaRequestPlugin', '{\"maxRequest\": -1}', '2019-01-09 11:36:52', NULL);
INSERT INTO `gateway_app_plugin` VALUES (12, 'AppKeyId_532523146318708736', 'Plugin_532523146373234688', '访问权限插件', 'AccessControlRequestPlugin', '{\"accessServices\": {}}', '2019-01-09 11:36:52', NULL);
INSERT INTO `gateway_app_plugin` VALUES (13, 'AppKeyId_533226547604094976', 'Plugin_533226547604094977', '访问API限流插件', 'RateLimitRequestPlugin', '{\"enabled\": \"N\"}', '2019-01-11 10:11:56', NULL);
INSERT INTO `gateway_app_plugin` VALUES (14, 'AppKeyId_533226547604094976', 'Plugin_533226547637649408', '访问API总流量限制插件', 'QuotaRequestPlugin', '{\"maxRequest\": -1}', '2019-01-11 10:11:56', NULL);
INSERT INTO `gateway_app_plugin` VALUES (15, 'AppKeyId_533226547604094976', 'Plugin_533226547662815232', '访问权限插件', 'AccessControlRequestPlugin', '{\"accessServices\": {}}', '2019-01-11 10:11:56', NULL);
INSERT INTO `gateway_app_plugin` VALUES (16, 'AppKeyId_534698725885345792', 'Plugin_534698725885345793', '访问API限流插件', 'RateLimitRequestPlugin', '{\"enabled\": \"N\"}', '2019-01-15 11:41:50', '2019-01-15 11:42:32');
INSERT INTO `gateway_app_plugin` VALUES (17, 'AppKeyId_534698725885345792', 'Plugin_534698725923094528', '访问API总流量限制插件', 'QuotaRequestPlugin', '{\"maxRequest\": -1}', '2019-01-15 11:41:50', '2019-01-15 11:42:32');
INSERT INTO `gateway_app_plugin` VALUES (18, 'AppKeyId_534698725885345792', 'Plugin_534698725944066048', '访问权限插件', 'AccessControlRequestPlugin', '{\"accessServices\": {\"service_524246314343464960\": \"/housingloan\"}}', '2019-01-15 11:41:51', '2019-01-15 11:42:32');
INSERT INTO `gateway_app_plugin` VALUES (19, 'AppKeyId_536925575307067392', 'Plugin_536925575311261696', '访问API限流插件', 'RateLimitRequestPlugin', '{\"enabled\": \"N\"}', '2019-01-21 15:10:33', '2019-01-21 15:10:54');
INSERT INTO `gateway_app_plugin` VALUES (20, 'AppKeyId_536925575307067392', 'Plugin_536925575344816128', '访问API总流量限制插件', 'QuotaRequestPlugin', '{\"maxRequest\": -1}', '2019-01-21 15:10:33', '2019-01-21 15:10:54');
INSERT INTO `gateway_app_plugin` VALUES (21, 'AppKeyId_536925575307067392', 'Plugin_536925575369981952', '访问权限插件', 'AccessControlRequestPlugin', '{\"accessServices\": {}}', '2019-01-21 15:10:33', '2019-01-21 15:10:54');
INSERT INTO `gateway_app_plugin` VALUES (22, 'AppKeyId_550758559327977472', 'Plugin_550758559575441408', '访问API限流插件', 'RateLimitRequestPlugin', '{\"rate\": 100, \"enabled\": \"Y\", \"perSeconds\": 10}', '2019-02-28 19:17:53', '2019-02-28 19:17:53');
INSERT INTO `gateway_app_plugin` VALUES (23, 'AppKeyId_550758559327977472', 'Plugin_550758559881625600', '访问API总流量限制插件', 'QuotaRequestPlugin', '{\"interval\": 1, \"timeUtil\": 3, \"maxRequest\": 36000}', '2019-02-28 19:17:53', '2019-02-28 19:17:53');
INSERT INTO `gateway_app_plugin` VALUES (24, 'AppKeyId_550758559327977472', 'Plugin_550758560011649024', '访问权限插件', 'AccessControlRequestPlugin', '{\"accessServices\": {\"service_549949827350263445\": \"/demo-order-service-jwt-auth\", \"service_549949827350265856\": \"/demo-order-service\", \"service_54994982735025676575\": \"/demo-order-service-uus-oauth2\", \"service_5499498273502567854556\": \"/demo-order-service-spring-cloud\"}}', '2019-02-28 19:17:53', '2019-02-28 19:17:53');
INSERT INTO `gateway_app_plugin` VALUES (25, 'AppKeyId_555388985732497408', 'Plugin_555388986470694912', '访问API限流插件', 'RateLimitRequestPlugin', '{\"enabled\": \"N\"}', '2019-03-13 13:57:33', '2018-12-24 19:05:01');
INSERT INTO `gateway_app_plugin` VALUES (26, 'AppKeyId_555388985732497408', 'Plugin_555388986529415168', '访问API总流量限制插件', 'QuotaRequestPlugin', '{\"maxRequest\": -1}', '2019-03-13 13:57:33', '2018-12-24 19:05:01');
INSERT INTO `gateway_app_plugin` VALUES (27, 'AppKeyId_555388985732497408', 'Plugin_555388986541998080', '访问权限插件', 'AccessControlRequestPlugin', '{\"accessServices\": {}}', '2019-03-13 13:57:33', '2018-12-24 19:05:01');
INSERT INTO `gateway_app_plugin` VALUES (28, 'AppKeyId_555388993659731968', 'Plugin_555388993689092096', '访问API限流插件', 'RateLimitRequestPlugin', '{\"enabled\": \"N\"}', '2019-03-13 13:57:35', '2018-12-24 19:05:01');
INSERT INTO `gateway_app_plugin` VALUES (29, 'AppKeyId_555388993659731968', 'Plugin_555388993697480704', '访问API总流量限制插件', 'QuotaRequestPlugin', '{\"maxRequest\": -1}', '2019-03-13 13:57:35', '2018-12-24 19:05:01');
INSERT INTO `gateway_app_plugin` VALUES (30, 'AppKeyId_555388993659731968', 'Plugin_555388993710063616', '访问权限插件', 'AccessControlRequestPlugin', '{\"accessServices\": {}}', '2019-03-13 13:57:35', '2018-12-24 19:05:01');
INSERT INTO `gateway_app_plugin` VALUES (31, 'AppKeyId_555389025653882880', 'Plugin_555389025670660096', '访问API限流插件', 'RateLimitRequestPlugin', '{\"enabled\": \"N\"}', '2019-03-13 13:57:42', '2019-03-13 13:57:42');
INSERT INTO `gateway_app_plugin` VALUES (32, 'AppKeyId_555389025653882880', 'Plugin_555389025683243008', '访问API总流量限制插件', 'QuotaRequestPlugin', '{\"maxRequest\": -1}', '2019-03-13 13:57:42', '2019-03-13 13:57:42');
INSERT INTO `gateway_app_plugin` VALUES (33, 'AppKeyId_555389025653882880', 'Plugin_555389025691631616', '访问权限插件', 'AccessControlRequestPlugin', '{\"accessServices\": {}}', '2019-03-13 13:57:42', '2019-03-13 13:57:42');
INSERT INTO `gateway_app_plugin` VALUES (37, 'AppKeyId_562604411822538752', 'Plugin_562635486313578498', '访问权限插件', 'AccessControlRequestPlugin', '{\"accessServices\": {\"service_562603108195106816\": \"/esign\"}}', '2019-04-02 13:52:33', '2019-04-02 13:52:33');

-- ----------------------------
-- Table structure for gateway_cache_refresh
-- ----------------------------
DROP TABLE IF EXISTS `gateway_cache_refresh`;
CREATE TABLE `gateway_cache_refresh`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cache_modify_date` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway_cache_refresh
-- ----------------------------
INSERT INTO `gateway_cache_refresh` VALUES (1, '2019-04-13 10:12:34');

-- ----------------------------
-- Table structure for gateway_endpoint
-- ----------------------------
DROP TABLE IF EXISTS `gateway_endpoint`;
CREATE TABLE `gateway_endpoint`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `service_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'api逻辑主键',
  `endpoint_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该表逻辑主键',
  `endpoint_method` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'http请求类型',
  `endpoint_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '对外暴露的请求路径，且默认也是转发到后端的url',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `endpoint_id`(`endpoint_id`) USING BTREE,
  UNIQUE INDEX `endpoint_id_url_method`(`service_id`, `endpoint_method`, `endpoint_url`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 785 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway_endpoint
-- ----------------------------
INSERT INTO `gateway_endpoint` VALUES (291, 'service_54994982735025676575', 'endpoint_550260247747362816', 'ALL', '/**', '2019-02-27 10:17:46', '2019-02-27 10:17:46');
INSERT INTO `gateway_endpoint` VALUES (376, 'service_549949827350263445', 'endpoint_550646086943899648', 'ALL', '/**', '2019-02-28 11:50:58', '2019-02-28 11:50:58');
INSERT INTO `gateway_endpoint` VALUES (377, 'service_549949827350263445', 'endpoint_550646086943899649', 'ALL', '/noauth/*', '2019-02-28 11:50:58', '2019-02-28 11:50:58');
INSERT INTO `gateway_endpoint` VALUES (770, 'service_549949827350265856', 'endpoint_565606276625596416', 'ALL', '/**', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint` VALUES (771, 'service_549949827350265856', 'endpoint_565606276625596417', 'ALL', '/accesstoken/queryName', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint` VALUES (772, 'service_549949827350265856', 'endpoint_565606276629790720', 'ALL', '/cache/queryOrder', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint` VALUES (773, 'service_549949827350265856', 'endpoint_565606276629790721', 'ALL', '/changeurl/*', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint` VALUES (774, 'service_549949827350265856', 'endpoint_565606276629790722', 'ALL', '/groovy/queryName', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint` VALUES (775, 'service_549949827350265856', 'endpoint_565606276629790723', 'ALL', '/jar/queryName', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint` VALUES (776, 'service_549949827350265856', 'endpoint_565606276629790724', 'ALL', '/queryHeader', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint` VALUES (777, 'service_549949827350265856', 'endpoint_565606276629790725', 'ALL', '/queryMerge', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint` VALUES (778, 'service_549949827350265856', 'endpoint_565606276629790726', 'ALL', '/queryMerge2', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint` VALUES (779, 'service_549949827350265856', 'endpoint_565606276629790727', 'ALL', '/signVerify/queryName', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint` VALUES (780, 'service_549949827350265856', 'endpoint_565606276629790728', 'POST', '/mock/queryName', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint` VALUES (782, 'service_test_dubbo', 'endpoint_565606810690519040', 'ALL', '/hello', '2019-04-10 10:39:32', '2019-04-10 10:39:32');
INSERT INTO `gateway_endpoint` VALUES (783, 'service_5499498273502567854556', 'endpoint_565991436512657408', 'ALL', '/**', '2019-04-11 12:07:54', '2019-04-11 12:07:54');

-- ----------------------------
-- Table structure for gateway_endpoint_plugin
-- ----------------------------
DROP TABLE IF EXISTS `gateway_endpoint_plugin`;
CREATE TABLE `gateway_endpoint_plugin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `endpoint_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'endpoint逻辑主键',
  `plugin_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该表逻辑主键',
  `plugin_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '插件名称',
  `plugin_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '插件类型',
  `plugin_param` json NULL COMMENT '插件参数,json类型',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `plugin_id`(`plugin_id`) USING BTREE,
  UNIQUE INDEX `plugin_id_type`(`endpoint_id`, `plugin_type`) USING BTREE,
  INDEX `endpoint_id`(`endpoint_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 883 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway_endpoint_plugin
-- ----------------------------
INSERT INTO `gateway_endpoint_plugin` VALUES (2, 'service_test_dubbo_endpoint', 'service_test_dubbo_endpoint_method_transform', 'Rpc路由插件', 'RpcRoutingRequestPlugin', '{\"rpcType\": \"dubbo\", \"rpcParamJson\": \"{\\\"dubboParamTemplate\\\":\\\"[{\\\\\\\"type\\\\\\\":\\\\\\\"io.github.tesla.dubbo.pojo.UserRequest\\\\\\\",\\\\\\\"expression\\\\\\\":\\\\\\\"${jsonStr}\\\\\\\"}]\\\",\\\"group\\\":\\\"tesla\\\",\\\"methodName\\\":\\\"sayHello\\\",\\\"serviceName\\\":\\\"io.github.tesla.dubbo.user.UserService\\\",\\\"version\\\":\\\"1.0.0\\\"}\"}', '2018-12-17 14:34:36', '2018-12-17 14:34:36');
INSERT INTO `gateway_endpoint_plugin` VALUES (354, 'endpoint_550646086943899649', 'endpointPlugin_550646086960676864', '消除访问权限校验插件', 'IgnoreAuthRequestPlugin', NULL, '2019-02-28 11:50:58', '2019-02-28 11:50:58');
INSERT INTO `gateway_endpoint_plugin` VALUES (355, 'endpoint_550646086943899649', 'endpointPlugin_550646086964871168', 'path转换插件', 'PathTransformRequestPlugin', '{\"patternPath\": \"/#{1}\", \"servicePrefix\": \"/demo-order-service-jwt-auth\", \"transformPath\": \"/noauth/*\"}', '2019-02-28 11:50:58', '2019-02-28 11:50:58');
INSERT INTO `gateway_endpoint_plugin` VALUES (748, 'endpoint_562706330125598726_111', 'endpointPlugin_562706331903983616', 'groovy脚本执行插件', 'GroovyExecuteResponsePlugin', '{\"groovyScript\": \"package io.github.tesla.filter.endpoint.plugin.response.user;\\n\\nimport io.github.tesla.filter.endpoint.plugin.response.GroovyExecuteResponsePlugin;\\nimport io.github.tesla.filter.support.servlet.NettyHttpServletRequest;\\nimport io.netty.handler.codec.http.HttpResponse;\\n\\n/**\\n * @Auther: zhipingzhang\\n * @Date: 2018/10/29 11:21:\\n * @Description: 需要自己编写的入请求过滤器代码，\\n * 当前demo的类路径为 io.github.tesla.filter.plugin.request.user\\n * 类名 UserGroovyResponsePlugin 尽量命令为和过滤器规则相符合的名称\\n * <p>\\n */\\npublic class UserGroovyResponsePlugin extends GroovyExecuteResponsePlugin {\\n\\n  /**\\n   * 功能描述: 具体的过滤规则代码\\n   *\\n   * @parmname: doFilter\\n   * @param: [servletRequest, realHttpObject]\\n   * @return: io.netty.handler.codec.http.HttpResponse\\n   * 实现具体filter规则，返回了response\\n   * @auther: zhipingzhang\\n   * @date: 2018/10/29 11:24\\n   */\\n  @Override\\n  public HttpResponse doFilter(NettyHttpServletRequest servletRequest, HttpResponse httpResponse) {\\n    System.out.println(\\\"i\'m groovy responseFilter\\\");\\n    return httpResponse;\\n  }\\n}\\n\"}', '2019-04-02 18:34:04', '2019-04-03 17:06:29');
INSERT INTO `gateway_endpoint_plugin` VALUES (866, 'endpoint_565606276625596417', 'endpointPlugin_565606276860477440', 'path转换插件', 'PathTransformRequestPlugin', '{\"patternPath\": \"/queryName\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/accesstoken/queryName\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (867, 'endpoint_565606276625596417', 'endpointPlugin_565606277028249600', 'accessToken校验插件', 'AccessTokenRequestPlugin', '{\"tokenHeaderKey\": \"X-BK-AccessToken\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (868, 'endpoint_565606276629790720', 'endpointPlugin_565606277158273024', 'path转换插件', 'PathTransformRequestPlugin', '{\"patternPath\": \"/queryOrder\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/cache/queryOrder\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (869, 'endpoint_565606276629790720', 'endpointPlugin_565606277321850880', '缓存结果插件', 'CacheResultPlugin', '{\"expireSecond\": \"60\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (870, 'endpoint_565606276629790721', 'endpointPlugin_565606277464457216', 'path转换插件', 'PathTransformRequestPlugin', '{\"patternPath\": \"/#{1}\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/changeurl/*\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (871, 'endpoint_565606276629790722', 'endpointPlugin_565606277590286336', 'path转换插件', 'PathTransformRequestPlugin', '{\"patternPath\": \"/queryName\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/groovy/queryName\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (872, 'endpoint_565606276629790722', 'endpointPlugin_565606277812584448', 'groovy脚本执行插件', 'GroovyExecuteResponsePlugin', '{\"groovyScript\": \"package io.github.tesla.filter.endpoint.plugin.response.user;\\n\\nimport io.github.tesla.filter.endpoint.plugin.response.GroovyExecuteResponsePlugin;\\nimport io.github.tesla.filter.support.servlet.NettyHttpServletRequest;\\nimport io.netty.handler.codec.http.HttpResponse;\\n\\n\\npublic class UserGroovyResponsePlugin extends GroovyExecuteResponsePlugin {\\n\\n  @Override\\n  public HttpResponse doFilter(NettyHttpServletRequest servletRequest, HttpResponse httpResponse) {\\n    System.out.println(\\\"i\'m groovy responseFilter\\\");\\n    return httpResponse;\\n  }\\n}\\n\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (873, 'endpoint_565606276629790723', 'endpointPlugin_565606277967773696', 'path转换插件', 'PathTransformRequestPlugin', '{\"patternPath\": \"/queryName\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/jar/queryName\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (874, 'endpoint_565606276629790723', 'endpointPlugin_565606278093602816', '执行上传Jar包插件', 'JarExecuteResponsePlugin', '{\"fileId\": \"file_550715420345106439\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (875, 'endpoint_565606276629790724', 'endpointPlugin_565606278227820544', 'groovy脚本执行插件', 'GroovyExecuteRequestPlugin', '{\"groovyScript\": \"package io.github.tesla.filter.endpoint.plugin.request.user;\\n\\nimport io.github.tesla.auth.sdk.signer.Header;\\nimport io.github.tesla.filter.endpoint.plugin.request.GroovyExecuteRequestPlugin;\\nimport io.github.tesla.filter.support.servlet.NettyHttpServletRequest;\\nimport io.github.tesla.filter.utils.JsonUtils;\\nimport io.netty.handler.codec.http.FullHttpRequest;\\nimport io.netty.handler.codec.http.HttpObject;\\nimport io.netty.handler.codec.http.HttpResponse;\\nimport java.util.ArrayList;\\nimport java.util.List;\\nimport java.util.Map;\\n\\npublic class UserGroovyRequestPlugin extends GroovyExecuteRequestPlugin {\\n\\n    @Override\\n    public HttpResponse doFilter(NettyHttpServletRequest servletRequest, HttpObject realHttpObject) {\\n        try {\\n            FullHttpRequest realRequest = (FullHttpRequest) realHttpObject;\\n            if (realRequest.headers().get(\\\"X-Real-Ip\\\") != null) {\\n                realRequest.headers().set(\\\"X-User-Ip\\\", realRequest.headers().get(\\\"X-Real-Ip\\\"));\\n            }\\n            List<Header> headers = buildHeaders(realRequest);\\n            LOGGER.info(\\\"request url: {} , headers: {}\\\", servletRequest.getRequestURI(), JsonUtils\\n                    .serializeToJson(headers));\\n        } catch (Exception e) {\\n            LOGGER.error(e.getMessage(), e);\\n        }\\n        return null;\\n    }\\n\\n    private List<Header> buildHeaders(FullHttpRequest servletRequest) {\\n        List<Header> headers = new ArrayList<>();\\n        for (Map.Entry<String, String> header : servletRequest.headers()) {\\n            headers.add(new Header(header.getKey(), header.getValue()));\\n        }\\n        return headers;\\n    }\\n}\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (876, 'endpoint_565606276629790725', 'endpointPlugin_565606278370426880', '查询聚合插件', 'QueryConvergeRequestPlugin', '{\"routerList\": [{\"serviceId\": \"service_549949827350265856\", \"convergeTag\": \"\", \"patternPath\": \"/order-service/queryName\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/queryMerge\"}, {\"serviceId\": \"service_549949827350265856\", \"convergeTag\": \"\", \"patternPath\": \"/order-service/queryProvinces\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/queryMerge\"}, {\"serviceId\": \"service_549949827350265856\", \"convergeTag\": \"\", \"patternPath\": \"/order-service/queryOrder\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/queryMerge\"}]}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (877, 'endpoint_565606276629790726', 'endpointPlugin_565606278563364864', '查询聚合插件', 'QueryConvergeRequestPlugin', '{\"routerList\": [{\"serviceId\": \"service_549949827350265856\", \"convergeTag\": \"\", \"patternPath\": \"/order-service/queryName?cusid=#{idv1}\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/queryMerge2\"}, {\"serviceId\": \"service_549949827350265856\", \"convergeTag\": \"\", \"patternPath\": \"/order-service/queryProvinces?cusid=#{idv1}\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/queryMerge2\"}, {\"serviceId\": \"service_549949827350265856\", \"convergeTag\": \"\", \"patternPath\": \"/order-service/queryOrder?cusid=#{idv1}\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/queryMerge2\"}]}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (878, 'endpoint_565606276629790727', 'endpointPlugin_565606278680805376', 'path转换插件', 'PathTransformRequestPlugin', '{\"patternPath\": \"/queryName\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/signVerify/queryName\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (879, 'endpoint_565606276629790727', 'endpointPlugin_565606278802440192', '签名校验插件', 'SignatureVerifyRequestPlugin', '{\"signAccessKey\": \"eyJhbGciOiJIUzI1NiIsIngtc3MiOjEy\", \"signHeaderKey\": \"X-BK-Signature\", \"signSecretKey\": \"EyMDkzMyIsImlzcyI6IlRhby1ZYW5nIi\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (880, 'endpoint_565606276629790728', 'endpointPlugin_565606278932463616', 'mock插件', 'MockRequestPlugin', '{\"enable\": \"Y\", \"resultTemplate\": \"<#-- 下面为转换模板demo，freemarker脚本，body即为整个requestBody -->\\n{\\n    \\\"code\\\": 200,\\n    \\\"name\\\": \\\"${body.desc}\\\"\\n}\\n\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (881, 'endpoint_565606276629790728', 'endpointPlugin_565606279070875648', 'path转换插件', 'PathTransformRequestPlugin', '{\"patternPath\": \"/queryName\", \"servicePrefix\": \"/demo-order-service\", \"transformPath\": \"/mock/queryName\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_endpoint_plugin` VALUES (882, 'endpoint_565606810690519040', 'endpointPlugin_565606810757627904', 'Rpc路由配置插件', 'RpcRoutingRequestPlugin', '{\"rpcType\": \"dubbo\", \"rpcParamJson\": \"{\\\"serviceName\\\":\\\"io.github.tesla.backend.dubbo.user.UserService\\\",\\\"group\\\":\\\"tesla\\\",\\\"version\\\":\\\"1.0.0\\\",\\\"methodName\\\":\\\"sayHello\\\",\\\"dubboParamTemplate\\\":\\\"[\\\\n\\\\t{\\\\n\\\\t\\\\t\\\\\\\"type\\\\\\\": \\\\\\\"io.github.tesla.backend.dubbo.pojo.UserRequest\\\\\\\",\\\\n\\\\t\\\\t\\\\\\\"expression\\\\\\\": \\\\\\\"${jsonStr}\\\\\\\"\\\\n\\\\t}\\\\n]\\\",\\\"undefined\\\":\\\"\\\"}\"}', '2019-04-10 10:39:32', '2019-04-10 10:39:32');

-- ----------------------------
-- Table structure for gateway_file
-- ----------------------------
DROP TABLE IF EXISTS `gateway_file`;
CREATE TABLE `gateway_file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `file_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该表逻辑主键',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名称',
  `file_blob` longblob NOT NULL COMMENT '文件二进制内容',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `file_id`(`file_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway_file
-- ----------------------------
INSERT INTO `gateway_file` VALUES (10, 'file_550715420345106439', 'file_550715420345106439', 0x504B03040A00000000009A745C4E000000000000000000000000090000004D4554412D494E462F504B03040A000000080099745C4EE5D65E596C00000081000000140000004D4554412D494E462F4D414E49464553542E4D46F34DCCCB4C4B2D2ED10D4B2D2ACECCCFB35230D433E0E5722C4ACEC82C4B2D420807E4A45694162BC02478B99C8B52134B5253749D2AAD141C0B12933352157C13CB52F3148CF58CF52C79B99C4A33734AC0B24EDE5E6EC11E1091145DAF946CA025067A067A46BC5CBC5C00504B03040A00000000004A6F5C4E00000000000000000000000003000000696F2F504B03040A00000000004A6F5C4E0000000000000000000000000A000000696F2F6769746875622F504B03040A00000000004A6F5C4E00000000000000000000000010000000696F2F6769746875622F7465736C612F504B03040A00000000004A6F5C4E00000000000000000000000017000000696F2F6769746875622F7465736C612F66696C7465722F504B03040A00000000004A6F5C4E0000000000000000000000001E000000696F2F6769746875622F7465736C612F66696C7465722F706C7567696E2F504B03040A00000000009A745C4E00000000000000000000000027000000696F2F6769746875622F7465736C612F66696C7465722F706C7567696E2F726573706F6E73652F504B03040A000000000099745C4E00000000000000000000000031000000696F2F6769746875622F7465736C612F66696C7465722F706C7567696E2F726573706F6E73652F6164646865616465722F504B03040A00000000009A745C4E00000000000000000000000034000000696F2F6769746875622F7465736C612F66696C7465722F706C7567696E2F726573706F6E73652F6D6F646966796865616465722F504B03040A00000008009A745C4EAF168213510200002705000054000000696F2F6769746875622F7465736C612F66696C7465722F706C7567696E2F726573706F6E73652F6D6F646966796865616465722F4D6F64696679486561646572526573706F6E7365506C7567696E2E636C617373AD546B6FD250187E0E300AAC6313376F73C2BC0D18EC788B5F30C644E78841583683F163A1877248D7627B3ADD1FF177A81F5CA6893FC01F657C5B98CEE922469BE6BC7D6FCF7B3DFDF2F5E3670077713B83692C4EE3229652B8A4219F41028B1914B09C46069753B8328DABB8A6E1BA861586E43DE948759F215E2CB519120F5D5330CC36A4239AC14E4778CF8C8E4D925CC3ED1A76DBF064C88F8509D5973EC36643BADC92AA1F74B812BE6DF09EB495F0F8D00E2CE9704FF843D7F105DF714DD9DBEB0BC324E5D388A947CCD6D8623372A831A44CF77184C1F0A67812BC1F0C87AEA7B82FBC5D5B28DE144AEDD5951A6E8F045BE265207C550BFD9D50C7FB8663DAE4D9A52ABBBC4FA63CB43F0C5F2B4D6ECA90F57F0AC3F0E05F1365D0FB47623094FF269FCCB61B785D417D23CFFCC9ED5D1B18BB860E1D331A8A3A4A28D3789F185E75FDB5E8064A54474E546068C803256DFEC85042C3AA8E0AAA3AD6C019E6C3E117E875C4ABC2E18835DCD07113B7189AFF772718EA27000AC71CBAD251BF205349E38A8E431527ED2A8336CA8CB67CB5F8E7ED1865EED330562634A58B67982643ABD888BA6D1B8EC5B795271DAB7644D2EA0C44574DB09F3F3248365A1B1BEB5BD1D5F52CEEDBBD3B03DE702D4B78A49D3B2EA3DB2C9D9ECBB0F09B4C4A6D2C23FCB3844F0C2C5C1E3AB3C471A28CE854791FEC5DA49EA5331909D398A3531F19E0147244194E637EEC2CE8E714279AAF1C204699C63F21F1621F531F907CFE1E5A2E7580740C95B7DF61B391B94E103358222E842F8C20C6F0E1D702CE4421F3388B7351BEE723840BDF00504B03040A000000080099745C4E2E302AAA2900000027000000120000004D4554412D494E462F6A706D732E61726773D3D54D4C49D1CDCD4F29CD492DE6E5CA4A2C4BD4ABC8CDD12B2FD64BCCCBCB2F492CC9CCCFE3E50200504B03040A00000008004E535C4ED566DB050C00000010000000260000004D4554412D494E462F7465736C612D6A617266696C7465722E6B6F746C696E5F6D6F64756C65636060606660606084625E00504B03040A00000000009A745C4E0000000000000000000000000F0000004D4554412D494E462F6D6176656E2F504B03040A00000000009A745C4E0000000000000000000000001F0000004D4554412D494E462F6D6176656E2F696F2E6769746875622E7465736C612F504B03040A00000000009A745C4E0000000000000000000000002F0000004D4554412D494E462F6D6176656E2F696F2E6769746875622E7465736C612F7465736C612D6A617266696C7465722F504B03040A0000000800DC535C4EEDE1759BD1020000C10A0000360000004D4554412D494E462F6D6176656E2F696F2E6769746875622E7465736C612F7465736C612D6A617266696C7465722F706F6D2E786D6CC555DF6BDB30107E2FF47F3066AF92D26C0FA3B82E8C6D30685959D7B15745561C35B66524393F18FBDF77966C474E62BB1B85254F77F7E9EE3EDDE75374BBCBB360C39516B2B809AFF02C0C78C164228AF4267CFAFE19BD0F6FE3CB8BA854F299331300BCD037E1CA98F29A909C6E78816949D98A63A952F2F0F59EBCC3B33A8D455EEFB4E8D0DBED166FDF5ADC7C36BB223FEFEF1EE1604E9128B4A105E3E1E545D0FEE0E4B5B6E13BC9A8B1FD4D960D86103B9D3827B2380C7618BB6A512E139EFD707710DB70447ABECB8B065952C50B131FBA8C5225ABF24B120B89536156D5021BAE331A9136E061A932624999016F03F23C1EAE19477CE55AD9745DD828E9357192143D53B51499E1EA4CFAA8A0393FC559AF4792AD690A02880152976BCD0E9170CD9428EB99C41F792E83561D4BA982C7520138F820A589888FAC8F1F8A285972688F6B9F7993072F2A912558CB4A31FEA991636CD508FD8C61CEE452BC9450A848B1AC4C5999A17C83382FE733DD50DC8D0766D3737403F2B9755756F222814FCBF7F6237BAF524F5BA05F9C4BB616469ED3D5B10C1A286252F10189F56436C7F3F9A9CE3A9866C026064E1B91F02422CEF60890B30C5EC84B5BB52C1528702BD51A2FAC6CA649BA73A88623D81DEABCDEFF95C45FD1804FBFE0C6EC5FD2B605229A65FFB1D9A93D75DCF3D8AEB2D856387AAF0DCF51634E08CA814FC939880D3E50B38ADFFC5A50CD13A17E934C2C88DB5D6E7121BB20B1DD52DE89D7B9A857162782C6CDF4D01DEA059F98E7EAED19BB157B6B30AB6079F7778E17386AE398897B32A9D63C5F647BE4CE8CD0B0E7992C9622AD1435A7D3F726E05E06A9BEF1A51E409D22EB37096D41C1C8E77F78681C68A026992C1A91A9E623BEE3ACAA83434D1F1063AC447DB96BDEDD6D44C4B9CBECF0E50A3E83D83DC6B0D69D39824F25CDC6AEB503C51AB49A414A6B8C642463292332C6DA8B1E27002AAD107DC11F64EBEC56D7F5BF7BB3C1FE03504B03040A00000008008683544E94CCA41A73000000780000003D0000004D4554412D494E462F6D6176656E2F696F2E6769746875622E7465736C612F7465736C612D6A617266696C7465722F706F6D2E70726F7065727469657353764FCD4B2D4A2C494D5148AA54F04D2C4BCDE3E5520E0772DD5293148C0C140CCDAC8C2CAC0C0D149C8343807C434B5EAEF4A2FCD202CF14DBCC7CBDF4CC928CD224BD92D4E29C445EAEC4A292CCB4C4E412A01C5844372BB1282D33A724B58897AB2CB5A838333FCFD650CF40CF80970B00504B010214030A00000000009A745C4E000000000000000000000000090000000000000000001000ED41000000004D4554412D494E462F504B010214030A000000080099745C4EE5D65E596C00000081000000140000000000000000000000A481270000004D4554412D494E462F4D414E49464553542E4D46504B010214030A00000000004A6F5C4E000000000000000000000000030000000000000000001000ED41C5000000696F2F504B010214030A00000000004A6F5C4E0000000000000000000000000A0000000000000000001000ED41E6000000696F2F6769746875622F504B010214030A00000000004A6F5C4E000000000000000000000000100000000000000000001000ED410E010000696F2F6769746875622F7465736C612F504B010214030A00000000004A6F5C4E000000000000000000000000170000000000000000001000ED413C010000696F2F6769746875622F7465736C612F66696C7465722F504B010214030A00000000004A6F5C4E0000000000000000000000001E0000000000000000001000ED4171010000696F2F6769746875622F7465736C612F66696C7465722F706C7567696E2F504B010214030A00000000009A745C4E000000000000000000000000270000000000000000001000ED41AD010000696F2F6769746875622F7465736C612F66696C7465722F706C7567696E2F726573706F6E73652F504B010214030A000000000099745C4E000000000000000000000000310000000000000000001000ED41F2010000696F2F6769746875622F7465736C612F66696C7465722F706C7567696E2F726573706F6E73652F6164646865616465722F504B010214030A00000000009A745C4E000000000000000000000000340000000000000000001000ED4141020000696F2F6769746875622F7465736C612F66696C7465722F706C7567696E2F726573706F6E73652F6D6F646966796865616465722F504B010214030A00000008009A745C4EAF1682135102000027050000540000000000000000000000A48193020000696F2F6769746875622F7465736C612F66696C7465722F706C7567696E2F726573706F6E73652F6D6F646966796865616465722F4D6F64696679486561646572526573706F6E7365506C7567696E2E636C617373504B010214030A000000080099745C4E2E302AAA2900000027000000120000000000000000000000A481560500004D4554412D494E462F6A706D732E61726773504B010214030A00000008004E535C4ED566DB050C00000010000000260000000000000000000000A481AF0500004D4554412D494E462F7465736C612D6A617266696C7465722E6B6F746C696E5F6D6F64756C65504B010214030A00000000009A745C4E0000000000000000000000000F0000000000000000001000FFFFFF0500004D4554412D494E462F6D6176656E2F504B010214030A00000000009A745C4E0000000000000000000000001F0000000000000000001000FFFF2C0600004D4554412D494E462F6D6176656E2F696F2E6769746875622E7465736C612F504B010214030A00000000009A745C4E0000000000000000000000002F0000000000000000001000FFFF690600004D4554412D494E462F6D6176656E2F696F2E6769746875622E7465736C612F7465736C612D6A617266696C7465722F504B010214030A0000000800DC535C4EEDE1759BD1020000C10A0000360000000000000000000000A481B60600004D4554412D494E462F6D6176656E2F696F2E6769746875622E7465736C612F7465736C612D6A617266696C7465722F706F6D2E786D6C504B010214030A00000008008683544E94CCA41A73000000780000003D0000000000000000000000A481DB0900004D4554412D494E462F6D6176656E2F696F2E6769746875622E7465736C612F7465736C612D6A617266696C7465722F706F6D2E70726F70657274696573504B0506000000001200120093050000A90A00000000, '2019-02-28 16:26:28', '2019-02-28 16:26:28');

-- ----------------------------
-- Table structure for gateway_gray_plan
-- ----------------------------
DROP TABLE IF EXISTS `gateway_gray_plan`;
CREATE TABLE `gateway_gray_plan`  (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `PLAN_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '计划名称',
  `PLAN_DESC` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '计划描述',
  `PLAN_OWNER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '计划负责人',
  `ENABLE` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否启用',
  `EFFECT_TIME` timestamp(0) NULL DEFAULT NULL COMMENT '生效时间',
  `EXPIRE_TIME` timestamp(0) NULL DEFAULT NULL COMMENT '失效时间',
  `CREATE_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `GMT_CREATE` timestamp(0) NOT NULL DEFAULT '1970-01-02 00:00:00' COMMENT '创建时间',
  `GMT_MODIFIED` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `IDX_PLAN_NAME`(`PLAN_NAME`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '灰度计划' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gateway_gray_policy
-- ----------------------------
DROP TABLE IF EXISTS `gateway_gray_policy`;
CREATE TABLE `gateway_gray_policy`  (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `PLAN_ID` bigint(20) NOT NULL COMMENT '计划编号',
  `CONSUMER_SERVICE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '服务消费方',
  `PROVIDER_SERVICE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '服务提供方',
  `GMT_CREATE` timestamp(0) NOT NULL DEFAULT '1970-01-02 00:00:00' COMMENT '创建时间',
  `GMT_MODIFIED` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `UIDX_MULIT`(`PLAN_ID`, `CONSUMER_SERVICE`, `PROVIDER_SERVICE`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '灰度策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gateway_gray_policy_condition
-- ----------------------------
DROP TABLE IF EXISTS `gateway_gray_policy_condition`;
CREATE TABLE `gateway_gray_policy_condition`  (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `PLAN_ID` bigint(20) NOT NULL COMMENT '计划编号',
  `POLICY_ID` bigint(20) NOT NULL COMMENT '策略编号',
  `SERVICE_TARGET` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '服务目标:CONSUMER-消费方;PROVIDER-提供方',
  `PARAM_KIND` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数类型',
  `PARAM_KEY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数键',
  `PARAM_VALUE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数值',
  `PARAM_DESC` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数描述',
  `TRANSMIT` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Y' COMMENT '是否透传:Y-透传;N-不透传',
  `GMT_CREATE` timestamp(0) NOT NULL DEFAULT '1970-01-02 00:00:00' COMMENT '创建时间',
  `GMT_MODIFIED` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `IDX_PLAN_ID`(`POLICY_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '灰度策略条件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gateway_gray_rule
-- ----------------------------
DROP TABLE IF EXISTS `gateway_gray_rule`;
CREATE TABLE `gateway_gray_rule`  (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `POLICY_ID` bigint(20) NOT NULL COMMENT '策略编号',
  `RULE_KIND` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规则类型',
  `RULE_CONTENT` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规则内容',
  `GMT_CREATE` timestamp(0) NOT NULL DEFAULT '1970-01-02 00:00:00' COMMENT '创建时间',
  `GMT_MODIFIED` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `IDX_PLAN_ID`(`POLICY_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '灰度规则' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gateway_policy
-- ----------------------------
DROP TABLE IF EXISTS `gateway_policy`;
CREATE TABLE `gateway_policy`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `policy_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该表逻辑主键',
  `policy_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'policy名称',
  `policy_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'policy描述',
  `policy_param` json NOT NULL COMMENT 'policy参数',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `policy_id`(`policy_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gateway_service
-- ----------------------------
DROP TABLE IF EXISTS `gateway_service`;
CREATE TABLE `gateway_service`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `service_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'service逻辑主键',
  `service_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'service名称',
  `service_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'service描述',
  `service_enabled` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'service是否启用 Y-启用 N-禁用',
  `approval_status` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '审批状态 Y-已审批 N-未审批',
  `service_prefix` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该service通过gateway对外暴露的请求前缀',
  `service_owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该service负责人',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `service_id`(`service_id`) USING BTREE,
  UNIQUE INDEX `service_name`(`service_name`) USING BTREE,
  UNIQUE INDEX `service_prefix`(`service_prefix`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 216 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway_service
-- ----------------------------
INSERT INTO `gateway_service` VALUES (114, 'service_54994982735025676575', '演示订单服务-uus-oauth2', '演示订单服务，为配置人员提供示例', 'Y', 'Y', '/demo-order-service-uus-oauth2', 'admin', '2019-02-26 19:41:19', '2019-02-27 10:17:46');
INSERT INTO `gateway_service` VALUES (135, 'service_549949827350263445', '演示订单服务-jwt-auth', '演示订单服务，为配置人员提供示例', 'Y', 'Y', '/demo-order-service-jwt-auth', 'admin', '2019-02-26 19:25:55', '2019-02-28 11:50:58');
INSERT INTO `gateway_service` VALUES (211, 'service_549949827350265856', '演示订单服务', '演示订单服务，为配置人员提供示例', 'Y', 'Y', '/demo-order-service', 'zhip.zhang001', '2019-02-26 13:44:17', '2019-04-13 07:35:20');
INSERT INTO `gateway_service` VALUES (213, 'service_test_dubbo', '服务化_dubbo', '服务化标准-dubbo', 'Y', 'Y', '/dubbo-test', 'admin', '2018-12-17 14:34:36', '2019-04-10 10:39:32');
INSERT INTO `gateway_service` VALUES (214, 'service_5499498273502567854556', '演示订单服务-spring-cloud', '演示订单服务，为配置人员提供示例', 'Y', 'Y', '/demo-order-service-spring-cloud', 'admin', '2019-02-27 10:56:52', '2019-04-11 12:07:54');

-- ----------------------------
-- Table structure for gateway_service_plugin
-- ----------------------------
DROP TABLE IF EXISTS `gateway_service_plugin`;
CREATE TABLE `gateway_service_plugin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `service_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'service逻辑主键',
  `plugin_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该表逻辑主键',
  `plugin_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '插件名称',
  `plugin_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '插件类型',
  `plugin_param` json NULL COMMENT '插件参数,json类型，根据plugin_type的不同，json结构也不同，具体结构需对应代码中的实体',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `plugin_id`(`plugin_id`) USING BTREE,
  UNIQUE INDEX `plugin_id_type`(`service_id`, `plugin_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 346 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway_service_plugin
-- ----------------------------
INSERT INTO `gateway_service_plugin` VALUES (193, 'service_54994982735025676575', 'servicePlugin_550260247575396352', '权限验证插件', 'AuthRequestPlugin', '{\"enabled\": \"Y\", \"authType\": \"oauth\", \"authParamJson\": \"{\\\"tokenHeaderKey\\\":\\\"X-BK-UUSSSO-Token\\\",\\\"parseClaims\\\":\\\"Y\\\",\\\"claimsHeaderKey\\\":\\\"X-BK-Jwt-Claims\\\"}\"}', '2019-02-27 10:17:46', '2019-02-27 10:17:46');
INSERT INTO `gateway_service_plugin` VALUES (224, 'service_549949827350263445', 'servicePlugin_550646086931316736', '权限验证插件', 'AuthRequestPlugin', '{\"enabled\": \"Y\", \"authType\": \"jwt\", \"authParamJson\": \"{\\\"issuer\\\":\\\"BKJK\\\",\\\"secretKey\\\":\\\"1FihRrMitxjiEVC1ICytWdthUyWytD+7\\\",\\\"parseClaims\\\":\\\"Y\\\",\\\"claimsHeaderKey\\\":\\\"X-BK-Jwt-Claims\\\"}\"}', '2019-02-28 11:50:58', '2019-02-28 11:50:58');
INSERT INTO `gateway_service_plugin` VALUES (340, 'service_549949827350265856', 'servicePlugin_565606275996450816', '修改Header插件', 'ModifyHeaderResponsePlugin', '{\"addHeader\": {\"header1\": \"value1\"}}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_service_plugin` VALUES (343, 'service_test_dubbo', 'servicePlugin_565606810518552576', '跨域支持插件', 'CorsRequestPlugin', '{\"allowedOrigins\": \"*\", \"allowCredentials\": \"Y\", \"allowedRequestHeaders\": \"X-BK-UUSSSO-Token,X-BK-UUSSSO-BToken,Connection,User-Agent,Cookie,Token,Access-Control-Allow-Origin,Content-Type,X-Requested-With,Accept,Origin,gray,Access-Control-Request-Method,Access-Control-Request-Headers,X-BK-Signature,X-BK-Date,X-BK-Merchant\", \"allowedRequestMethods\": [\"POST\", \"GET\", \"PUT\", \"DELETE\", \"OPTIONS\"]}', '2019-04-10 10:39:32', '2019-04-10 10:39:32');

-- ----------------------------
-- Table structure for gateway_service_router
-- ----------------------------
DROP TABLE IF EXISTS `gateway_service_router`;
CREATE TABLE `gateway_service_router`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `service_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'service逻辑主键',
  `router_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该表逻辑主键',
  `router_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '路由类型',
  `router_param` json NULL COMMENT '路由参数，json类型，根据路由类型的不同，json结构也不同，具体结构需对应实体',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `service_id`(`service_id`) USING BTREE,
  UNIQUE INDEX `router_id`(`router_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 206 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway_service_router
-- ----------------------------
INSERT INTO `gateway_service_router` VALUES (106, 'service_54994982735025676575', 'serviceRouter_550260247567007744', 'direct', '{\"enableSSL\": \"N\", \"targetPrefix\": \"/order-service\", \"servicePrefix\": \"/demo-order-service-uus-oauth2\", \"targetHostPort\": \"10.241.0.42:8902\", \"selfSignCrtFileId\": \"\"}', '2019-02-27 10:17:46', '2019-02-27 10:17:46');
INSERT INTO `gateway_service_router` VALUES (127, 'service_549949827350263445', 'serviceRouter_550646086918733824', 'direct', '{\"enableSSL\": \"N\", \"targetPrefix\": \"/order-service\", \"servicePrefix\": \"/demo-order-service-jwt-auth\", \"targetHostPort\": \"10.241.0.42:8902\", \"selfSignCrtFileId\": \"\"}', '2019-02-28 11:50:58', '2019-02-28 11:50:58');
INSERT INTO `gateway_service_router` VALUES (201, 'service_549949827350265856', 'serviceRouter_565606275887398912', 'direct', '{\"enableSSL\": \"N\", \"targetPrefix\": \"/order-service\", \"servicePrefix\": \"/demo-order-service\", \"targetHostPort\": \"tesla-backend-sample:8902\", \"selfSignCrtFileId\": \"\"}', '2019-04-10 10:37:25', '2019-04-10 10:37:25');
INSERT INTO `gateway_service_router` VALUES (203, 'service_test_dubbo', 'serviceRouter_565606810497581056', 'dubbo', '{}', '2019-04-10 10:39:32', '2019-04-10 10:39:32');
INSERT INTO `gateway_service_router` VALUES (204, 'service_5499498273502567854556', 'serviceRouter_565991436411994112', 'springcloud', '{\"group\": \"\", \"version\": \"\", \"serviceName\": \"TESLA-BACKEND-SAMPLE\", \"targetPrefix\": \"/order-service\", \"servicePrefix\": \"/demo-order-service-spring-cloud\"}', '2019-04-11 12:07:54', '2019-04-11 12:07:54');

-- ----------------------------
-- Table structure for gateway_waf
-- ----------------------------
DROP TABLE IF EXISTS `gateway_waf`;
CREATE TABLE `gateway_waf`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `waf_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该表逻辑主键',
  `waf_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '防火墙名称',
  `waf_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '防火墙描述',
  `waf_enabled` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '防火墙是否启用 Y-启用 N-禁用',
  `waf_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '防火墙类型',
  `plugin_param` json NULL COMMENT '防火墙参数,json类型',
  `gmt_create` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `waf_id`(`waf_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gateway_waf
-- ----------------------------
INSERT INTO `gateway_waf` VALUES (1, '1', 'cookie值黑名单过滤插件', 'cookie值黑名单过滤插件', 'Y', 'BlackCookieRequestPlugin', '{\"blackCookies\": [\"\\\\.\\\\./\\r\", \"\\\\:\\\\$\\r\", \"\\\\$\\\\{\\r\", \"select.+(from|limit)\\r\", \"(?:(union(.*?)select))\\r\", \"having|rongjitest\\r\", \"sleep\\\\((\\\\s*)(\\\\d*)(\\\\s*)\\\\)\\r\", \"benchmark\\\\((.*)\\\\,(.*)\\\\)\\r\", \"base64_decode\\\\(\\r\", \"(?:from\\\\W+information_schema\\\\W)\\r\", \"(?:(?:current_)user|database|schema|connection_id)\\\\s*\\\\(\\r\", \"(?:etc\\\\/\\\\W*passwd)\\r\", \"into(\\\\s+)+(?:dump|out)file\\\\s*\\r\", \"group\\\\s+by.+\\\\(\\r\", \"xwork.methodaccessor\\r\", \"(?:define|eval|file_get_contents|include|require|require_once|shell_exec|phpinfo|system|passthru|preg_\\\\w+|execute|echo|print|print_r|var_dump|(fp)open|alert|showmodaldialog)\\\\(\\r\", \"xwork\\\\.methodaccessor\\r\", \"(gopher|doc|php|glob|file|phar|zlib|ftp|ldap|dict|ogg|data)\\\\:\\\\/\\r\", \"java\\\\.lang\\r\", \"\\\\$_(get|post|cookie|files|session|env|phplib|globals|server)\\\\[\"]}', '2018-12-20 11:02:12', '2018-12-24 15:26:35');
INSERT INTO `gateway_waf` VALUES (2, '2', 'IP黑名单过滤插件', 'IP黑名单过滤插件', 'Y', 'BlackIpRequestPlugin', NULL, '2018-12-20 11:02:12', '2019-04-09 06:09:28');
INSERT INTO `gateway_waf` VALUES (3, '3', 'UA黑名单过滤插件', 'UA黑名单过滤插件', 'Y', 'BlackUaRequestPlugin', NULL, '2018-12-20 11:02:12', '2018-12-20 11:02:12');
INSERT INTO `gateway_waf` VALUES (4, '4', 'URL黑名单过滤插件', 'URL黑名单过滤插件', 'Y', 'BlackURLRequestPlugin', '{\"blackURLs\": [\"\\\\.(svn|git|htaccess|bash_history)\", \"\\\\.(bak|inc|old|mdb|sql|backup|java|class)$\", \"(vhost|bbs|host|wwwroot|www|site|root|hytop|flashfxp).*\\\\.rar\", \"(phpmyadmin|jmx-console|jmxinvokerservlet)\", \"java\\\\.lang\", \"/(attachments|upimg|images|css|uploadfiles|html|uploads|templets|static|template|data|inc|forumdata|upload|includes|cache|avatar)/(\\\\\\\\w+).(php|jsp)\"]}', '2018-12-20 11:02:12', '2018-12-20 11:02:12');
INSERT INTO `gateway_waf` VALUES (5, '5', 'URL参数黑名单过滤插件', 'URL参数黑名单过滤插件', 'Y', 'BlackURLParamRequestPlugin', '{\"blackURLParams\": [\"\\\\.\\\\./\", \"\\\\:\\\\$\", \"\\\\$\\\\{\", \"select.+(from|limit)\", \"(?:(union(.*?)select))\", \"having|rongjitest\", \"sleep\\\\((\\\\s*)(\\\\d*)(\\\\s*)\\\\)\", \"benchmark\\\\((.*)\\\\,(.*)\\\\)\", \"base64_decode\\\\(\", \"(?:from\\\\W+information_schema\\\\W)\", \"(?:(?:current_)user|database|schema|connection_id)\\\\s*\\\\(\", \"(?:etc\\\\/\\\\W*passwd)\", \"into(\\\\s+)+(?:dump|out)file\\\\s*\", \"group\\\\s+by.+\\\\(\", \"xwork.methodaccessor\", \"(?:define|eval|file_get_contents|include|require|require_once|shell_exec|phpinfo|system|passthru|preg_\\\\w+|execute|echo|print|print_r|var_dump|(fp)open|alert|showmodaldialog)\\\\(\", \"xwork\\\\.MethodAccessor\", \"(gopher|doc|php|glob|file|phar|zlib|ftp|ldap|dict|ogg|data)\\\\:\\\\/\", \"java\\\\.lang\", \"\\\\$_(get|post|cookie|files|session|env|phplib|globals|server)\\\\[\", \"\\\\<(iframe|script|body|img|layer|div|meta|style|base|object|input)\", \"(onmouseover|onerror|onload)\\\\=\"]}', '2018-12-20 11:02:12', '2018-12-20 11:02:12');
INSERT INTO `gateway_waf` VALUES (6, '6', '防扫描过滤插件', '防扫描过滤插件', 'Y', 'SecurityScannerRequestPlugin', NULL, '2018-12-20 11:02:12', '2018-12-20 11:02:12');
INSERT INTO `gateway_waf` VALUES (7, '8', 'Clickjack插件', 'Clickjack插件', 'Y', 'ClickjackResponsePlugin', NULL, '2018-12-20 11:02:12', '2018-12-20 11:02:12');
INSERT INTO `gateway_waf` VALUES (8, '9', 'xss防注入攻击插件', 'xss防注入攻击插件', 'Y', 'XssResponsePlugin', NULL, '2018-12-20 11:02:12', '2018-12-20 11:02:12');
INSERT INTO `gateway_waf` VALUES (11, '7', '访问方限流及权限控制插件', '访问方限流及权限控制插件', 'Y', 'AppKeyControlRequestPlugin', '{\"ignoreServices\": {\"service_test_grpc\": \"grpc-test\", \"service_test_cloud\": \"/cloud-test\", \"service_test_dubbo\": \"dubbo-test\", \"service_524238053745623040\": \"/morder\", \"service_524242642574245888\": \"/housingtrade\", \"service_524243589295767552\": \"/crm\", \"service_524246314343464960\": \"/housingloan\", \"service_524246804594688000\": \"/contractsign\", \"service_524250201255313408\": \"/gray\", \"service_524257967332130816\": \"/sms\", \"service_524261428027195392\": \"/hcrc\", \"service_524264785907286016\": \"/point-saas\", \"service_524265182805884928\": \"/vip-saas\", \"service_524532908786974720\": \"/athena\", \"service_524533674733993984\": \"/dcc/ocr\", \"service_524534387321077760\": \"/ecashier\", \"service_524536514101641216\": \"/dcc/face\", \"service_524541614463385600\": \"/cfi\", \"service_524542696572846080\": \"/ewallet\", \"service_524543502395113472\": \"/archimonde\", \"service_524544171772477440\": \"/computing-engine\", \"service_524544742256541696\": \"/openApi/merchant\", \"service_524545756309225472\": \"/realauth\", \"service_524546316685017088\": \"/batch-splitPay\", \"service_524548445852139520\": \"/wallet\", \"service_524555222706552832\": \"/cashierbe\", \"service_524620492917702656\": \"/uus\", \"service_524656280128716800\": \"/auth\", \"service_532583309000048640\": \"/spring\", \"service_537705921359380480\": \"/https-test\", \"service_547444380064022528\": \"/athenaconfig\", \"service_549949827350263445\": \"/demo-order-service-jwt-auth\", \"service_549949827350265856\": \"/demo-order-service\", \"service_552460472129945600\": \"/vision-saas\", \"service_562643007459819520\": \"/lego-push\", \"service_54994982735025676575\": \"/demo-order-service-uus-oauth2\", \"service_5499498273502567854556\": \"/demo-order-service-spring-cloud\"}}', '2018-12-17 14:34:34', '2019-04-04 11:34:28');

-- ----------------------------
-- Table structure for sys_data_backup
-- ----------------------------
DROP TABLE IF EXISTS `sys_data_backup`;
CREATE TABLE `sys_data_backup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `operating_table` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作表',
  `operating_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作类型：DELETE-删除，UPDATE-修改',
  `table_data` json NOT NULL COMMENT '表数据',
  `operating_date` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `operating_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作人员',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '上级部门ID，一级部门为0',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `del_flag` tinyint(4) NULL DEFAULT 0 COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (6, 0, '基础架构', 1, 1);
INSERT INTO `sys_dept` VALUES (9, 0, '业务研发', 2, 1);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户操作',
  `time` int(11) NULL DEFAULT NULL COMMENT '响应时间',
  `method` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `gmt_create` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20656 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `gmt_create` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', NULL, NULL, 0, 'fa fa-desktop', 0, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (2, 0, '系统监控', NULL, NULL, 0, 'fa fa-video-camera', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (4, 0, 'API管理', NULL, NULL, 0, 'fa fa-tachometer', 3, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (5, 0, '接入管理', NULL, NULL, 0, 'fa fa-shield', 4, '2018-12-20 11:02:13', '2018-12-20 11:02:13');
INSERT INTO `sys_menu` VALUES (6, 0, '系统WAF', NULL, NULL, 0, 'fa fa-gears', 5, '2018-10-25 13:54:19', '2018-10-25 13:54:19');
INSERT INTO `sys_menu` VALUES (7, 0, '灰度规则', NULL, NULL, 0, 'fa fa-puzzle-piece', 6, '2018-11-12 15:07:53', '2018-11-12 15:07:53');
INSERT INTO `sys_menu` VALUES (11, 1, '系统菜单', 'sys/menu', 'sys:menu:menu', 1, 'fa fa-th-list', 0, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (12, 1, '用户管理', 'sys/user', 'sys:user:user', 1, 'fa fa-user', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (13, 1, '角色管理', 'sys/role', 'sys:role:role', 1, 'fa fa-paw', 2, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (14, 1, '部门管理', 'sys/dept', 'sys:dept:dept', 1, 'fa fa-users', 3, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (21, 11, '新增', '', 'sys:menu:add', 2, '', 0, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (22, 11, '批量删除', '', 'sys:menu:batchRemove', 2, '', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (23, 11, '编辑', '', 'sys:menu:edit', 2, '', 2, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (24, 11, '删除', '', 'sys:menu:remove', 2, '', 3, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (25, 12, '新增', '', 'sys:user:add', 2, '', 0, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (26, 12, '编辑', '', 'sys:user:edit', 2, '', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (27, 12, '删除', '', 'sys:user:remove', 2, '', 2, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (28, 12, '批量删除', '', 'sys:user:batchRemove', 2, '', 3, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (29, 12, '停用', '', 'sys:user:disable', 2, '', 4, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (30, 12, '重置密码', '', 'sys:user:resetPwd', 2, '', 5, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (31, 13, '新增', '', 'sys:role:add', 2, '', 0, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (32, 13, '批量删除', '', 'sys:role:batchRemove', 2, '', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (33, 13, '编辑', '', 'sys:role:edit', 2, '', 2, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (34, 13, '删除', '', 'sys:role:remove', 2, '', 3, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (35, 14, '增加', '', 'sys:dept:add', 2, '', 0, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (36, 14, '刪除', '', 'sys:dept:remove', 2, '', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (37, 14, '编辑', '', 'sys:dept:edit', 2, '', 2, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (38, 2, '在线用户', 'sys/online', 'sys:monitor:online', 1, 'fa fa-user', 0, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (39, 2, '系统日志', 'sys/log', 'sys:monitor:log', 1, 'fa fa-warning', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (40, 2, '运行监控', 'sys/log/run', 'sys:monitor:run', 1, 'fa fa-caret-square-o-right', 2, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (41, 5, 'Policy列表', 'gateway/policy', 'gateway:policy:list', 1, 'fa fa-area-chart', 4, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (42, 5, '接入列表', 'gateway/appkey', 'gateway:appkey:list', 1, 'fa fa-area-chart', 3, '2018-12-20 11:02:13', '2018-12-20 11:02:13');
INSERT INTO `sys_menu` VALUES (43, 41, '新增', NULL, 'gateway:policy:add', 2, NULL, 0, '2018-12-07 16:44:29', '2018-12-07 16:44:32');
INSERT INTO `sys_menu` VALUES (44, 41, '编辑', NULL, 'gateway:policy:edit', 2, 'fa fa-area-chart', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (45, 41, '删除', NULL, 'gateway:policy:remove', 2, 'fa fa-area-chart', 2, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (46, 42, '新增', NULL, 'gateway:appkey:add', 2, NULL, 0, '2018-12-20 11:02:13', '2018-12-20 11:02:13');
INSERT INTO `sys_menu` VALUES (47, 42, '编辑', NULL, 'gateway:appkey:edit', 2, NULL, 1, '2018-12-20 11:02:13', '2018-12-20 11:02:13');
INSERT INTO `sys_menu` VALUES (48, 42, '删除', NULL, 'gateway:appkey:remove', 2, NULL, 2, '2018-12-20 11:02:13', '2018-12-20 11:02:13');
INSERT INTO `sys_menu` VALUES (49, 42, '生成appkey', NULL, 'gateway:appkey:generate', 2, NULL, 3, '2018-12-20 11:02:14', '2018-12-20 11:02:14');
INSERT INTO `sys_menu` VALUES (50, 4, 'API列表', 'gateway/service', 'gateway:service:list', 1, 'fa fa-area-chart', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (52, 50, '新增', '', 'gateway:service:add', 2, '', 0, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (53, 50, '批量删除', '', 'gateway:service:batchRemove', 2, '', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (54, 50, '编辑', '', 'gateway:service:edit', 2, '', 2, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (55, 50, '删除', '', 'gateway:service:remove', 2, '', 3, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (56, 50, '审核', '', 'gateway:service:review', 2, '', 0, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (57, 50, '导出', '', 'gateway:service:export', 2, '', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (58, 50, '导入', '', 'gateway:service:import', 2, '', 5, '2018-12-20 11:02:12', '2018-12-20 11:02:12');
INSERT INTO `sys_menu` VALUES (66, 6, '系统WAF列表', 'gateway/waf', 'gateway:waf:list', 1, 'fa fa-tachometer', 1, '2018-10-25 13:54:19', '2018-10-25 13:54:19');
INSERT INTO `sys_menu` VALUES (67, 66, '编辑', NULL, 'gateway:waf:edit', 2, 'fa fa-area-chart', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu` VALUES (72, 7, '灰度规则列表', 'gray', 'gray:list', 1, 'fa fa-th-list', 0, '2018-11-12 15:07:53', '2018-11-12 15:07:53');
INSERT INTO `sys_menu` VALUES (73, 72, '新增', '', 'gray:add', 2, '', 0, '2018-11-12 15:07:53', '2018-11-12 15:07:53');
INSERT INTO `sys_menu` VALUES (74, 72, '删除', '', 'gray:remove', 2, '', 0, '2018-11-12 15:07:53', '2018-11-12 15:07:53');
INSERT INTO `sys_menu` VALUES (75, 72, '编辑', '', 'gray:edit', 2, '', 0, '2018-11-12 15:07:53', '2018-11-12 15:07:53');
INSERT INTO `sys_menu` VALUES (76, 72, '批量删除', '', 'gray:batchRemove', 2, '', 0, '2018-11-12 15:07:53', '2018-11-12 15:07:53');
INSERT INTO `sys_menu` VALUES (84, 2, '节点监控', 'sys/nodemonitor/list', 'sys:nodemonitor:list', 1, '', 5, '2019-02-25 16:09:19', '2019-02-25 16:09:19');
INSERT INTO `sys_menu` VALUES (85, 84, 'threaddump下载', '', 'sys:monitor:threaddump', 2, '', 0, '2019-02-25 16:09:19', '2019-02-25 16:09:19');
INSERT INTO `sys_menu` VALUES (86, 84, 'heapdump下载', '', 'sys:monitor:heapdump', 2, '', 0, '2019-02-25 16:09:19', '2019-02-25 16:09:19');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `role_sign` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色标识',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `user_id_create` bigint(255) NULL DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级用户角色', 'admin', '拥有最高权限', 2, '2017-08-12 00:43:52', '2017-08-12 19:14:59');
INSERT INTO `sys_role` VALUES (2, '普通用户', 'user', '普通用户', 2, '2017-08-12 00:43:52', '2017-08-12 19:14:59');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 383 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色与菜单对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 1, 1);
INSERT INTO `sys_role_menu` VALUES (2, 1, 2);
INSERT INTO `sys_role_menu` VALUES (4, 1, 4);
INSERT INTO `sys_role_menu` VALUES (5, 1, 5);
INSERT INTO `sys_role_menu` VALUES (6, 1, 6);
INSERT INTO `sys_role_menu` VALUES (7, 1, 7);
INSERT INTO `sys_role_menu` VALUES (8, 1, 8);
INSERT INTO `sys_role_menu` VALUES (9, 1, 9);
INSERT INTO `sys_role_menu` VALUES (10, 1, 10);
INSERT INTO `sys_role_menu` VALUES (11, 1, 11);
INSERT INTO `sys_role_menu` VALUES (12, 1, 12);
INSERT INTO `sys_role_menu` VALUES (13, 1, 13);
INSERT INTO `sys_role_menu` VALUES (14, 1, 14);
INSERT INTO `sys_role_menu` VALUES (15, 1, 15);
INSERT INTO `sys_role_menu` VALUES (16, 1, 16);
INSERT INTO `sys_role_menu` VALUES (17, 1, 17);
INSERT INTO `sys_role_menu` VALUES (18, 1, 18);
INSERT INTO `sys_role_menu` VALUES (19, 1, 19);
INSERT INTO `sys_role_menu` VALUES (20, 1, 20);
INSERT INTO `sys_role_menu` VALUES (21, 1, 21);
INSERT INTO `sys_role_menu` VALUES (22, 1, 22);
INSERT INTO `sys_role_menu` VALUES (23, 1, 23);
INSERT INTO `sys_role_menu` VALUES (24, 1, 24);
INSERT INTO `sys_role_menu` VALUES (25, 1, 25);
INSERT INTO `sys_role_menu` VALUES (26, 1, 26);
INSERT INTO `sys_role_menu` VALUES (27, 1, 27);
INSERT INTO `sys_role_menu` VALUES (28, 1, 28);
INSERT INTO `sys_role_menu` VALUES (29, 1, 29);
INSERT INTO `sys_role_menu` VALUES (30, 1, 30);
INSERT INTO `sys_role_menu` VALUES (31, 1, 31);
INSERT INTO `sys_role_menu` VALUES (32, 1, 32);
INSERT INTO `sys_role_menu` VALUES (33, 1, 33);
INSERT INTO `sys_role_menu` VALUES (34, 1, 34);
INSERT INTO `sys_role_menu` VALUES (35, 1, 35);
INSERT INTO `sys_role_menu` VALUES (36, 1, 36);
INSERT INTO `sys_role_menu` VALUES (37, 1, 37);
INSERT INTO `sys_role_menu` VALUES (38, 1, 38);
INSERT INTO `sys_role_menu` VALUES (39, 1, 39);
INSERT INTO `sys_role_menu` VALUES (40, 1, 40);
INSERT INTO `sys_role_menu` VALUES (41, 1, 41);
INSERT INTO `sys_role_menu` VALUES (42, 1, 42);
INSERT INTO `sys_role_menu` VALUES (43, 1, 43);
INSERT INTO `sys_role_menu` VALUES (44, 1, 44);
INSERT INTO `sys_role_menu` VALUES (45, 1, 45);
INSERT INTO `sys_role_menu` VALUES (46, 1, 46);
INSERT INTO `sys_role_menu` VALUES (47, 1, 47);
INSERT INTO `sys_role_menu` VALUES (48, 1, 48);
INSERT INTO `sys_role_menu` VALUES (49, 1, 49);
INSERT INTO `sys_role_menu` VALUES (50, 1, 50);
INSERT INTO `sys_role_menu` VALUES (51, 1, 51);
INSERT INTO `sys_role_menu` VALUES (52, 1, 52);
INSERT INTO `sys_role_menu` VALUES (53, 1, 53);
INSERT INTO `sys_role_menu` VALUES (54, 1, 54);
INSERT INTO `sys_role_menu` VALUES (55, 1, 55);
INSERT INTO `sys_role_menu` VALUES (56, 1, 56);
INSERT INTO `sys_role_menu` VALUES (57, 1, 57);
INSERT INTO `sys_role_menu` VALUES (58, 1, 58);
INSERT INTO `sys_role_menu` VALUES (59, 1, 59);
INSERT INTO `sys_role_menu` VALUES (60, 1, 60);
INSERT INTO `sys_role_menu` VALUES (61, 1, 61);
INSERT INTO `sys_role_menu` VALUES (62, 1, 62);
INSERT INTO `sys_role_menu` VALUES (63, 1, 63);
INSERT INTO `sys_role_menu` VALUES (64, 1, 64);
INSERT INTO `sys_role_menu` VALUES (65, 1, 65);
INSERT INTO `sys_role_menu` VALUES (66, 1, 66);
INSERT INTO `sys_role_menu` VALUES (67, 1, 67);
INSERT INTO `sys_role_menu` VALUES (68, 1, 68);
INSERT INTO `sys_role_menu` VALUES (69, 1, 69);
INSERT INTO `sys_role_menu` VALUES (72, 1, 72);
INSERT INTO `sys_role_menu` VALUES (73, 1, 73);
INSERT INTO `sys_role_menu` VALUES (74, 1, 74);
INSERT INTO `sys_role_menu` VALUES (75, 1, 75);
INSERT INTO `sys_role_menu` VALUES (76, 1, 76);
INSERT INTO `sys_role_menu` VALUES (77, 1, 77);
INSERT INTO `sys_role_menu` VALUES (78, 1, 78);
INSERT INTO `sys_role_menu` VALUES (79, 1, 79);
INSERT INTO `sys_role_menu` VALUES (80, 1, 80);
INSERT INTO `sys_role_menu` VALUES (81, 1, 81);
INSERT INTO `sys_role_menu` VALUES (82, 1, 82);
INSERT INTO `sys_role_menu` VALUES (83, 1, 83);
INSERT INTO `sys_role_menu` VALUES (84, 1, 84);
INSERT INTO `sys_role_menu` VALUES (85, 1, 85);
INSERT INTO `sys_role_menu` VALUES (251, 1, 84);
INSERT INTO `sys_role_menu` VALUES (254, 2, 4);
INSERT INTO `sys_role_menu` VALUES (255, 2, 5);
INSERT INTO `sys_role_menu` VALUES (257, 2, 7);
INSERT INTO `sys_role_menu` VALUES (291, 2, 41);
INSERT INTO `sys_role_menu` VALUES (292, 2, 42);
INSERT INTO `sys_role_menu` VALUES (293, 2, 43);
INSERT INTO `sys_role_menu` VALUES (294, 2, 44);
INSERT INTO `sys_role_menu` VALUES (295, 2, 45);
INSERT INTO `sys_role_menu` VALUES (296, 2, 46);
INSERT INTO `sys_role_menu` VALUES (297, 2, 47);
INSERT INTO `sys_role_menu` VALUES (298, 2, 48);
INSERT INTO `sys_role_menu` VALUES (299, 2, 49);
INSERT INTO `sys_role_menu` VALUES (300, 2, 50);
INSERT INTO `sys_role_menu` VALUES (302, 2, 52);
INSERT INTO `sys_role_menu` VALUES (303, 2, 53);
INSERT INTO `sys_role_menu` VALUES (304, 2, 54);
INSERT INTO `sys_role_menu` VALUES (305, 2, 55);
INSERT INTO `sys_role_menu` VALUES (307, 2, 57);
INSERT INTO `sys_role_menu` VALUES (308, 2, 58);
INSERT INTO `sys_role_menu` VALUES (320, 2, 72);
INSERT INTO `sys_role_menu` VALUES (321, 2, 73);
INSERT INTO `sys_role_menu` VALUES (322, 2, 74);
INSERT INTO `sys_role_menu` VALUES (323, 2, 75);
INSERT INTO `sys_role_menu` VALUES (324, 2, 76);
INSERT INTO `sys_role_menu` VALUES (379, 1, 84);
INSERT INTO `sys_role_menu` VALUES (380, 1, 84);
INSERT INTO `sys_role_menu` VALUES (381, 1, 85);
INSERT INTO `sys_role_menu` VALUES (382, 1, 86);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `dept_id` int(20) NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `status` tinyint(255) NULL DEFAULT NULL COMMENT '状态 0:禁用，1:正常',
  `user_id_create` bigint(255) NULL DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '超级管理员', '00d7aa78b181be8023819efe7ad5abfd', 6, 'admin@example.com', '123456', 1, 1, '2017-08-15 21:40:39', '2018-11-27 11:45:03');
INSERT INTO `sys_user` VALUES (2, 'test', '普通用户', 'b132f5f968c9373261f74025c23c2222', 6, 'test@test.com', NULL, 1, 1, '2017-08-14 13:43:05', '2017-08-14 21:15:36');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与角色对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2, 2);

