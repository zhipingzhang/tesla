package io.github.tesla.filter.support.plugins;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import io.github.tesla.filter.AbstractRequestPlugin;

public class RequestPluginMetadata extends FilterMetadata {

    private static final Cache<Class<? extends AbstractRequestPlugin>, Object> INSTANCE_CACHE =
            CacheBuilder.newBuilder().weakKeys().weakValues().build();

    protected Class<? extends AbstractRequestPlugin> filterClass;

    public Class<? extends AbstractRequestPlugin> getFilterClass() {
        return filterClass;
    }

    public void setFilterClass(Class<? extends AbstractRequestPlugin> filterClass) {
        this.filterClass = filterClass;
    }

    public <T> T getInstance() throws Exception {
        return (T) INSTANCE_CACHE.get(filterClass, () -> getFilterClass().getDeclaredConstructor().newInstance());
    }
}
