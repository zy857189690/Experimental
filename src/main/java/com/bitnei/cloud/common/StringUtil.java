
package com.bitnei.cloud.common;

import java.lang.reflect.Method;
import java.util.*;

/**
 * 字符串处理
 *
 * @author Xiao Jin Lu
 * @ClassName: StringUtil
 * @date 2018-06-06
 */
public class StringUtil {
	/**
	 * 空字符串
	 */
	private static final String EMPTY_STR = "";
	/**
	 * 分隔符
	 */
	private static final String SEP = ",";

	/**
	 * 一个是否穿是否为空，（null或空字符串）
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isEmplyStr(String str) {
		if (str == null || "".equals(str)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 将为NULL的String设置为空串。
	 * 
	 * @param str
	 *            字符串
	 * @return String
	 */
	public static String trimNull(String str) {
		return str == null ? EMPTY_STR : str;
	}

	/**
	 * 将Object(MAP)中所有字符串类型字段为NULL的设置为空串。
	 * 
	 * @param o
	 *            Object（Map）
	 */
	public static void removeNullString(Object o) {
		Class oclass = o.getClass();
		Method[] methods = oclass.getMethods();
		Map<String, Method> map = new HashMap<String, Method>();

		for (int i = 0; i < methods.length; i++) {
			Method method = methods[i];
			String methodName = method.getName();
			if (methodName.substring(0, 3).compareToIgnoreCase("set") == 0) {
				Class p[] = method.getParameterTypes();
				if (p.length == 1 && p[0].equals(String.class)) {
					map.put(methodName.substring(3), method);
				}
			}
		}
		for (int i = 0; i < methods.length; i++) {
			Method method = methods[i];
			String methodName = method.getName();
			if (methodName.substring(0, 3).compareToIgnoreCase("get") == 0) {
				Class p[] = method.getParameterTypes();
				if (p.length == 0) {
					try {
						if (method.invoke(o) == null) {
							Method setMethod = map.get(methodName.substring(3));
							if (setMethod != null) {
								setMethod.invoke(o, "");
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	/**
	 * 判断字符串是否为NULL和空串。
	 * 
	 * @param str
	 *            字符串
	 * @return boolean
	 */
	public static boolean isEmpty(String str) {
		return !notEmpty(str);
	}

	/**
	 * 判断字符串是否不为NULL和空串。
	 * 
	 * @param str
	 *            字符串
	 * @return boolean
	 */
	public static boolean notEmpty(String str) {
		return str != null && str.trim().length() > 0;
	}

	/**
	 * 把一个list里面的所有str元素用提供的分隔符参数分开。
	 * <p>
	 * list为空，则返回一个空串。
	 * 
	 * @param list
	 *            是Map的集合
	 * @param sep
	 *            length必须等于1
	 * @param key
	 *            是HMap中的id的key
	 * @return String
	 */
	public static String listToString(List list, String sep, String key) {
		StringBuffer sb = new StringBuffer();
		Object obj;
		Class clz;

		if (sep == null || sep.length() != 1) {
			sep = SEP;
		}
		if (key == null || key.trim().length() < 0) {
			clz = String.class;
		} else {
			clz = Map.class;
		}
		for (Iterator it = list.iterator(); it.hasNext();) {
			if (clz.equals(String.class)) {
				obj = it.next();
			} else {
				obj = ((Map) it.next()).get(key);
			}
			sb.append(NVL(obj)).append(sep);
		}

		if (sb.length() > 0) {
			sb = sb.deleteCharAt(sb.length() - 1);
		}

		return sb.toString();

	}

	/**
	 * 把一个list里面的所有str元素用提供的分隔符参数分开。
	 * <p>
	 * list为空，则返回一个空串。
	 * 
	 * @param list
	 *            list
	 * @param sep
	 *            length必须等于1。
	 * @return String
	 */
	public static String listToString(List list, String sep) {
		return listToString(list, sep, null);

	}

	/**
	 * 把一个list里面的所有str元素用SEP分隔符分开。
	 * <p>
	 * list为空，则返回一个空串。
	 * 
	 * @param list
	 *            list
	 * @return String
	 */
	public static String listToString(List list) {
		return listToString(list, SEP, null);
	}

	/**
	 * 在str中去除list中的所有id.
	 * <p>
	 * 
	 * @param str
	 *            是用逗号分隔的ids。比如：1,2,3,4
	 * @param list
	 *            是str的集合。
	 * @return String
	 */
	public static String stringExcepList(String str, List list) {
		str = SEP + str + SEP;
		String s;

		for (Iterator it = list.iterator(); it.hasNext();) {
			s = (String) it.next();
			s = SEP + s + SEP;
			str = str.replace(s, SEP);
		}

		if (str.length() > 2) {
			str = str.substring(1, str.length() - 1);
		} else {
			str = "";
		}

		return str;
	}

	/**
	 * 在str中去除list中的所有id.
	 * <p>
	 * 
	 * @param str
	 *            是用逗号分隔的ids。比如：1,2,3,4
	 * @param list
	 *            是Map的集合。
	 * @param key
	 *            是HMap中的id的key
	 * @return String
	 */
	public static String stringExcepList(String str, List list, String key) {
		str = SEP + str + SEP;
		Map hs;
		String s;

		for (Iterator it = list.iterator(); it.hasNext();) {
			hs = (Map) it.next();
			s = (String) hs.get(key);
			s = SEP + s + SEP;
			str = str.replace(s, SEP);
		}

		if (str.length() > 2) {
			str = str.substring(1, str.length() - 1);
		} else {
			str = "";
		}

		return str;
	}

	/**
	 * 將用逗號分割的ids中每個id用引號括起來。
	 * 
	 * @param ids
	 *            ids
	 * @return String
	 */
	public static String makeOracleNumberIdsToString(String ids) {
		String ret = null;

		if (ids == null || ids.length() <= 0) {
			return ret;
		}

		ids = SEP + ids + SEP;
		ids = ids.replaceAll(",", "','");
		ret = ids.substring(2, ids.length() - 2);

		return ret;
	}

	/**
	 * 在已知ids后面增加id
	 * 
	 * @param ids
	 *            ids
	 * @param id
	 *            id
	 * @return String
	 */
	public static String appendToIds(String ids, String id) {
		if (ids == null || ids.length() <= 0) {
			ids = id;
		} else {
			ids = ids + SEP + id;
		}

		return ids;
	}

	/**
	 * fit dont asistant this character"〜" +301C so change 〜 +301c to ～ +ff5e
	 * 
	 * @param str
	 *            str
	 * @return String
	 */
	public static String treatSpecialChar(String str) {
		if (str.indexOf(0x301C) >= 0) {
			str = str.replace((char) 0x301C, (char) 0xff5e);
		}
		return str;
	}

	/**
	 * "A：xxx" ->"xxx"
	 * 
	 * @param area
	 *            area
	 * @return String
	 */
	public static String formatAreaStr(String area) {
		if (area == null || area.equals("")) {
			return area;
		}
		if (area.indexOf("：") < 0) {
			return area;
		}
		area = area.substring(area.indexOf("：") + 1);
		return area;
	}

	/**
	 * NVL
	 * 
	 * @param
	 *            str
	 * @return String
	 */
	public static String NVL(Object str) {
		if (str == null) {
			return "";
		}
		return NVL(str.toString());
	}

	/**
	 * NVL
	 * 
	 * @param str
	 *            str
	 * @return String
	 */
	public static String NVL(String str) {
		if (str == null) {
			return "";
		}
		if (str.equals("null")) {
			return "";
		}
		if (str.equals("null|null")) {
			return "";
		}
		return str;
	}

	/**
	 * 判断一个字符串是否为double add by hanya
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isDouble(String str) {
		try {
			Double.valueOf(str);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	/**
	 * 将包含',"和\的符号转换为js能识别的字符串
	 * <p>
	 * 比如：'蒋经国"自述\ 转换为\'蒋经国\"自述\\
	 * 
	 * @param origin
	 * @return
	 */
	public static String transferMarks(String origin) {
		String transfed = null;
		if (null != origin && !"".equals(origin)) {
			transfed = origin.replace("\\", "\\\\").replace("'", "\\'")
					.replace("\"", "\\\"");
		}
		return transfed;
	}

	/**
	 * 比较两个str是相同
	 * 
	 * @param str1
	 * @param str2
	 * 
	 *            add by hanya
	 * @return
	 */
	public static boolean compare2Str(String str1, String str2) {
		if ((str1 == null || "".equals(str1))
				&& (str2 == null || "".equals(str2))) {
			return true;
		} else {
			if (str1 != null && str1.equals(str2)) {
				return true;
			} else {
				return false;
			}
		}
	}
	/**
	 * 获得一个去掉“-”符号的UUID
	 * @return String UUID
	 */
	public static String getUUID(){
		String s = UUID.randomUUID().toString();
		//去掉“-”符号
		return s.substring(0,8)+s.substring(9,13)+s.substring(14,18)+s.substring(19,23)+s.substring(24);
	}
     /**
	  * 生成随机编码
     */
	public static String getWarehouseCode(){
		return DateUtil.getNowTimeInMillis();
	}
	// 判断一个字符串是否含有中文
	public static boolean isChinese(String str) {
		if (str == null) return false;
		for (char c : str.toCharArray()) {
			if (isChinese(c)) return true;// 有一个中文字符就返回
		}
		return false;
	}
	// 判断一个字符是否是中文
	public static boolean isChinese(char c) {
		return c >= 0x4E00 &&  c <= 0x9FA5;// 根据字节码判断
	}

	/**
	 * 字符串处理：将"aaaa,bbbbb,cccc..."
	 * 处理成"('aaaa','bbbbb','cccc'...)"格式,
	 * 用于数据库查询
	 * @param str
	 * @return
	 */
	public static String dealStr(String str){
		if(StringUtil.isEmpty(str)){
			return "";
		}
		String[] arr = str.split(",");
		StringBuffer sb = new StringBuffer();
		sb.append("(");
		for (int i = 0; i < arr.length; i++) {
			if(i == arr.length - 1){
				sb.append("'"+arr[i]+"'");
			}else{
				sb.append("'"+arr[i]+"'" + ",");
			}
		}
		sb.append(")");
		return sb.toString();
	}
}
