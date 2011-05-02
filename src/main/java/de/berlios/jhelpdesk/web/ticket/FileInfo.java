package de.berlios.jhelpdesk.web.ticket;

import java.io.File;

import de.berlios.jhelpdesk.utils.FileUtils;

/**
 * Malutka klasa-struktura do przechowywania tymczasowych
 * informacji w jakiejś zgrabnej formie.
 */
public class FileInfo {

    private String filename;
    private String filesize;

    FileInfo(String filename, String filesize) {
        this.filename = filename;
        this.filesize = filesize;
    }

    FileInfo(File file) {
        this.filename = file.getName();
        this.filesize = FileUtils.toDisplaySize(file.length());
    }

    public String getFilename() {
        return filename;
    }

    public String getFilesize() {
        return filesize;
    }
}
