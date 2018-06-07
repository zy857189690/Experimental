package com.bitnei.cloud;

import com.bitnei.cloud.common.ConnectionGdApi;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class BqczReportApplicationTests {


	/**
	 * 测试地理位置缓存方法
	 */
	@Test
	public void test(){
		String json = ConnectionGdApi.getAddress("116.405256","39.928917");
		System.out.println(json);
	}
}
