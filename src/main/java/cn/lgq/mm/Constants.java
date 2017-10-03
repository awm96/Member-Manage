package cn.lgq.mm;

import java.util.TreeMap;

/**
 * Created by Ligq on 2017/9/15.
 */
public class Constants {

    public static final String MEMBER_SESSION_KEY = "$_MEMBER_SESSION_KEY_$";
    public static final String ADMIN_SESSION_KEY = "$_ADMIN_SESSION_KEY_$";
    public static final String STATUS_CODE_REQUEST_KEY = "javax.servlet.error.status_code";
    public static final String ERROR_MSG_REQUEST_KEY = "javax.servlet.error.message";

    public static final String DEFAULT_MEMBER_PASSWORD = "12345678";

    public static final int TRANS_TYPE_STORED_RECHARGE = 0;
    public static final int TRANS_TYPE_STORED_RECHARGE_REVERSE = 1;
    public static final int TRANS_TYPE_CONSUME_RECHARGE = 2;
    public static final int TRANS_TYPE_CONSUME_RECHARGE_REVERSE = 3;
    public static final int TRANS_TYPE_CONSUME_PAY = 4;
    public static final int TRANS_TYPE_CONSUME_PAY_REVERSE = 5;
    public static final int TRANS_TYPE_INTEGRAL_RECHARGE = 6;
    public static final int TRANS_TYPE_INTEGRAL_RECHARGE_REVERSE = 7;
    public static final int TRANS_TYPE_INTEGRAL_PAY = 8;
    public static final int TRANS_TYPE_INTEGRAL_PAY_REVERSE = 9;

    public static final int ADMIN_NORMAL = 0;
    public static final int ADMIN_SUPER = 1;
    public static final int ADMIN_SYSTEM = 2;

    public static final int MEMBER_LEVEL_NONE = 0;
    public static final int MEMBER_LEVEL_1 = 1;
    public static final int MEMBER_LEVEL_2 = 2;
    public static final int MEMBER_LEVEL_3 = 3;
    public static final int MEMBER_LEVEL_1_THRESHOLD = 100;
    public static final int MEMBER_LEVEL_2_THRESHOLD = 200;
    public static final int MEMBER_LEVEL_3_THRESHOLD = 500;
    public static final TreeMap<Integer, Integer> MEMBER_LEVEL_THRESHOLD_MAP = new TreeMap(){{
        this.put(MEMBER_LEVEL_1_THRESHOLD, MEMBER_LEVEL_1);
        this.put(MEMBER_LEVEL_2_THRESHOLD, MEMBER_LEVEL_2);
        this.put(MEMBER_LEVEL_3_THRESHOLD, MEMBER_LEVEL_3);
    }};
    public static final int MEMBER_SEX_WOMAN = 0;
    public static final int MEMBER_SEX_MAN = 1;

    public static final int MEMBER_RECOMMEND_NUM_THRESHOLD = 2;
}
