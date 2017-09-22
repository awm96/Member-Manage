package cn.lgq.mm.util;

import org.apache.commons.lang3.StringUtils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * SHA-1数字摘要加密工具
 */
public class SHA1Util {

    private static final String ENCODETYPE = "SHA-1";
    private static final int HEX_MIXED = 0xFF;

    public SHA1Util() {
    }

    /**
     * 字符串加密方法
     *
     * @param strSrc 原字符串
     * @return 加密后字符串
     */
    public static String encrypt(String strSrc) {
        return SHA1Util.encrypt(strSrc, SHA1Util.ENCODETYPE);
    }

    /**
     * 字符串加密方法
     *
     * @param strSrc  原字符串
     * @param encName 数据摘要算法名称
     * @return 加密后字符串
     */
    public static String encrypt(String strSrc, String encName) {
        if (StringUtils.isEmpty(strSrc)) {
            return StringUtils.EMPTY;
        }
        MessageDigest messageDigest = null;
        String strDes = null;
        byte[] bt = strSrc.getBytes();
        try {
            messageDigest = MessageDigest.getInstance(encName);
            messageDigest.update(bt);
            strDes = bytes2Hex(messageDigest.digest());
        } catch (NoSuchAlgorithmException e) {
            return null;
        }
        return strDes;
    }

    private static String bytes2Hex(byte[] bts) {
        StringBuffer bdes = new StringBuffer();
        StringBuffer btmp = null;
        for (int i = 0; i < bts.length; i++) {
            btmp = new StringBuffer(((Integer.toHexString(bts[i] & HEX_MIXED))));
            if (btmp.length() == 1) {
                bdes.append("0");
            }
            bdes.append(btmp);
        }
        return bdes.toString();
    }
}