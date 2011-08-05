/*
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * Copyright: (C) 2006 jHelpdesk Developers Team
 */
package de.berlios.jhelpdesk.web.ticket;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Queue;

import javax.servlet.http.HttpSession;

import info.jjhop.deimos.DeimosRepository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import de.berlios.jhelpdesk.dao.TicketDAO;
import de.berlios.jhelpdesk.model.AdditionalFile;
import de.berlios.jhelpdesk.model.Ticket;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.utils.FileUtils;
import de.berlios.jhelpdesk.web.tools.FileUploadBean;

/**
 * Wrzuca wszystkie załączniki do katalogu tymczasowego, będą tam odnalezione
 * jeśli użytkownik zdecyduje się zapisać ticket, jeśli kliknie ANULUJ to zostaną
 * usunięte, jeśli jednak gość nie zapisze ticketu i nie kliknie ANULUJ to zostaną
 * usunięte przez mechanizm sprzątający sesję
 * 
 * @author jjhop
 */
@Controller
public class UploadFileController {

    private final static Logger log = LoggerFactory.getLogger(UploadFileController.class);

    private final static String TICKETS_UPLOAD_VIEW = "tickets/upload";

    @Autowired
    private TicketDAO ticketDAO;

    @Autowired
    private FileUtils fileUtils;
    
    @Autowired
    private DeimosRepository repository;

    @RequestMapping(value="/tickets/uploadFile.html", method = RequestMethod.GET)
    protected String prepareForm(@RequestParam("ticketstamp") String ticketstamp,
                                 ModelMap map, HttpSession session) {
        map.addAttribute("currentFiles", getFilesForTicketFromSession(ticketstamp, session));
        map.addAttribute("fileBean", new FileUploadBean());
        return TICKETS_UPLOAD_VIEW;
    }

    @RequestMapping(value="/tickets/uploadFile.html", method = RequestMethod.POST)
    protected String processSubmit(@ModelAttribute("fileBean") FileUploadBean uploadedFile,
                                   @RequestParam("ticketstamp") String ticketstamp,
                                   ModelMap map, HttpSession session) {

        File targetDir = fileUtils.createTmpDirForTicketstamp(ticketstamp);
        MultipartFile file = uploadedFile.getFile();
        if (file != null && !file.isEmpty()) {
            File targetFile = new File(targetDir, file.getOriginalFilename() +
                                                    "-" + Thread.currentThread().getName() +
                                                    "-" + System.currentTimeMillis());
            addPathToSession(session, targetDir.getAbsolutePath());
            addFilenameToTicketInSession(ticketstamp, file.getOriginalFilename(),
                                         file.getContentType(), file.getSize(),
                                         targetFile.getAbsolutePath(), session);
            copyUploadedToTemp(uploadedFile, targetFile);
        }
        List<FileInfo> currentFiles = getFilesForTicketFromSession(ticketstamp, session);
        session.setAttribute("currentUploadedFiles", currentFiles);
        map.addAttribute("currentFiles", currentFiles);
        map.addAttribute("uploaded", Boolean.TRUE);
        return TICKETS_UPLOAD_VIEW;
    }

    @RequestMapping(value="/tickets/{ticketId}/uploadFile.html", method = RequestMethod.GET)
    protected String prepareFormForTicket(@PathVariable("ticketId") Long ticketId,
                                          ModelMap map) throws Exception {

        Ticket ticket = ticketDAO.getTicketById(ticketId);
        map.addAttribute("attachments", ticket.getAddFilesList());
        map.addAttribute("fileBean", new FileUploadBean());
        return TICKETS_UPLOAD_VIEW;
    }

    /**
     * Podczas uploadowania plików do istniejącego ticketu od razu 
     * zapisujemy pliki we właściwym miejscu.
     */
    @RequestMapping(value="/tickets/{ticketId}/uploadFile.html", method = RequestMethod.POST)
    protected String processSubmitForTicket(@ModelAttribute("fileBean") FileUploadBean uploadedFile,
                                            @PathVariable("ticketId") Long ticketId,
                                            HttpSession session) throws Exception {

        AdditionalFile addFile = createFormUploadAndTicket(uploadedFile.getFile(),
                                                          ticketDAO.getTicketById(ticketId));
        try {
            MultipartFile mf = uploadedFile.getFile();
            if (mf != null && !mf.isEmpty()) {
                String digest = repository.store(mf.getInputStream(), addFile.getHashedFileName()); // na próbę
                addFile.setDigest(digest);
                addFile.setCreator((User) session.getAttribute("loggedUser"));
                ticketDAO.saveAdditionalFile(addFile);
            }
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
        
        return TICKETS_UPLOAD_VIEW;
    }
    
    private AdditionalFile createFormUploadAndTicket(MultipartFile file, Ticket ticket) {
        return AdditionalFile.create(file.getOriginalFilename(), file.getContentType(), 
                                     file.getSize(), ticket);
    }

    private synchronized void addPathToSession(HttpSession session, String path) {
        Queue<String> paths = (Queue<String>) session.getAttribute("paths");
        if (!paths.contains(path)) {
            paths.add(path);
        }
    }
    
    private List<FileInfo> getFilesForTicketFromSession(String ticketstamp, HttpSession session) {
        return (List<FileInfo>) session.getAttribute(createAttrName(ticketstamp));
    }

    private void addFilenameToTicketInSession(String ticketstamp, String filename, String contentType,
                                              long size, String tmpFilePath, HttpSession session) {
        String attrName = createAttrName(ticketstamp);
        List<FileInfo> files = (List<FileInfo>) session.getAttribute(attrName);
        if (files == null) {
            files = new ArrayList<FileInfo>();
        }
        files.add(new FileInfo(filename, tmpFilePath, contentType, size));
        session.setAttribute(attrName, files);
    }

    private void copyUploadedToTemp(FileUploadBean uploadedFile, File targetFile) {
        try {
            BufferedOutputStream buff =
                    new BufferedOutputStream(new FileOutputStream(targetFile));
            buff.write(uploadedFile.getFile().getBytes());
            buff.close();
        } catch (Exception e) {
            log.error("Wystąpił problem z przetworzeniem pliku.", e);
            throw new RuntimeException(e);
        }
    }
    
    private String createAttrName(String ticketstamp) {
        return ticketstamp + "_files";
    }
}
