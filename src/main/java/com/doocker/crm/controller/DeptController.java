package com.doocker.crm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.doocker.crm.po.Dept;
import com.doocker.crm.service.DeptService;
import com.github.pagehelper.PageInfo;
/**
 * 处理部门的控制器
 * @author Administrator  dulong 
 */
@Controller
@RequestMapping("dept")
public class DeptController {
	
	@Autowired
	private DeptService deptService;
	
	@RequestMapping("get")
	//作用是反悔的dept对象转化为json
	@ResponseBody
	public Dept getDept(Integer id){
		return deptService.getDept(id);
	}
	
	
	@RequestMapping("list")
	@ResponseBody
	public PageInfo<Dept> listDept(
			//@RequestParam(value="deptname" 指的是表单中的name 
			//             ,required=false  这个参数是否必须,
			//				defaultValue="1" 此参数的默认值)
			@RequestParam(value="deptname",required=false)String deptName,
			@RequestParam(value="page",defaultValue="1")Integer page,
			@RequestParam(value="rows",defaultValue="3")Integer rows
			){
		PageInfo<Dept> list = new PageInfo<Dept>();
		System.out.println("111");
		System.out.println("111");
		System.out.println("111");
		System.out.println("111");
		System.out.println("111");
		System.out.println("111");
		System.out.println("111");
		try{
			list = deptService.selectListByPage(deptName,page,rows);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
		
	}

}
