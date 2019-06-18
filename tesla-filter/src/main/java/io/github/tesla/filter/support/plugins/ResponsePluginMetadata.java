package io.github.tesla.filter.support.plugins;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import io.github.tesla.filter.AbstractResponsePlugin;

public class ResponsePluginMetadata extends FilterMetadata {

    private static final Cache<Class<? extends AbstractResponsePlugin>, Object> INSTANCE_CACHE =
            CacheBuilder.newBuilder().weakKeys().weakValues().build();

    protected Class<? extends AbstractResponsePlugin> filterClass;

    public Class<? extends AbstractResponsePlugin> getFilterClass() {
        return filterClass;
    }

    public void setFilterClass(Class<? extends AbstractResponsePlugin> filterClass) {
        this.filterClass = filterClass;
    }

    public <T> T getInstance() throws Exception {
        return (T) INSTANCE_CACHE.get(filterClass, () -> getFilterClass().getDeclaredConstructor().newInstance());
    }
}
