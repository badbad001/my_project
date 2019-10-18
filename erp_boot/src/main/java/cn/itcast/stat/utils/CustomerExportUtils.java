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

import cn.itcast.bus.pojo.Customer;


/**
 * 客户导出的工具类
 * @author 超极本
 *
 */
public class CustomerExportUtils {

    /**
     * 创建excel，把workbook写进内存流
     * @param list
     * @param sheetName
     * @return
     */
    public static ByteArrayOutputStream exportCustomer(List<Customer> list, String sheetName) {
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
        cell1.setCellValue("客户数据表");
        cell1.setCellStyle(titleStyle);

        //5.创建小标题  第二行
        index++;
        XSSFRow row2 = sheet.createRow(index);
        XSSFCell cell2 = row2.createCell(0);
        cell2.setCellValue("一共"+list.size()+"条   导出时间:"+new Date().toLocaleString());
        cell2.setCellStyle(subTitleStyle);

        //6.创建数据表的标题  --第三行
        String[] titles = { "ID", "客户名", "邮编","客户地址","客户电话", "联系人",
        		    "联系人手机号", "开户银行", "银行账号","邮箱","传真" };
        index ++;
        XSSFRow row3 = sheet.createRow(index);
        //6.1遍历数据，创建单元格，设置value,设置style
        for (int i = 0; i < titles.length; i++) {
            XSSFCell row3Cell = row3.createCell(i);
            row3Cell.setCellValue(titles[i]);
            row3Cell.setCellStyle(tableTitleStyle);
        }

        //7.遍历集合创建行写客户信息
        for (int i = 0; i < list.size(); i++) {
            index ++;

            //创建行
            XSSFRow row = sheet.createRow(index);

            Customer customer = list.get(i);

            //7.1创建列客户id
            XSSFCell row_id = row.createCell(0);
            row_id.setCellStyle(baseStyle);
            row_id.setCellValue(customer.getId());
            //7.2创建列客户姓名
            XSSFCell row_custname = row.createCell(1);
            row_custname.setCellStyle(baseStyle);
            row_custname.setCellValue(customer.getCustomername());
            
            //7.3创建列 邮编
            XSSFCell row_zip = row.createCell(2);
            row_zip.setCellStyle(baseStyle);
            row_zip.setCellValue(customer.getZip());
            //7.4创建列客户地址
            XSSFCell row_address= row.createCell(3);
            row_address.setCellStyle(baseStyle);
            row_address.setCellValue(customer.getAddress());
            //7.5创建列客户手机
            XSSFCell row_telephone = row.createCell(4);
            row_telephone.setCellStyle(baseStyle);
            row_telephone.setCellValue(customer.getTelephone());
            //7.6创建列联系人
            XSSFCell row_Connectionperson = row.createCell(5);
            row_Connectionperson.setCellStyle(baseStyle);
            row_Connectionperson.setCellValue(customer.getConnectionperson());
            //7.7创建列联系人手机号
            XSSFCell row_phone = row.createCell(6);
            row_phone.setCellStyle(baseStyle);
            row_phone.setCellValue(customer.getPhone());
            //7.8创建列开户银行
            XSSFCell row_bank = row.createCell(7);
            row_bank.setCellStyle(baseStyle);
            row_bank.setCellValue(customer.getBank());
            //7.9创建列开户银行卡号
            XSSFCell row_account = row.createCell(8);
            row_account.setCellStyle(baseStyle);
            row_account.setCellValue(customer.getAccount());
            //7.10创建列邮箱
            XSSFCell row_email = row.createCell(9);
            row_email.setCellStyle(baseStyle);
            row_email.setCellValue(customer.getEmail());
            //7.11创建列传真
            XSSFCell row_fax = row.createCell(10);
            row_fax.setCellStyle(baseStyle);
            row_fax.setCellValue(customer.getFax());
            
   
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
