package cn.itcast.config;

import org.activiti.spring.SpringProcessEngineConfiguration;
import org.activiti.spring.boot.ProcessEngineConfigurationConfigurer;
import org.springframework.stereotype.Component;

@Component
public class ActivitiConfig implements ProcessEngineConfigurationConfigurer {
 
	@Override
    public void configure(SpringProcessEngineConfiguration processEngineConfiguration) {
    	    	    
		//这个不会生成activiti5自己的用户表
        processEngineConfiguration.setDbIdentityUsed(false);
        
	    //flase： 默认值。activiti在启动时，会对比数据库表中保存的版本，如果没有表或者版本不匹配，将抛出异常。
	   	//(*)true： activiti会对数据库中所有表进行更新操作。如果表不存在，则自动创建。
	   	//	create_drop： 在activiti启动时创建表，在关闭时删除表（必须手动关闭引擎，才能删除表）。
	   	// (*)drop-create： 在activiti启动时删除原来的旧表，然后在创建新表（不需要手动关闭引擎）。
        //这个就是我们配置的设置
        processEngineConfiguration.setDatabaseSchemaUpdate("true");
    }
    
}