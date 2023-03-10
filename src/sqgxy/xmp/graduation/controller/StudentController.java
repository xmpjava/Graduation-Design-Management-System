package sqgxy.xmp.graduation.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import sqgxy.xmp.graduation.entity.MidCheck;
import sqgxy.xmp.graduation.entity.OpenReport;
import sqgxy.xmp.graduation.entity.ProjBook;
import sqgxy.xmp.graduation.entity.ScoreProportion;
import sqgxy.xmp.graduation.entity.SelectTitle;
import sqgxy.xmp.graduation.entity.Student;
import sqgxy.xmp.graduation.entity.Teacher;
import sqgxy.xmp.graduation.entity.Thesis;
import sqgxy.xmp.graduation.entity.ThesisAttachment;
import sqgxy.xmp.graduation.entity.Title;
import sqgxy.xmp.graduation.service.MidCheckService;
import sqgxy.xmp.graduation.service.OpenReportService;
import sqgxy.xmp.graduation.service.ProjBookService;
import sqgxy.xmp.graduation.service.ScoreProportionService;
import sqgxy.xmp.graduation.service.SelectTitleService;
import sqgxy.xmp.graduation.service.StudentService;
import sqgxy.xmp.graduation.service.TeacherService;
import sqgxy.xmp.graduation.service.ThesisAttachmentService;
import sqgxy.xmp.graduation.service.ThesisService;
import sqgxy.xmp.graduation.service.TitleService;

@Controller
public class StudentController {
	
	private static final int PAGE_SIZE = 5;

	@Autowired
	private StudentService studentService;
	
	@Autowired
	private TitleService titleService;
	@Autowired
	private TeacherService teacherService;
	
	@Autowired
	private SelectTitleService selectTitleService;
	
	@Autowired
	private ProjBookService projBookService;
	
	@Autowired
	private OpenReportService openReportService;
	
	@Autowired
	private MidCheckService midCheckService;
	
	@Autowired
	private ThesisService thesisService;
	
	@Autowired
	private ThesisAttachmentService thesisAttachmentService;
	
	@Autowired
	private ScoreProportionService scoreProportionService;
	
	/**
	 * ????????????????????????
	 */
	@RequestMapping(value = "/student/toindex.action", method = RequestMethod.GET)
	public ModelAndView toIndex(HttpSession session) {
		Student student = (Student)session.getAttribute("USER_INFO");
		int sum = titleService.findTitleSum(student.getMajor(),"?????????");
		int s = selectTitleService.findSelTitleListByState(student.getMajor(),"??????");
		int s1 = selectTitleService.findSelTitleListByState(student.getMajor(),"?????????");
		ModelAndView mv = new ModelAndView();
		mv.addObject("sum", sum);
		mv.addObject("s", s);
		mv.addObject("s1", s1);
		mv.setViewName("views/user/student/index");
	    return mv;
	}
	
	/**
	 * ?????????????????????????????????(??????)
	 */
	@RequestMapping(value = "/student/topersonInfo.action")
	public String topersonInfo(HttpSession session) {
		Student student = (Student)session.getAttribute("USER_INFO");
		student = studentService.findStudent(student.getsId(), student.getsPwd());
		session.setAttribute("USER_INFO", student);
		return "views/user/student/personInfo";
	}
	
	
	
	/**
	 * ??????????????????
	 */
	@RequestMapping(value = "/student/editInfo.action")
	@ResponseBody
	public String editInfo(Student student) {
		int rows =0;
		try{
			rows = studentService.editInfo(student);
			}catch(Exception e){
				rows =0;
			}
		if(rows > 0){
	    	System.out.println("OK");
	        return "OK";
	    }else{
	    	System.out.println("FAIL");
	        return "FAIL";
	    }
	}
	
	/**
	 * ???????????????????????????(??????)
	 */
	@RequestMapping(value = "/student/toeditPwd.action")
	public String toeditPwd(HttpSession session) {
		Student student = (Student)session.getAttribute("USER_INFO");
		student = studentService.findStudentById(student.getsId());
		session.setAttribute("USER_INFO", student);
		return "views/user/student/editPwd";
	}
	
	/**
	 * ??????????????????
	 */
	@RequestMapping(value = "/student/editPwd.action")
	@ResponseBody
	public String editPwd(Student student) {
		int rows =0;
		try{
			rows = studentService.editInfo(student);
			}catch(Exception e){
				rows =0;
			}
		if(rows > 0){
	        return "OK";
	    }else{
	        return "FAIL";
	    }
	}
	
	/**
	 * ?????????????????????(??????)
	 */
	@RequestMapping(value = "/student/totitlelist.action")
	public ModelAndView totitlelist(HttpSession session, @ModelAttribute("title") Title title,
			                                               @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		// pageNo ??????      pageSize ???????????????
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Student student = (Student)session.getAttribute("USER_INFO");
		List<Title>list = titleService.findTitleListByMajor(title ,(String)student.getMajor());
		PageInfo<Title> pageInfo = new PageInfo<>(list,5);
		ModelAndView mv = new ModelAndView();
		mv.addObject("title", title);
		mv.addObject("pageInfo", pageInfo);
		mv.setViewName("views/user/student/titlelist");
		return mv;
	}
	
	/**
	 * ??????????????????ById(??????)
	 */
	@RequestMapping("/student/getTitleInfoById.action")
	@ResponseBody
	public Title getTitleInfoById(Long titlId) {
	    Title titleInfo = titleService.findTitleById(titlId);
	    System.out.println(titleInfo.getMajor());
	    return titleInfo;
	}

	/**
	 * ????????????(??????)
	 */
	@RequestMapping("/student/selecttitle.action")
	@ResponseBody
	public String Selecttitle(HttpSession session, SelectTitle selectTitle) {
		Student student = (Student)session.getAttribute("USER_INFO");
		selectTitle.setsId(student.getsId());
		SelectTitle result = selectTitleService.getSelectTitle(selectTitle);
		if(result!=null) {
			return "FAIL1";
		}
		Title title = new Title();
		title.setTitlId(selectTitle.getTitlId());
		List<SelectTitle> list = selectTitleService.findSelTitleListBysIdAndState(student.getsId(), "?????????");
		if(list.size()!=0) {
			return "FAIL4" ;
		}
		list = selectTitleService.findSelTitleListBysIdAndState(student.getsId(), "??????");
		if(list.size()!=0) {
			return "FAIL2" ;
		}
		else {
			int rows = 0;
			try{
				selectTitle.setSeltitlState("?????????");
				rows = selectTitleService.createSelectTitle(selectTitle);
				}catch(Exception e){
					rows = 0;
				}
			if(rows > 0){
				System.out.println("??????????????????????????????");
		        return "OK";
		    }else{
		    	System.out.println("??????????????????????????????");
		    	return "FAIL3";
		    }
		}
	}
	
	/**
	 * ??????????????????(??????)
	 */
	@RequestMapping("/student/selTitleById.action")
	@ResponseBody
	public ModelAndView selTitleById(HttpSession session, @ModelAttribute("title") Title title,
                                                          @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
        // pageNo ??????      pageSize ???????????????
        PageHelper.startPage(pageNum, PAGE_SIZE);
        Student student = (Student)session.getAttribute("USER_INFO");
        List<Title>list = titleService.findTitleList(title, (String)student.getsId());
        PageInfo<Title> pageInfo = new PageInfo<>(list,5);
        ModelAndView mv = new ModelAndView();
        List<Teacher> list1 = teacherService.findTeacherBydept(student.getDept());
        int i = selectTitleService.findSelTitle(student.getsId());
        mv.addObject("title", title);
        mv.addObject("i", i);
        mv.addObject("Teacher", list1);
        mv.addObject("pageInfo", pageInfo);
        mv.setViewName("views/user/student/selecttitlelist");
        return mv;
	}
	
	/**
	 * ??????????????????(????????????)
	 */
	@RequestMapping("/student/delTitleInfoById.action")
	@ResponseBody
	public String delTitleInfoById(HttpSession session ,Long id) {
		Student student = (Student)session.getAttribute("USER_INFO");
	    int rows = selectTitleService.deleteCustomer(id,(String)student.getsId());
	    if(rows > 0){	
	    	Title title = new Title();
			title.setTitlId(id);
			if(titleService.findTitleById(id).getTitlState().equals("?????????????????????")) {
				titleService.deleteTitle(id);
			}
			else {
				title.setSelState("????????????");
				titleService.updateTitleSelStateById(title);
			}
	        return "OK";
	    }else{
	        return "FAIL";			
	    }
	}
	
	/**
	 * ?????????????????????(??????)
	 */
	@RequestMapping("/student/projBooklist.action")
	public ModelAndView projBooklist(HttpSession session ,@ModelAttribute("projBook") ProjBook projBook ,
			                                              @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Student student = (Student)session.getAttribute("USER_INFO");
		List<ProjBook>list = projBookService.findProjBookList(projBook, (String)student.getsId());
		int i = selectTitleService.findSelectTitle(student.getsId());
		List<ProjBook> list2 = projBookService.findProjBookBysIdAndAgree(student.getsId(), "??????");
		int i2 = 0;
		if(list2.size()!=0) {
			i2 = 1;
		}
		PageInfo<ProjBook> pageInfo = new PageInfo<>(list,5);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.addObject("i", i);
        mv.addObject("i2", i2);
        mv.setViewName("views/user/student/projbooklist");
		return mv;
	}
	
	
	/**
	 * ????????????????????????(??????)
	 */
	@RequestMapping("/student/openReportlist.action")
	public ModelAndView openReportlist(HttpSession session ,@ModelAttribute("openReport") OpenReport openReport ,
			                                              @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Student student = (Student)session.getAttribute("USER_INFO");
		List<OpenReport>list = openReportService.findOpenReportList(openReport, (String)student.getsId());
		List<ProjBook> list2 = projBookService.findProjBookBysIdAndAgree(student.getsId(), "??????");
		List<OpenReport> list3 = openReportService.findOpenReportBysIdAndAgree(student.getsId(), "??????");
		int i = 0;
		int i2 = 0;
		if(list2.size()!=0) {
			i = 1;
		}
		if(list3.size()!=0) {
			i2 = 1;
		}
		PageInfo<OpenReport> pageInfo = new PageInfo<>(list,5);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.addObject("i", i);
        mv.addObject("i2", i2);
        mv.setViewName("views/user/student/openReportlist");
		return mv;
	}
	
	/**
	 * ????????????????????????(??????)
	 */
	@RequestMapping("/student/midChecklist.action")
	public ModelAndView midChecklist(HttpSession session ,@ModelAttribute("midCheck") MidCheck midCheck ,
			                                              @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Student student = (Student)session.getAttribute("USER_INFO");
		List<MidCheck>list = midCheckService.findMidCheckList(midCheck, (String)student.getsId());
		List<OpenReport> list2 = openReportService.findOpenReportBysIdAndAgree(student.getsId(), "??????");
		List<MidCheck> list3 = midCheckService.findMidCheckBysIdAndAgree(student.getsId(), "??????");
		int i = 0;
		int i2 = 0;
		if(list2.size()!=0) {
			i = 1;
		}
		if(list3.size()!=0) {
			i2 = 1;
		}
		PageInfo<MidCheck> pageInfo = new PageInfo<>(list,5);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.addObject("i", i);
        mv.addObject("i2", i2);
        mv.setViewName("views/user/student/midchecklist");
		return mv;
	}
	
	/**
	 * ??????????????????(??????)
	 */
	@RequestMapping("/student/thesislist.action")
	public ModelAndView thesislist(HttpSession session ,@ModelAttribute("thesis") Thesis thesis ,
			                                              @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Student student = (Student)session.getAttribute("USER_INFO");
		List<Thesis>list = thesisService.findThesisList(thesis, (String)student.getsId());
		List<MidCheck> list2 = midCheckService.findMidCheckBysIdAndAgree(student.getsId(), "??????");
		List<Thesis> list3 = thesisService.findThesisBysIdAndAgree(student.getsId(), "??????");
		int i = 0;
		int i2 = 0;
		if(list2.size()!=0) {
			i = 1;
		}
		if(list3.size()!=0) {
			i2 = 1;
		}
		PageInfo<Thesis> pageInfo = new PageInfo<>(list,5);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.addObject("i", i);
        mv.addObject("i2", i2);
        mv.setViewName("views/user/student/thesislist");
		return mv;
	}
	
	/**
	 * ????????????(??????)
	 */
	@RequestMapping("/student/thesisAttachmentlist.action")
	public ModelAndView thesisAttachmentlist(HttpSession session ,@ModelAttribute("thesisAttachment") ThesisAttachment thesisAttachment ,
			                                              @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Student student = (Student)session.getAttribute("USER_INFO");
		List<ThesisAttachment>list = thesisAttachmentService.findThesisAttachmentList(thesisAttachment, (String)student.getsId());
		List<Thesis> list3 = thesisService.findThesisBysIdAndAgree(student.getsId(), "??????");
		int i2 = 0;
		if(list3.size()!=0) {
			i2 = 1;
		}
		PageInfo<ThesisAttachment> pageInfo = new PageInfo<>(list,5);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.addObject("i2", i2);
        mv.setViewName("views/user/student/thesisAttachmentlist");
		return mv;
	}
	
	/**
	 * ????????????(??????)
	 */
	@RequestMapping("/student/studentScore.action")
	public ModelAndView studentScore (HttpSession session,@RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum){
		Student student = (Student)session.getAttribute("USER_INFO");
		List<SelectTitle> list = selectTitleService.findSelTitleListBysIdAndState(student.getsId(), "??????");
		ScoreProportion scoreProportion = scoreProportionService.getScoreProportion("1");
		ModelAndView mv = new ModelAndView();
		PageInfo<SelectTitle> pageInfo = new PageInfo<>(list,5);
		mv.addObject("pageInfo", pageInfo);
		mv.addObject("scoreProportion", scoreProportion);
		mv.setViewName("views/user/student/studentscore");
		return mv;
	}
	
}
