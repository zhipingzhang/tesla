package io.github.tesla.filter;

import com.google.common.collect.Maps;
import com.hazelcast.core.HazelcastInstance;
import io.github.tesla.common.dto.ServiceRouterDTO;
import io.github.tesla.common.service.GatewayApiTextService;
import io.github.tesla.common.service.SpringContextHolder;
import io.github.tesla.filter.support.springcloud.SpringCloudDiscovery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;

/**
 * @author: zhangzhiping
 * @date: 2018/11/29 15:25
 * @description:
 */
public class AbstractPlugin {

    public static final Logger LOGGER = LoggerFactory.getLogger(AbstractPlugin.class);

    private static Map<String, byte[]> fileLocalCacheMap = Maps.newHashMap();

    private static Map<String, ServiceRouterDTO> routerLocalCache = Maps.newHashMap();

    private static HazelcastInstance hazelcastInstance;

    // 应用的接入配置缓存
    private static Map<String, Map<String, String>> appKeyLocalDefinitionMap = Maps.newHashMap();

    private SpringCloudDiscovery springCloudDiscovery;

    public static void clearLocalCache() {
        routerLocalCache.clear();
    }

    public static byte[] getFileBytesByKey(String key) {
        return fileLocalCacheMap.get(key);
    }

    public static HazelcastInstance getHazelcastInstance() {
        if (AbstractPlugin.hazelcastInstance == null) {
            AbstractPlugin.hazelcastInstance = SpringContextHolder.getBean(HazelcastInstance.class);
        }
        return hazelcastInstance;
    }

    public static ServiceRouterDTO getRouterByServiceId(String serviceId) {
        if (routerLocalCache.get(serviceId) == null) {
            routerLocalCache.put(serviceId, SpringContextHolder.getBean(GatewayApiTextService.class)
                    .loadGatewayServiceByServiceId(serviceId).getRouterDTO());
        }
        return routerLocalCache.get(serviceId);
    }

    public static void setFileLocalCacheMap(Map<String, byte[]> fileLocalCacheMap) {
        AbstractPlugin.fileLocalCacheMap = fileLocalCacheMap;
    }

    public static void setAppKeyLocalDefinitionMap(Map<String, Map<String, String>> appKeyLocalDefinitionMap) {
        AbstractPlugin.appKeyLocalDefinitionMap = appKeyLocalDefinitionMap;
    }

    public static Map<String, String> getAppKeyMap(String appKey) {
        return appKeyLocalDefinitionMap.get(appKey);
    }

    public SpringCloudDiscovery getSpringCloudDiscovery() {
        return springCloudDiscovery;
    }

    public void setSpringCloudDiscovery(SpringCloudDiscovery springCloudDiscovery) {
        this.springCloudDiscovery = springCloudDiscovery;
    }
}
