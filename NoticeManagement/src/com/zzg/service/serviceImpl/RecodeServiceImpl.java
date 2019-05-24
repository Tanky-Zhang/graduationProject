package com.zzg.service.serviceImpl;
import com.zzg.mapper.RecodeMapper;
import com.zzg.service.RecodeService;
import com.zzg.utils.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class RecodeServiceImpl implements RecodeService {

    @Autowired
    private RecodeMapper recodeMapper;

    @Override
    public List getList(String name, PageBean pageBean) {

        //int start=(pageBean.getCurrentPage()-1)*pageBean.getPageSize();

        Integer count = recodeMapper.getCount(name);

        if (pageBean.getPageSize()==null){pageBean.setPageSize(count);pageBean.setCurrentPage(0);}

        List<Map> list=recodeMapper.getList(name,pageBean.getCurrentPage(),pageBean.getPageSize());


        pageBean.setTotal(count);

        pageBean.setRows(list);

        return pageBean;

    }

    @Override
    public void saveMessage(Map map) {


        recodeMapper.saveMessage(map);
    }

    @Override
    public void delMessage(String sidstr) {

        String[] ids=sidstr.split(",");

        recodeMapper.delMessage(ids);
    }

    @Override
    public List getMessage(String sid) {
        return recodeMapper.getMessage(sid);
    }

    @Override
    public void editMessage(Map map) {
        recodeMapper.editMessage(map);
    }

    @Override
    public Map<String, Object> getStudentByid(String sid) {
        return recodeMapper.getStudentByid(sid);
    }
}
