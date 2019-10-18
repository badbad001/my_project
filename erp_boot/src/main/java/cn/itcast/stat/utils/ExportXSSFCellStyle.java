package cn.itcast.stat.utils;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * @Author: badbad
 * @Date: 2019/9/28 20:21
 * @Version 1.0
 */
public class ExportXSSFCellStyle {

    /**
     * 设置基础样式
     * @return
     */
    public static XSSFCellStyle createBaseStyle(XSSFWorkbook workbook){
        XSSFCellStyle cellStyle = workbook.createCellStyle();
        //设置水平居中  默认align是水平居中  Horizontal水平
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        //垂直居中    加个Vertical是垂直居中
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        //设置字体
        XSSFFont font = workbook.createFont();
        font.setFontName("微软雅黑");//设置字体

        cellStyle.setFont(font);
        return cellStyle;
    }

    /**
     * 创建数据项标题样式
     * @param workbook
     * @return
     */
    public static XSSFCellStyle createTableTitleStyle(XSSFWorkbook workbook){
        XSSFCellStyle cellStyle = createBaseStyle(workbook);

        //设置字体
        XSSFFont font = workbook.createFont();
        font.setBold(true);//设置粗体
        font.setItalic(true);//设置斜体
        font.setFontHeightInPoints((short)(12));//设置字体大小
        font.setFontName("微软雅黑");//设置字体

        cellStyle.setFont(font);

        return cellStyle;
    }

    /**
     * 创建小标题
     */
    public static XSSFCellStyle createSubTitleStyle(XSSFWorkbook workbook){
        //先设置基础样式
        XSSFCellStyle baseStyle = createBaseStyle(workbook);
        //设置字体
        XSSFFont font = workbook.createFont();
        //设置加粗
        font.setBold(true);
        //设置字体大小
        font.setFontHeightInPoints((short) 18);
        //设置颜色
        font.setColor(HSSFColor.HSSFColorPredefined.RED.getIndex());

        baseStyle.setFont(font);
        return baseStyle;
    }

    /**
     * 大标题样式
     * @param workbook
     * @return
     */
    public static XSSFCellStyle createTitleStyle(XSSFWorkbook workbook){
        //先设置基本样式
        XSSFCellStyle baseStyle = createBaseStyle(workbook);

        //设置字体
        XSSFFont font = workbook.createFont();
        font.setFontName("华为彩云");
        //设置颜色
        font.setColor(HSSFColor.HSSFColorPredefined.BLUE.getIndex());
        font.setFontHeightInPoints((short)22);

        baseStyle.setFont(font);

        return baseStyle;
    }
}
