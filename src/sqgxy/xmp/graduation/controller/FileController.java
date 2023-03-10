package sqgxy.xmp.graduation.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import sqgxy.xmp.graduation.entity.MidCheck;
import sqgxy.xmp.graduation.entity.Myfile;
import sqgxy.xmp.graduation.entity.OpenReport;
import sqgxy.xmp.graduation.entity.ProjBook;
import sqgxy.xmp.graduation.entity.SelectTitle;
import sqgxy.xmp.graduation.entity.Student;
import sqgxy.xmp.graduation.entity.Teacher;
import sqgxy.xmp.graduation.entity.Thesis;
import sqgxy.xmp.graduation.entity.ThesisAttachment;
import sqgxy.xmp.graduation.entity.Title;
import sqgxy.xmp.graduation.entity.User;
import sqgxy.xmp.graduation.service.MidCheckService;
import sqgxy.xmp.graduation.service.MyFileService;
import sqgxy.xmp.graduation.service.OpenReportService;
import sqgxy.xmp.graduation.service.ProjBookService;
import sqgxy.xmp.graduation.service.SelectTitleService;
import sqgxy.xmp.graduation.service.StudentService;
import sqgxy.xmp.graduation.service.TeacherService;
import sqgxy.xmp.graduation.service.ThesisAttachmentService;
import sqgxy.xmp.graduation.service.ThesisService;
import sqgxy.xmp.graduation.service.TitleService;
import sqgxy.xmp.graduation.utils.WordToPdf;

@Controller
public class FileController {
	@Autowired
	private MyFileService fileService;
	
	@Autowired
	private SelectTitleService selectTitleService;

	@Autowired
	private TeacherService teacherService;

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
	private StudentService studentService;

	@Autowired
	private TitleService titleService;
	
	@Autowired
	private MyFileService myFileService;
	
	
	

	/**
	 * ????????????????????????????????????????????????????????????????????????
	 */
	public String getFilename(HttpServletRequest request, String filename) throws Exception {
		// IE????????????User-Agent?????????????????????
		String[] IEBrowserKeyWords = { "MSIE", "Trident", "Edge" };
		// ???????????????????????????
		String userAgent = request.getHeader("User-Agent");
		for (String keyWord : IEBrowserKeyWords) {
			if (userAgent.contains(keyWord)) {
				// IE???????????????????????????UTF-8????????????
				return URLEncoder.encode(filename, "UTF-8");
			}
		}
		// ?????????????????????????????????ISO-8859-1????????????
		return new String(filename.getBytes("UTF-8"), "ISO-8859-1");
	}

	/**
	 * ????????????(pdf)
	 */
	@RequestMapping("/file/toPdfProjBook.action")
	public ModelAndView toPdfProjBook(Long num1, String num2) {
		Myfile file = fileService.toPdfProjBook(num1);
		Teacher teacher = teacherService.findTeacherById(num2);
		String fPath = file.getfPath();
		String fPath2 = StringUtils.substringBeforeLast(fPath, ".");
		fPath2 = fPath2 + ".pdf";
		System.out.println("?????????????????????pdf??????" + fPath2);
		File file2 = new File(fPath2);
		if(!file2.exists()) {
			WordToPdf w = new WordToPdf();
			w.wordToPDF(fPath, fPath2);
		}
		String f = file.getfName();
		f = f.substring(0, f.indexOf("."));
		f = f + ".pdf";
		String t = teacher.gettId();
		ModelAndView mv = new ModelAndView();
		mv.addObject("f", f);
		mv.addObject("t", t);
		System.out.println(f+t);
		mv.setViewName("views/pdf");
		return mv;
	}

	/**
	 * ????????????
	 */
	@RequestMapping("/file/filedown.action")
	public ResponseEntity<byte[]> downfile(HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String fId = request.getParameter("fId");
		ProjBook projBook = null;
		Myfile myfile = new Myfile();
		long l = Long.parseLong(fId);
		myfile = fileService.selectById(l);
		String filename = myfile.getfName();
		projBook = projBookService.findProjBookByfId(l);
		User user =(User) session.getAttribute("USER");
		String path = null;
		if(user.getRole().equals("??????")) {
			System.out.println("?????????");
			Student student = (Student) session.getAttribute("USER_INFO");
			List<ProjBook> list = projBookService.findProjBookList(projBook, (String) student.getsId());
			String tId = list.get(0).gettId();
			String tName = list.get(0).gettName();
			System.out.println(tId);
			System.out.println(tName);
			tName = tId;
			path = request.getServletContext().getRealPath("/upload/");
			path = path + tName + "\\";
		}
		else if(user.getRole().equals("??????")) {
			String tId = request.getParameter("tId");
			String tName = request.getParameter("tName");
			tName = tId;
			path = request.getServletContext().getRealPath("/upload/");
			path = path + tName + "\\";
		}
		System.out.println("????????? " + path);
		// ????????????????????????????????????
		ResponseEntity<byte[]> result = null;
		try {
			// ?????????????????????
			File file = new File(path + File.separator + filename);
			// ?????????????????????????????????????????????
			filename = this.getFilename(request, filename);
			// ???????????????
			HttpHeaders headers = new HttpHeaders();
			// ?????????????????????????????????????????????
			headers.setContentDispositionFormData("attachment", filename);
			// ?????????????????????????????????????????????
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			// ??????Sring MVC?????????ResponseEntity??????????????????????????????
			result = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script language=\"javascript\">alert('???????????????')</script>");
		} catch (IOException e) {
			e.printStackTrace();
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script language=\"javascript\">alert('???????????????')</script>");
		}
		return result;
	}

	/**
	 * ????????????
	 * @throws IOException 
	 */
	@RequestMapping("/file/fileUpload.action")
	public ModelAndView fileUpload(HttpSession session,HttpServletResponse response,
			@RequestParam("fType") String fType,
			@RequestParam("uploadfile") List<MultipartFile> uploadfile, HttpServletRequest request) throws IOException {
		Student student = (Student)session.getAttribute("USER_INFO");
		ModelAndView mv = new ModelAndView();
		mv.addObject("fType", fType);
		if(fType.equals("?????????")) {
			List<ProjBook> list = projBookService.findProjBookBysIdAndAgree(student.getsId(), "?????????");
			if(list.size()!=0) {
				mv.addObject("FAIL", "FAIL1");
				mv.setViewName("views/error");
				return mv;
			}
		}else if(fType.equals("????????????")) {
			List<OpenReport> list = openReportService.findOpenReportBysIdAndAgree(student.getsId(), "?????????");
			if(list.size()!=0) {
				mv.addObject("FAIL", "FAIL1");
				mv.setViewName("views/error");
				return mv;
			}
		}else if(fType.equals("????????????")) {
			List<MidCheck> list = midCheckService.findMidCheckBysIdAndAgree(student.getsId(), "?????????");
			if(list.size()!=0) {
				mv.addObject("FAIL", "FAIL1");
				mv.setViewName("views/error");
				return mv;
			}
		}else if(fType.equals("??????")) {
			List<Thesis> list = thesisService.findThesisBysIdAndAgree(student.getsId(), "?????????");
			if(list.size()!=0) {
				mv.addObject("FAIL", "FAIL1");
				mv.setViewName("views/error");
				return mv;
			}
		}else if(fType.equals("??????")) {

			List<ThesisAttachment> list = thesisAttachmentService.findThesisAttachmentBysId(student.getsId());
			if(list.size()!=0) {
				mv.addObject("FAIL", "FAIL1");
				mv.setViewName("views/error");
				return mv;
			}
		}
		student = studentService.findStudent(student.getsId(), student.getsPwd());
		Title title = titleService.findTitleBysId(student.getsId());
		String tId = title.gettId();
	//	String tName = title.gettName();
		String t = tId;
		String s = student.getsId() + student.getsName();
		s = s + fType;

		// ?????????????????????????????????
				if (!uploadfile.isEmpty() && uploadfile.size() > 0) {
					//???????????????????????????
					for (MultipartFile file : uploadfile) {
						String name1 = t;
						// ?????????????????????????????????
						String originalFilename = file.getOriginalFilename();
						System.out.println("??????????????????????????????: "+ originalFilename);
						int c = originalFilename.indexOf(".");
						String s1 = originalFilename.substring(c);
						String s2 = originalFilename.substring(0, c);
						s2 = s;
						originalFilename = s2 + s1;
						//???????????????????????????
						String dirPath = 
		                       request.getServletContext().getRealPath("/upload/"+name1);
						System.out.println(dirPath);
						File filePath = new File(dirPath);
						// ?????????????????????????????????????????????????????????
						if (!filePath.exists()) {
							filePath.mkdirs();
						}
						String newFilename = dirPath + "\\" + originalFilename;
						System.out.println("??????????????????" + newFilename +"\n");
						File filePath2 = new File(newFilename);
						int i = 0;
						String s3 = null;
						while(filePath2.exists()) {
							i++;
							s3 = s2+ "(" + String.valueOf(i) +")";
							originalFilename = s3 + s1;
		     				System.out.println("?????????????????????????????????: "+originalFilename);  //?????????
							newFilename = dirPath + "\\" + originalFilename;
							System.out.println("??????????????????: " +newFilename);
							filePath2 = new File(newFilename);
						}
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//??????????????????
						String nowtime = df.format(new Date());
				        System.out.println(nowtime);// new Date()???????????????????????????
						try {
							// ??????MultipartFile????????????????????????????????????????????????
							file.transferTo(new File(newFilename));
			//				String newFilenamePdf = s3 + ".pdf";
			//				System.out.println("?????????pdf????????????: "+ newFilenamePdf);
			//				newFilenamePdf = dirPath + "\\" + newFilenamePdf;
			//				System.out.println("?????????pdf????????????????????????: "+newFilenamePdf);
			//				WordToPdf w = new WordToPdf();
			//				w.wordToPDF(newFilename, newFilenamePdf);
							Myfile myfile = new Myfile();
							myfile.setfName(originalFilename);                           
							myfile.setfPath(newFilename);
							Date date = df.parse(nowtime);
							myfile.setUploadDatetime(date);
							myfile.setfType(fType);
							myFileService.createMyfile(myfile);
							if(fType.equals("?????????")) {
								ProjBook projBook = new ProjBook();
								projBook.setfId(myFileService.selectByfName(originalFilename).getfId());
								projBook.setsId(student.getsId());
								projBook.setAgree("?????????");
								projBookService.createProjBook(projBook);
							}else if(fType.equals("????????????")) {
								OpenReport openReport = new OpenReport();
								openReport.setfId(myFileService.selectByfName(originalFilename).getfId());
								openReport.setsId(student.getsId());
								openReport.setAgree("?????????");
								openReportService.createOpenReport(openReport);
							}else if(fType.equals("????????????")) {
								MidCheck midCheck = new MidCheck();
								midCheck.setfId(myFileService.selectByfName(originalFilename).getfId());
								midCheck.setsId(student.getsId());
								midCheck.setAgree("?????????");
								midCheckService.createMidCheck(midCheck);
							}else if(fType.equals("??????")) {
								SelectTitle selectTitle = selectTitleService.findSelTitleListBysIdAndState(student.getsId(),"??????").get(0);
								Thesis thesis = new Thesis();
								thesis.setfId(myFileService.selectByfName(originalFilename).getfId());
								thesis.setsId(student.getsId());
								thesis.setAgree("?????????");
								thesis.setTitlId(selectTitle.getTitlId());
								thesisService.createThesis(thesis);
							}else if(fType.equals("??????")) {
								ThesisAttachment thesisAttachment = new ThesisAttachment();
								thesisAttachment.setfId(myFileService.selectByfName(originalFilename).getfId());
								thesisAttachment.setsId(student.getsId());
								thesisAttachmentService.createThesisAttachment(thesisAttachment);
							}
							
						} catch (Exception e) {
							e.printStackTrace();
							mv.setViewName("views/error");
		                    return mv;
						}
					}
					// ?????????????????????
					mv.setViewName("views/success");
					return mv;
				}else{
					mv.setViewName("views/error");
                    return mv;
				}

	}
	
	/**
	 * ????????????
	 */
	@RequestMapping("/file/filedelete.action")
	@ResponseBody
	public String filedelete(HttpSession session,HttpServletRequest request ,Long fId) {
		Myfile myfile = fileService.selectById(fId);

		File file = new File(myfile.getfPath());
		if (file.isFile() && file.exists()) {
			file.delete();
		}
		int rows = fileService.delete(fId);
	    if(rows > 0){			
	        return "OK";
	    }else 
	    	return "FAIL";
	}

}
