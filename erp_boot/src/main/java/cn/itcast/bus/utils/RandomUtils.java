package cn.itcast.bus.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

/**
 * 随机工具类
 * @author LJH
 *
 */
public class RandomUtils {
	
	
	private static SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat sdf2=new SimpleDateFormat("yyyyMMddHHmmssSSS");
	private static Random random=new Random();
	
	/**
	 * 得到当前日期
	 */
	public static String getCurrentDateForString() {
		return sdf1.format(new Date());
	}
	
	
	/**
	 * 生成文件名使用时间+4位随机数
	 * @param
	 */
	public static String createFileNameUseTime(String fileName) {
		String fileSuffix=fileName.substring(fileName.lastIndexOf("."),fileName.length());
		String time=sdf2.format(new Date());
		Integer num=random.nextInt(9000)+1000;
		return time+num+fileSuffix;
	}

	/**
	 * 生成文件名使用时间+4位随机数和临时文件后缀的文件名
	 * @param
	 */
	public static String createFileNameUseTime(String fileName,String tempFileSuffix) {
		String fileSuffix=fileName.substring(fileName.lastIndexOf("."),fileName.length());
		String time=sdf2.format(new Date());
		Integer num=random.nextInt(9000)+1000;
		return time+num+fileSuffix+tempFileSuffix;
	}

	/**
	 * 生成文件名使用UUID
	 * @param
	 */
	public static String createFileNameUseUUID(String fileName) {
		String fileSuffix=fileName.substring(fileName.lastIndexOf("."),fileName.length());
		return UUID.randomUUID().toString().replace("-", "").toUpperCase()+fileSuffix;
	}
	
	public static void main(String[] args) {
		System.out.println(createFileNameUseUUID("fasdfasdfsda,a,ff.d,sfmslafsa.gif"));
		
	}

	/**
	 * 触犯一个出租单，加了前缀的
	 * @param
	 * @param
	 */
	public static String createStringUserTime(String prefix) {
		String timeName = sdf2.format(new Date());
		Integer num=random.nextInt(9000)+1000;
		return prefix+"_"+timeName+"_"+num;
	}
}
