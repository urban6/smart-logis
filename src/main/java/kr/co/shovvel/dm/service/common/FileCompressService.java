package kr.co.shovvel.dm.service.common;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.commons.compress.archivers.tar.TarArchiveEntry;
import org.apache.commons.compress.archivers.tar.TarArchiveInputStream;
import org.apache.commons.compress.archivers.tar.TarArchiveOutputStream;
import org.apache.commons.compress.compressors.gzip.GzipCompressorInputStream;
import org.apache.commons.compress.compressors.gzip.GzipCompressorOutputStream;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class FileCompressService {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	public void compressTarGZ(String dirPath, String tarGzPath) throws FileNotFoundException, IOException {
		TarArchiveOutputStream tOut = null;

		try {
			System.out.println(new File(".").getAbsolutePath());

			tOut = new TarArchiveOutputStream(new GzipCompressorOutputStream(new BufferedOutputStream(new FileOutputStream(new File(tarGzPath)))));
			addFileToTarGz(tOut, dirPath, "");
		} finally {
			tOut.finish();
			tOut.close();
			tOut = null;
		}
	}

	private void addFileToTarGz(TarArchiveOutputStream tOut, String path, String base) throws IOException {
		File f = new File(path);
		System.out.println(f.exists());
		String entryName = base + f.getName();
		TarArchiveEntry tarEntry = new TarArchiveEntry(f, entryName);
		tOut.putArchiveEntry(tarEntry);
		if (f.isFile()) {
			IOUtils.copy(new FileInputStream(f), tOut);
			tOut.closeArchiveEntry();
		} else {
			tOut.closeArchiveEntry();
			File[] children = f.listFiles();
			if (children != null) {
				for (File child : children) {
					System.out.println(child.getName());
					addFileToTarGz(tOut, child.getAbsolutePath(), entryName + "/");
				}
			}
		}
	}

	public void uncompressTarGZ(File tarFile, File dest) throws IOException {
		dest.mkdir();
		TarArchiveInputStream tarIn = null;

		if("tar".equals(this.getFileExt(tarFile.getName()))) {
			tarIn = new TarArchiveInputStream(new BufferedInputStream(new FileInputStream(tarFile)));
		} else if("gz".equals(this.getFileExt(tarFile.getName()))) {
			tarIn = new TarArchiveInputStream(new GzipCompressorInputStream(new BufferedInputStream(new FileInputStream(tarFile))));
		}
		
		TarArchiveEntry tarEntry = tarIn.getNextTarEntry();
		// tarIn is a TarArchiveInputStream
		while (tarEntry != null) {// create a file with the same name as the tarEntry
			File destPath = new File(dest, tarEntry.getName());
			System.out.println("working: " + destPath.getCanonicalPath());
			if (tarEntry.isDirectory()) {
				destPath.mkdirs();
			} else {
				destPath.createNewFile();
				byte[] btoRead = new byte[1024];
				BufferedOutputStream bout = new BufferedOutputStream(new FileOutputStream(destPath));
				int len = 0;

				while ((len = tarIn.read(btoRead)) != -1) {
					bout.write(btoRead, 0, len);
				}

				bout.close();
				btoRead = null;

			}
			tarEntry = tarIn.getNextTarEntry();
		}
		tarIn.close();
	}

	public String getFileExt(String sFileName) {
		if (sFileName == null || sFileName.equals("")) {
			return "";
		}
		return sFileName.substring(sFileName.lastIndexOf(".")+1).toLowerCase();
	}
    
}
