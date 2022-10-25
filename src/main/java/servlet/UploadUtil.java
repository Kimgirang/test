package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletContext;
import javax.servlet.http.Part;

public class UploadUtil {

	private String uploadPath;
	private ServletContext app;
	
	/* 생성 메서드 */
//	인자로 Application 레이어에 해당하는 객체만 주어지만 알아서 객체 속성이 설정되어 만들어지므로 편하다
	//static 이 아니면 UploadUtil uploadUtil = new UploadUtil();
	//uploadUtil.setAapp(app); ... 이런식으로 setter를 또 해줘야 한다
	public static UploadUtil create(ServletContext app) {
		
		UploadUtil uploadUtil = new UploadUtil();
		uploadUtil.setApp(app);
		uploadUtil.setUploadPath(app.getRealPath("/ImageFile")); // /ImageFile이 있는 실제경로를 저장
		
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
	// createFilePath로 만든 result == folderPath /년/월/일 폴더 경로
	public String saveFiles(Part filePart, String folderPath) {
		String realFileName = filePart.getSubmittedFileName(); //실제 파일 이름
		int extIndex = realFileName.lastIndexOf(".");
		String ext = realFileName.substring(extIndex);
		
		String saveFileName = createFileName()+ext;
		String realPath = this.uploadPath + File.separator + folderPath; //저장될 실제 폴더 경로(~ImageFile폴더 + 년월일폴더)
		String filePath = realPath + File.separator+saveFileName;//저장될 실제 경로 + 파일이름
		
		try(
			InputStream fis = filePart.getInputStream();
			OutputStream fos = new FileOutputStream(filePath);)
		{
			byte[] buf = new byte[1024];
			int len = 0;
			// 불러온 파일을 읽음 -1은 다 읽을때 까지 라는거 같음 len에 파일저장, 
			// 아웃스트림에 파일패스(파일경로+파일이름)로 저장
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
		
		return File.separator + folderPath + File.separator + saveFileName ; //년월일 + 파일이름
	}
	
	/*/ImageFile 하위 폴더 경로 생성 */
	public String createFilePath() {
		LocalDateTime date = LocalDateTime.now();
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd"); //년월일 불러옴
		String[] paths = formatter.format(date).split("/"); // 년 월 일 을 /로 잘라서 저장
		
		String result = paths[0] + File.separator + paths[1] + File.separator + paths[2];// 년/월/일의 형태로 폴더생성
		
		createFolders(result);// 년/월/일의 형태로 폴더생성
		
		return result; // 년/월/일 의 형식의 String return
	}
	
	private void createFolders(String paths) {
		
		File folders = new File(uploadPath, paths); //ImageFile폴더 아래에 년월일폴더를 가르키는 객체생성
		
		if(!folders.exists()) //폴더가 존재하지 않는다면
			folders.mkdirs(); //폴더를 생성한다.
	}
	
	//랜덤알파벳 + 년월일시간분초 파일 이름 생성
	public String createFileName() {
		LocalDateTime date = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm-ss");
		String[] paths = formatter.format(date).split("-");
		String ranAlpha = Character.toString((char)((Math.random() * 26) + 97));
		String result = ranAlpha + paths[0] + paths[1] + paths[2] + paths[3] + paths[4] + paths[5]; //랜덤알파벳+년월일시간분초
		
		return result;
		
	}
}