package cn.itcast.travel.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public class JsonUtils {

    public static final ObjectMapper mapper = new ObjectMapper();

    //private static final Logger logger = LoggerFactory.getLogger(JsonUtils.class);

    /**
     * 对象转json字符串
     * @param obj
     * @return
     */
    public static String serialize(Object obj) {
        if (obj == null) {
            return null;
        }
        if (obj.getClass() == String.class) {
            return (String) obj;
        }
        try {
            return mapper.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
         //   logger.error("json序列化出错：" + obj, e);
            return null;
        }
    }

    /**
     * json字符串转普通对象
     * @param json
     * @param tClass
     * @param <T>
     * @return
     */
    public static <T> T parse(String json, Class<T> tClass) {
        try {
            return mapper.readValue(json, tClass);
        } catch (IOException e) {
           // logger.error("json解析出错：" + json, e);
            return null;
        }
    }

    /**
     * json转list集合
     * @param json
     * @param eClass
     * @param <E>
     * @return
     */
    public static <E> List<E> parseList(String json, Class<E> eClass) {
        try {
            return mapper.readValue(json, mapper.getTypeFactory().constructCollectionType(List.class, eClass));
        } catch (IOException e) {
            //logger.error("json解析出错：" + json, e);
            return null;
        }
    }

    /**
     * json字符串转map
     * @param json
     * @param kClass
     * @param vClass
     * @param <K>
     * @param <V>
     * @return
     */
    public static <K, V> Map<K, V> parseMap(String json, Class<K> kClass, Class<V> vClass) {
        try {
            return mapper.readValue(json, mapper.getTypeFactory().constructMapType(Map.class, kClass, vClass));
        } catch (IOException e) {
           // logger.error("json解析出错：" + json, e);
            return null;
        }
    }


    public static <T> T nativeRead(String json, TypeReference<T> type) {
        try {
            return mapper.readValue(json, type);
        } catch (IOException e) {
            //logger.error("json解析出错：" + json, e);
            return null;
        }
    }
}
