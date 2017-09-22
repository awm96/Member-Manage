package cn.lgq.mm.controller;

import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletContext;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;
import java.util.Set;

/**
 * Created by Ligq on 2017/9/15.
 */
public abstract class AbstractController {

    @Autowired
    protected ServletContext context;

    @Autowired
    protected Validator validator;

    /**
     * 手动校验POJO对象
     *
     * @param <T>  添加了validate注解的POJO
     * @param form POJO实例
     * @return 校验消息，不等于null表示校验有问题
     */
    protected <T> String validate(T form) {
        return getValidateMessage(validator.validate(form));
    }

    /**
     * 手动校验POJO对象的某几个字段
     *
     * @param <T>           添加了validate注解的POJO
     * @param form          POJO实例
     * @param propertyNames 需要校验的字段名称
     * @return 校验消息，不等于null表示校验有问题
     */
    protected <T> String validate(T form, String... propertyNames) {
        String message = null;
        for (String property : propertyNames) {
            message = getValidateMessage(validator.validateProperty(form, property));
            if (message != null) {
                break;
            }
        }
        return message;
    }

    /**
     * 手动校验POJO对象的某1个字段值
     *
     * @param <T>          添加了validate注解的POJO
     * @param formClass    POJO类
     * @param propertyName 需要校验的字段名称
     * @param value        需要校验的字段值
     * @return 校验消息，不等于null表示校验有问题
     */
    protected <T> String validate(Class<T> formClass, String propertyName, Object value) {
        return getValidateMessage(validator.validateValue(formClass, propertyName, value));
    }

    private <T> String getValidateMessage(Set<ConstraintViolation<T>> ret) {
        String message = null;
        if (ret != null && !ret.isEmpty()) {
            StringBuilder sb = new StringBuilder();
            ConstraintViolation<T> cv = ret.iterator().next();
            sb.append(cv.getPropertyPath()).append(cv.getMessage());
            message = sb.toString();
        }
        return message;
    }
}
