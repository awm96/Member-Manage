package cn.lgq.mm.service;

import cn.lgq.mm.dao.AdminMapper;
import cn.lgq.mm.model.Admin;
import cn.lgq.mm.vo.Page;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Ligq on 2017/9/15.
 */
@Service
public class AdminService {

    @Autowired
    private AdminMapper mapper;

    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Admin getAdmin(Long id) {
        return mapper.getAdmin(id);
    }

    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Admin getAdminByName(String name) {
        return mapper.getAdminByName(name);
    }

    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Page<Admin> findAdmins(String name, Integer type, Integer pageNo, Integer pageSize) {
        Page<Admin> page = new Page<>();
        page.setPageNo(pageNo);
        page.setLimit(pageSize);
        List<Admin> list = mapper.findAdmins(name, type, page.getOffset(), page.getLimit());
        int count = mapper.countAdmins(name, type);
        page.setTotalRows(count);
        page.setResultList(list);
        return page;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void addAdmin(Admin admin) {
        mapper.addAdmin(admin);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void updateAdmin(Admin admin) {
        mapper.updateAdmin(admin);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void deleteAdmin(Long adminId) {
        mapper.deleteAdmin(adminId);
    }
}
