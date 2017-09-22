package cn.lgq.mm.dao;

import cn.lgq.mm.model.Admin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Ligq on 2017/9/15.
 */
@Mapper
public interface AdminMapper {

    Admin getAdmin(Long id);

    List<Admin> getAdminNames(Long... id);

    Admin getAdminByName(String name);

    List<Admin> findAdmins(@Param("name") String name, @Param("type") Integer type,
                           @Param("offset") Integer offset, @Param("limit") Integer limit);

    int countAdmins(@Param("name") String name, @Param("type") Integer type);

    void addAdmin(Admin admin);

    void updateAdmin(Admin admin);
}
