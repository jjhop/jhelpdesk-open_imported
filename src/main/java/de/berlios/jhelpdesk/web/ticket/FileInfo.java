package de.berlios.jhelpdesk.web.ticket;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import de.berlios.jhelpdesk.utils.FileUtils;

/**
 * Malutka klasa-struktura do przechowywania tymczasowych
 * informacji w jakiejś zgrabnej formie.
 */
public class FileInfo {

    private String filename;
    private String contentType;
    private String filesize;
    private long size;
    private String fullPathToTmpFile;

    FileInfo(String filename, String fullPathToTmpFile, String contentType, long size) {
        this.filename = filename;
        this.fullPathToTmpFile = fullPathToTmpFile;
        this.contentType = contentType;
        this.filesize = FileUtils.toDisplaySize(size);
        this.size = size;
    }

    public String getFilename() {
        return filename;
    }

    public String getFilesize() {
        return filesize;
    }

    public String getContentType() {
        return contentType;
    }

    public long getSize() {
        return size;
    }

    public File getFile() {
        return new File(this.fullPathToTmpFile);
    }

    public InputStream getInputStream() throws IOException {
        return new FileInputStream(fullPathToTmpFile);
    }

}
