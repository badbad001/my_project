package cn.itcast.sys.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import cn.itcast.sys.pojo.Technology;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 超极本
 * @since 2019-10-12
 */
public interface TechnologyMapper extends BaseMapper<Technology> {

	//查询用户技术的id集合
	List<Integer> queryUserTechnologyByUid(Integer id);

	//删除用户技术中间表数据
	void deleteUserTechnologyByUid(Integer id);

	//分配用户技术
	void addUserTechnology(@Param("uid") Integer uid, @Param("tid") Integer tid);

}
