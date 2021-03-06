package com.first.core.common;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by zhz on 2018/1/30.
 */
public class ThreadLocalUtils {

    private static final ThreadLocal<Map<String, Object>> local = ThreadLocal.withInitial(() -> new HashMap<>());

    public static <T> T put(String key, T value) {
        local.get().put(key, value);
        return value;
    }

    public static void remove(String key) {
        local.get().remove(key);
    }

    public static void clear() {
        local.remove();
    }

    public static <T> T get(String key) {
        return ((T) local.get().get(key));
    }
}
