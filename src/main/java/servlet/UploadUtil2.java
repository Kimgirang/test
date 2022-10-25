package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

public class UploadUtil2 {

	private String uploadPath;
	private ServletContext app;
	

	public static UploadUtil2 create(ServletContext app) {
		
		UploadUtil2 uploadUtil = new UploadUtil2();
		uploadUtil.setApp(app);
		uploadUtil.setUploadPath(app.getRealPath("/profilephoto")); // ImageFile이 있는 실제경로를 저장
		
		return uploadUtil;
	}
	
	private void setApp(ServletContext app) {
		this.app = app;
	}
	//실제 파일이 저장될 서블릿내부의 ImageFile폴더의 경로
	private void setUploadPath(String realPath) {
		this.uploadPath = realPath;
	}
	
	
	/* 파일 저장 */
	public String saveFiles(Part filePart, String ImageFolderPath, String memberId) {
		String realFileName = filePart.getSubmittedFileName(); //실제 파일 이름
		int extIndex = realFileName.lastIndexOf(".");
		String ext = realFileName.substring(extIndex);
		
		String saveFileName = memberId+ext;
		String realPath = this.uploadPath; 
		String filePath = realPath + File.separator+saveFileName;//저장될 실제 경로 + 파일이름
		
		try(
			InputStream fis = filePart.getInputStream();
			OutputStream fos = new FileOutputStream(filePath);)
		{
			byte[] buf = new byte[1024];
			int len = 0;
			while((len = fis.read(buf, 0, 1024)) != -1) {
				fos.write(buf, 0, len);
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
		
		System.out.println("=========UploadUtil=========");
		System.out.println("realPath : " + realPath);
		System.out.println("filePath : " + filePath);
		System.out.println("saveFileName : " + saveFileName);
		System.out.println("realFileName : " + realFileName);
		System.out.println("=========UploadUtil=========");
		
		return saveFileName; // 저장된 파일이름 리턴
	}
	
}