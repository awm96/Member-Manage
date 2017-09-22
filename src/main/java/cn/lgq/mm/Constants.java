package cn.lgq.mm;

/**
 * Created by Ligq on 2017/9/15.
 */
public class Constants {

    public static final String MEMBER_SESSION_KEY = "$_MEMBER_SESSION_KEY_$";
    public static final String ADMIN_SESSION_KEY = "$_ADMIN_SESSION_KEY_$";
    public static final String STATUS_CODE_REQUEST_KEY = "javax.servlet.error.status_code";
    public static final String ERROR_MSG_REQUEST_KEY = "javax.servlet.error.message";

    public static final String DEFAULT_MEMBER_PASSWORD = "12345678";

    public static final Integer TRANS_TYPE_STORED = 0;
    public static final Integer TRANS_TYPE_STORED_REVERSE = 1;
    public static final Integer TRANS_TYPE_CONSUME = 2;
    public static final Integer TRANS_TYPE_CONSUME_REVERSE = 3;
    public static final Integer TRANS_TYPE_INTEGRAL = 4;
    public static final Integer TRANS_TYPE_INTEGRAL_REVERSE = 5;

    public static final Integer ADMIN_NORMAL = 0;
    public static final Integer ADMIN_SUPER = 1;

    public static final Integer MEMBER_LEVEL_NONE = 0;
    public static final Integer MEMBER_LEVEL_1 = 1;
    public static final Integer MEMBER_LEVEL_2 = 2;
    public static final Integer MEMBER_LEVEL_3 = 3;
    public static final Integer MEMBER_SEX_WOMAN = 0;
    public static final Integer MEMBER_SEX_MAN = 1;
}
