package de.berlios.jhelpdesk.web.ticket;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import info.jjhop.deimos.DeimosRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import de.berlios.jhelpdesk.model.AdditionalFile;
import de.berlios.jhelpdesk.model.Ticket;
import de.berlios.jhelpdesk.model.User;

@Component
public class AttachmentUtils {
    
    @Autowired
    private DeimosRepository repository;

    public void storeToRepositoryAndBindWithTicket(Ticket ticket, User user, List<FileInfo> fileInfos) throws IOException {
        if (fileInfos != null) {
            List<AdditionalFile> additionalFiles = new ArrayList<AdditionalFile>();
            for (FileInfo fileInfo : fileInfos) {
                AdditionalFile additionalFile = AdditionalFile.create(
                                                    fileInfo.getFilename(), fileInfo.getContentType(),
                                                    fileInfo.getSize(), ticket);
                String digest = repository.store(fileInfo.getInputStream(), additionalFile.getHashedFileName());
                additionalFile.setDigest(digest);
                additionalFile.setCreator(user);
                additionalFiles.add(additionalFile);
            }
            ticket.setAddFilesList(additionalFiles);
        }
    }

    public InputStream getInputStream(AdditionalFile file) throws IOException {
        return repository.getInputStream(file.getHashedFileName(), file.getDigest());
    }
}
