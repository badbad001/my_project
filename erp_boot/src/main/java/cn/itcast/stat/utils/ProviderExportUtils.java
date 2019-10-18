package cn.itcast.stat.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import cn.itcast.bus.pojo.Provider;

/**
 * @Author: badbad
 * @Date: 
 * @Version 1.0
 *
 * 供应商导出的工具类
 */
public class ProviderExportUtils {

    /**
     * 创建excel，把workbook写进内存流
     * @param list
     * @param sheetName
     * @return
     */
    public static ByteArrayOutputStream exportProvider(List<Provider> list, String sheetName) {
        //1.创建工作簿
        XSSFWorkbook workbook = new XSSFWorkbook();
        //2.创建表
        XSSFSheet sheet = workbook.createSheet(sheetName);
        //3.基本设置，和引入单元格样式
        sheet.setDefaultColumnWidth(20); //设置单元格长度20
        XSSFCellStyle baseStyle = ExportXSSFCellStyle.createBaseStyle(workbook);
        XSSFCellStyle tableTitleStyle = ExportXSSFCellStyle.createTableTitleStyle(workbook);
        XSSFCellStyle subTitleStyle = ExportXSSFCellStyle.createSubTitleStyle(workbook);
        XSSFCellStyle titleStyle = ExportXSSFCellStyle.createTitleStyle(workbook);
        //3.1合并单元格
        CellRangeAddress region = new CellRangeAddress(0, 0, 0, 10);
        CellRangeAddress region2 = new CellRangeAddress(1, 1, 0, 10);
        sheet.addMergedRegion(region);
        sheet.addMergedRegion(region2);

        //4.创建表的标题  第一行
        int index = 0;
        XSSFRow row1 = sheet.createRow(index);
        XSSFCell cell1 = row1.createCell(0);
        cell1.setCellValue("供应商数据表");
        cell1.setCellStyle(titleStyle);

        //5.创建小标题  第二行
        index++;
        XSSFRow row2 = sheet.createRow(index);
        XSSFCell cell2 = row2.createCell(0);
        cell2.setCellValue("一共"+list.size()+"条   导出时间:"+new Date().toLocaleString());
        cell2.setCellStyle(subTitleStyle);

        //6.创建数据表的标题  --第三行
        String[] titles = { "ID", "供应商名", "邮编","供应商地址","供应商电话", "联系人",
        		    "联系人手机号", "开户银行", "银行账号","邮箱","传真" };
        index ++;
        XSSFRow row3 = sheet.createRow(index);
        //6.1遍历数据，创建单元格，设置value,设置style
        for (int i = 0; i < titles.length; i++) {
            XSSFCell row3Cell = row3.createCell(i);
            row3Cell.setCellValue(titles[i]);
            row3Cell.setCellStyle(tableTitleStyle);
        }

        //7.遍历集合创建行写供应商信息
        for (int i = 0; i < list.size(); i++) {
            index ++;

            //创建行
            XSSFRow row = sheet.createRow(index);

            Provider provider = list.get(i);

            //7.1创建列供应商id
            XSSFCell row_id = row.createCell(0);
            row_id.setCellStyle(baseStyle);
            row_id.setCellValue(provider.getId());
            //7.2创建列供应商姓名
            XSSFCell row_Providername = row.createCell(1);
            row_Providername.setCellStyle(baseStyle);
            row_Providername.setCellValue(provider.getProvidername());
            
            //7.3创建列 邮编
            XSSFCell row_zip = row.createCell(2);
            row_zip.setCellStyle(baseStyle);
            row_zip.setCellValue(provider.getZip());
            //7.4创建列供应商地址
            XSSFCell row_address= row.createCell(3);
            row_address.setCellStyle(baseStyle);
            row_address.setCellValue(provider.getAddress());
            //7.5创建列供应商手机
            XSSFCell row_telephone = row.createCell(4);
            row_telephone.setCellStyle(baseStyle);
            row_telephone.setCellValue(provider.getTelephone());
            //7.6创建列联系人
            XSSFCell row_Connectionperson = row.createCell(5);
            row_Connectionperson.setCellStyle(baseStyle);
            row_Connectionperson.setCellValue(provider.getConnectionperson());
            //7.7创建列联系人手机号
            XSSFCell row_phone = row.createCell(6);
            row_phone.setCellStyle(baseStyle);
            row_phone.setCellValue(provider.getPhone());
            //7.8创建列开户银行
            XSSFCell row_bank = row.createCell(7);
            row_bank.setCellStyle(baseStyle);
            row_bank.setCellValue(provider.getBank());
            //7.9创建列开户银行卡号
            XSSFCell row_account = row.createCell(8);
            row_account.setCellStyle(baseStyle);
            row_account.setCellValue(provider.getAccount());
            //7.10创建列邮箱
            XSSFCell row_email = row.createCell(9);
            row_email.setCellStyle(baseStyle);
            row_email.setCellValue(provider.getEmail());
            //7.11创建列传真
            XSSFCell row_fax = row.createCell(10);
            row_fax.setCellStyle(baseStyle);
            row_fax.setCellValue(provider.getFax());
            
   
        }

        //8.把数据写到内存流
        ByteArrayOutputStream os = new ByteArrayOutputStream();

        try {
             workbook.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return os;
    }
}
