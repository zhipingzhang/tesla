package io.github.tesla.filter.common.definition;

import java.util.concurrent.locks.ReentrantReadWriteLock;

public interface CacheConstant {

    String CACHE_RESULT_MAP = "CACHE_RESULT_MAP";

    ReentrantReadWriteLock READ_WRITE_LOCK = new ReentrantReadWriteLock();
}
