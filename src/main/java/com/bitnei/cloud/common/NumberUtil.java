
package com.bitnei.cloud.common;

import java.text.DecimalFormat;

/**
 *
 * @author Xiao Jin Lu
 * @ClassName: NumberUtil
 * @date 2018-06-06
 */
public class NumberUtil {
	// 将double格式化为有8为数值的字符串
	public static DecimalFormat df8 = null;
	private static DecimalFormat df2 = null;

	public static String formate2Num(Double num) {
		if (df2 == null) {
			df2 = new DecimalFormat("0.00");
		}
		return num == null ? "0.00" : df2.format(num);
	}

	/**
	 * 将double格式化为有8为数值的字符串
	 * 
	 * @param num
	 * @return
	 */
	public static String format8Num(double num) {
		if (df8 == null) {
			df8 = new DecimalFormat("########");
		}
		return df8.format(num);
	}

	/**
	 * 验证是否为大于零的整数
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isPositiveDouble(String str) {
		boolean flag = false;
		try {
			double doubleValue = Double.parseDouble(str);
			if (doubleValue > 0) {
				flag = true;
			}
		} catch (Exception e) {
		}
		return flag;
	}

	/**
	 * 判断字符串是否为浮点数（Double）数据类型
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isDouble(String str) {
		boolean flag = false;
		try {
			Double.parseDouble(str);
			flag = true;
		} catch (Exception e) {
		}
		return flag;
	}

	/**
	 * 判断字符串是否为整型（Integer）
	 * 
	 * @param str
	 *            数字字符串
	 * @return String
	 */
	public static boolean isInteger(String str) {
		boolean flag = false;
		if (str != null && str.length() > 0) {
			try {
				Integer.parseInt(str);
				flag = true;
			} catch (Exception e) {
			}
		}
		return flag;
	}

	/**
	 * 妥当性数字を判定し（０−９）、true又はfalseを返す
	 * 
	 * @param number
	 *            変換する文字列
	 * @return boolean 有効な時、trueを返し、他のはfalseを返す。
	 * 
	 *         2003/11/06 新規作成 LiuYanYan
	 */
	public static boolean checkNumberValid(String number) {
		number = StringUtil.NVL(number);
		if ("".equals(number)) {
			return false;
		}
		boolean bDot = false; // 単一点の判断フラグ
		int nChar;
		for (int i = 0; i < number.length(); i++) {
			nChar = number.charAt(i);
			if (nChar == '-' && i == 0) {
				continue;
			} else if (nChar == '-' && i != 0) {
				return false;
			}
			if (nChar > '9') {
				return false;
			}
			if ((nChar < '0') && (nChar != ',') && (nChar != '.')) {
				return false;
			}
			// 一つ点のみがある、trueを返し、他のはfalseを返す
			if (nChar == '.') {
				// 単一点がある、trueを返し、他のはfalseを返す
				if (!bDot) {
					bDot = true;
					continue;
				} else {
					return false;
				}
			}
		}
		return true;
	}

	/**
	 * 数字のチェック
	 * 
	 * @param s
	 *            数字の文字列
	 * @return int
	 * 
	 *         2003/11/06 新規作成 LiuYanYan
	 */
	public static int checkIntNumberValid(String s) {
		if (s == null || s.length() == 0) {
			return -1;
		}
		for (int i = 0, j = s.length(); i < j; i++) {
			if (s.charAt(i) < '0' || s.charAt(i) > '9') {
				return -1;
			}
		}
		return 1;
	}

	/**
	 * StringタイプをIntタイプに変換する
	 * 
	 * @param str
	 *            文字列
	 * @return int intの文字列 2003/11/07 新規作成 LiuYanYan
	 * 
	 * @throws Exception
	 *             the exception
	 */
	public static int convertToInt(String str) throws Exception {
		if (null == str) {
			return 0;
		}
		int result = 0;
		try {
			str = str.trim();
			result = Integer.parseInt(str);
			return result;
		} catch (Exception ex) {
			throw ex;
		}
	}

	/**
	 * StringタイプをLongタイプに変換する
	 * 
	 * @param str
	 *            文字列
	 * @return Long Longの文字列 2003/11/07 新規作成 LiuYanYan
	 * @throws Exception
	 *             the exception
	 */
	public static long convertToLong(String str) throws Exception {
		long result = 0;
		try {
			str = str.trim();
			result = Long.parseLong(str);
			return result;
		} catch (Exception ex) {
			throw ex;
		}
	}

	/**
	 * StringタイプをFloatタイプに変換する
	 * 
	 * @param str
	 *            文字列
	 * @return Float Floatの文字列 2003/11/07 新規作成 LiuYanYan
	 * @throws Exception
	 *             the exception
	 */
	public static float convertToFloat(String str) throws Exception {
		float result = 0;
		try {
			str = str.trim();
			result = Float.parseFloat(str);
			return result;
		} catch (Exception ex) {
			throw ex;
		}

	}

	/**
	 * StringタイプをIntタイプに変換する
	 * 
	 * @param value
	 *            文字列
	 * @param flag
	 *            変換フラグ： true : valueはNULL又は空文字列の場合、WarningExceptionを投げる false :
	 *            valueはNULL又は空文字列の場合、0を返す
	 * 
	 * @return int 変換した文字列
	 * @throws Exception
	 *             the exception
	 * 
	 * @author JiangJusheng
	 */
	public static int parseInt(String value, boolean flag) throws Exception {
		if (flag) {
			if (value == null || "".equals(value.trim())) {
				return 0;
			}
		} else {
			if (value == null || "".equals(value.trim())) {
				return 0;
			}
		}
		try {
			return Integer.parseInt(value.trim());
		} catch (NumberFormatException ex) {
			throw new Exception();
		}
	}

	/**
	 * String類型からlong類型に変換する
	 * 
	 * @param value
	 *            文字列
	 * @param flag
	 *            変換のフラグ： true : valueはNULL又は空文字列の場合、WarningException例外を呼び出す
	 *            false : valueはNULL又は空文字列の場合、0を返す
	 * 
	 * @return long 変換後文字列
	 * @throws Exception
	 *             the exception
	 * 
	 * @author JiangJusheng
	 */
	public static long parseLong(String value, boolean flag) throws Exception {
		if (flag) {
			if (value == null || "".equals(value.trim())) {
				throw new Exception();
			}
		} else {
			if (value == null || "".equals(value.trim())) {
				return 0;
			}
		}
		try {
			return Long.parseLong(value.trim());
		} catch (NumberFormatException ex) {
			if (flag) {
				throw new Exception();
			} else {
				return 0;
			}
		}
	}

	/**
	 * 计算值入率
	 * 
	 * @param strSell
	 *            the strSell
	 * @param strOri
	 *            the strOri
	 * @return String
	 */
	public static String computerZhirulv(String strSell, String strOri) {
		if (strSell == null || strOri == null || strSell.length() == 0
				|| strOri.length() == 0) {
			return null;
		}
		float fSell = 0f;
		float fOri = 0f;
		try {
			fSell = Float.parseFloat(strSell);
			fOri = Float.parseFloat(strOri);
		} catch (NumberFormatException ex) {
			return null;
		}
		String str = "" + (1 - fOri / fSell);
		if (str.indexOf(".") > 0) {
			if (str.length() >= str.indexOf(".") + 3) {
				str = str.substring(0, str.indexOf(".") + 3);
			}
		}
		return str;
	}

	/**
	 * 機能説明：数字かどうかをチェックします
	 * 
	 * @MethodName:isNum
	 * @param strInput
	 *            the String
	 * @return boolean
	 */
	public static boolean isNum(String strInput) {
		boolean bResult = true;
		bResult = java.util.regex.Pattern.matches("^\\d+$", strInput);
		return bResult;
	}

	/**
	 * 機能説明：お金の表示をフォーマットする
	 * 
	 * @MethodName:formCurrent
	 * @param strPrice
	 *            the str price
	 * @param bAdd
	 *            the bAdd
	 * @return
	 * @return String
	 */
	public static String formCurrent(String strPrice, boolean bAdd) {
		if (null == strPrice || strPrice.trim().equals("")
				|| "null".equalsIgnoreCase(strPrice)) {
			return "0";
		}
		if (strPrice.trim().equals("&nbsp")) {
			return strPrice;
		}
		String sReturn = "";
		String strTemp = "";
		String strTemp1 = "";
		String subtractFlag = "";
		if (strPrice.charAt(0) == '-') {
			subtractFlag = "-";
			strPrice = strPrice.substring(1);
		}
		int nLength = strPrice.indexOf(".");
		if (nLength > 0) {
			strPrice = strPrice.substring(0, nLength);
			strTemp1 = strPrice.substring(nLength);
			strPrice = checkAddOne(strPrice, strTemp1);
		}
		nLength = strPrice.length();
		int count = 3;
		while (nLength > count) {
			strTemp = strPrice.substring(nLength - count, nLength - count + 3);
			sReturn = "," + strTemp + sReturn;
			count += 3;
		}
		strTemp = strPrice.substring(0, nLength - count + 3);
		sReturn = strTemp + sReturn;
		if (bAdd && !sReturn.equals("")) { // お金の後に、円を取り入れ
			sReturn = sReturn + "\u5186";
		}
		return subtractFlag + sReturn;
	}

	/**
	 * 機能説明：四舍五入
	 * 
	 * @MethodName:checkAddOne
	 * @param strPrice
	 *            the string price
	 * @param strTemp1
	 *            the string temp
	 * @return String the string
	 */
	private static String checkAddOne(String strPrice, String strTemp1) {
		if (strTemp1.length() > 1) {
			strTemp1 = strTemp1.substring(1, 2);
			if (isNum(strTemp1)) {
				int pointNum = Integer.parseInt(strTemp1);
				if (pointNum >= 5 && isNum(strPrice)) {
					strPrice = String.valueOf(Integer.parseInt(strPrice) + 1);
				}
			}
		}
		return strPrice;
	}

	/**
	 * 除去小数前后的 0
	 * 
	 * @param value
	 *            the value
	 * @return String the string
	 */
	public static String omitZero(String value) {
		if (!checkNumberValid(value)) {
			return StringUtil.NVL(value);
		}
		while (value.startsWith("0")) {
			if (value.length() <= 2) {
				break;
			}
			value = value.substring(1, value.length());
		}
		// 如果是小数,则应除去小数点后的0
		if (value.indexOf(".") >= 0) {
			while (value.endsWith("0")) {
				if (value.length() < 2) {
					break;
				}
				value = value.substring(0, value.length() - 1);
			}
		}
		if (value.startsWith(".")) {
			value = "0" + value;
		}
		if (value.endsWith(".")) {
			value += "0";
		}
		if (value.endsWith(".0")) {
			return value.substring(0, value.lastIndexOf(".0"));
		}
		return value;
	}

	/**
	 * 
	 * @param value
	 *            the value
	 * @return float the num
	 */
	public static float floor(double value) {
		double num = Math.floor(value);
		return Float.parseFloat(String.valueOf(num));
	}
}
