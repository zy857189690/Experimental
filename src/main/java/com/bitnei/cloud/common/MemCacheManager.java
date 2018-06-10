
package com.bitnei.cloud.common;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 缓存池管理
 * @see com.bitnei.cloud.common.MemCacheManager
 * @author LiuFei
 */
public class MemCacheManager {
	private static MemCacheManager mcm = new MemCacheManager();
	private static Map<String, Object> mcc = new ConcurrentHashMap<String, Object>();
	private AutoClearCache acc = new AutoClearCache();
	protected MemCacheManager(){
		acc.start();
	}

	public static MemCacheManager getInstance(){
		return mcm;
	}

	public void set(String key, Object value){
		mcc.put(key, value);
	}

	public boolean add(String key, Object value){
		if(mcc.containsKey(key)){
			return false;
		}
		mcc.put(key, value);
		return true;
	}

	public void remove(String key){
		mcc.remove(key);
	}

    public Object get(String key) {
        return mcc.get(key);
    }

    private Set<String> keySet(){
    	return mcc.keySet();
    }

    public void clearBy(String key){
    	Set<String> keys = mcc.keySet();
    	if(keys != null){
    		Iterator<String> itKey = keys.iterator();
    		while(itKey.hasNext()){
    			String keyT = itKey.next();
    			if(keyT.equals(key) || (keyT.indexOf("_") != -1 && keyT.indexOf(key) != -1)){
    				System.out.println("####清除缓存："+keyT);
    				mcc.remove(keyT);
    			}
    		}
    	}
    }

    private class AutoClearCache extends Thread{
    	private int timeout = 60*60;
    	public AutoClearCache(){
    	}
    	@Override
    	public void run(){
    		while(true){
				try {
					Set<String> keys = keySet();
					if(keys != null){
						Iterator<String> itKey = keys.iterator();
						HashMap sidMap=new HashMap();
						while(itKey.hasNext()){
							String key = itKey.next();
							System.out.println("key:"+key+", key的长度为："+key.length());
							if(key.equals("vehchecksInfo")){
								Date requesttime = (Date)get(key+"_time");
								long gap = ((new Date().getTime())-requesttime.getTime())/1000;
								if(gap >= timeout){
									clearLikeBy(key);
									MemCacheManager mcc = MemCacheManager.getInstance();
									//mcc.initheckNoVehInfo();
								}
							}else if(key.endsWith("InstantVeh")){
								String sid=key.replaceAll("InstantVeh","");
								sidMap.put(sid,sid);
							}
						}
						if(sidMap!=null && sidMap.size()>0){
							clearSessionIDCache(sidMap);
						}
					}
					Thread.sleep(1000*60*20);
				} catch (InterruptedException e) {
					continue;
				}
    		}
    	}
    }



	public void clearLikeBy(String key){
		Set<String> keys = mcc.keySet();
		if(keys != null){
			Iterator<String> itKey = keys.iterator();
			while(itKey.hasNext()){
				String keyT = itKey.next();
				if(keyT.endsWith(key) || keyT.startsWith(key) ){
					System.out.println("####清除缓存："+keyT);
					mcc.remove(keyT);
				}
			}
		}
	}

/*	public  void  initheckNoVehInfo(){
		Map<String, Object> paramMap=new HashMap<String,Object>();
		DataStatisticsService dataStatisticsService= (DataStatisticsService) SpringContextUtil.getBean("dataStatisticsService");
		List<Map<String, Object>> map=dataStatisticsService.getsvehchecksInfo(paramMap);
		boolean vehInfo= this.add("vehchecksInfo", map);
		boolean vehInfoTime=this.add("vehchecksInfo_time", new Date());
		if(vehInfo && vehInfoTime){
            System.out.println("#### 初始化成功！！！");
		}else{
			System.out.println("#### ！！！");
			clearLikeBy("vehchecksInfo");
		}
	}*/

	public void clearSessionIDCache(Map m){
		RequestAttributes ra = RequestContextHolder.getRequestAttributes();
		ServletRequestAttributes sra = (ServletRequestAttributes)ra;
		HttpServletRequest request = sra.getRequest();
		Enumeration e = request.getSession().getAttributeNames();
		HashMap<String,String>  sid=new HashMap<>();
		while( e.hasMoreElements()) {
			sid.put(request.getSession().getId(),request.getSession().getId());
		}
		Set<String> keys = m.keySet();
		Iterator<String> itKey = keys.iterator();
		while(itKey.hasNext()){
			String keyT = itKey.next();
			String key=keyT+"InstantVeh";
			if(sid!=null && sid.size()>0){
				if(!sid.containsKey(keyT)) {
					System.out.println("####清除动态数据核查缓存："+key);
					mcc.remove(key);
				}
			}else{
				System.out.println("####清除动态数据核查缓存："+key);
				mcc.remove(key);
			}
		}

	}

}



