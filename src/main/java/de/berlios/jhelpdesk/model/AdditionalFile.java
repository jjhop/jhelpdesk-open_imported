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
package de.berlios.jhelpdesk.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.FileUtils;

/**
 * Pliki w systemie, które są dołączane do zgłoszenia. Do każdego zgłoszenia można
 * dołączyć dowolną (ograniczoną przestrzenią dyskową) ilość plików. W bazie danych
 * przechowujemy informacje o plikach, same zaś plik we wskazanym katalogu. Pliki
 * z założenia mają pomóc osobie zajmującej się zgłoszeniem rozwiązać problem.
 *
 * @author jjhop
 */
@Entity
@Table(name = "ticket_additional_files")
@SequenceGenerator(name = "ticket_add_files_id_seq",
    sequenceName= "ticket_add_files_id_seq", allocationSize = 1)
@NamedQueries({
    @NamedQuery(name = "AdditionalFile.countAttachmentsForTicket", 
                query = "SELECT COUNT(f) FROM AdditionalFile f WHERE f.ticket.ticketId=?1"),
    @NamedQuery(name = "AdditionalFile.getAttachmentsForTicketOrderByEventDateDESC", 
                query = "SELECT f FROM AdditionalFile f WHERE f.ticket.ticketId=?1 ORDER BY f.createdAt DESC")
})
public class AdditionalFile implements Serializable {

    private static final long serialVersionUID = -8228381982146548515L;
    
    public static AdditionalFile create(String fileName, String contentType, long size, 
                                        Ticket ticket) {
        AdditionalFile addFile = new AdditionalFile();
        addFile.setOriginalFileName(fileName);
        addFile.setContentType(contentType);
        addFile.setFileSize(size);
        addFile.setTicket(ticket);
        addFile.setCreatedAt(new Date());
        addFile.calculateAndSetHash();
        return addFile;
    }

	/**
     * Identyfikator pliku
     */
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator="ticket_add_files_id_seq")
    @Column(name = "id")
    private Long fileId;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date createdAt;

    @ManyToOne
    @JoinColumn(name="ticket_id")
    private Ticket ticket;
    
    @ManyToOne
    @JoinColumn(name="user_id")
    private User creator;

    /**
     * Nazwa pliku.
     */
    @Column(name = "original_filename", length = 128, nullable = false)
    private String originalFileName;
    
    @Column(name = "digest", length = 62, nullable = false)
    private String digest;

    /**
     * Skrót z nazwy pliku i identyfikatora. Pozwala przechowywać wiele plików
     * o tej samej nazwie w jednym miejscu nie generując przy tym problemów.
     */
    @Column(name = "hashed_filename", length = 64, nullable = false, unique = true)
    private String hashedFileName;

    /**
     * Rozmiar pliku w bajtach.
     */
    @Column(name = "file_size", nullable = false)
    private Long fileSize;

    /**
     * Typ pliku (np. image/x-png, application/x-word).
     */
    @Column(name = "content_type", length = 64, nullable = false)
    private String contentType;
        
    /**
     * Zwraca identyfikator pliku.
     * 
     * @return identyfikator pliku
     *
     * @see #fileId
     */
    public Long getFileId() {
        return fileId;
    }

    /**
     * Ustawia identyfikator pliku. Metoda powinna być wykorzystywana
     * tylko podczas przepisywania danych o pliku z bazy danych.
     * 
     * @param fileId identyfikator pliku
     *
     * @see #fileId
     * @see #getFileId() 
     */
    public void setFileId(Long fileId) {
        this.fileId = fileId;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * Zwraca Ticket, z którym powiązany jest plik.
     * 
     * @return Ticket, z którym powiązany jest plik
     */
    public Ticket getTicket() {
        return ticket;
    }

    /**
     * Ustala powiązanie pliku z Ticketem.
     *
     * @param ticket ticket, z którym ma być powiązany plik.
     */
    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
    }

    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    /**
     * Zwraca typ pliku. Jest to łańcuch w postaci podobnej do "image/gif".
     *
     * @return typ pliku
     *
     * @see #contentType
     */
    public String getContentType() {
        return contentType;
    }

    /**
     * Ustawia informację o typie pliku. Należy ostrożnie korzystać z tej metody,
     * lub najlepiej po pierwszym ustawieniu (właściwego typu) nie wykorzystywać
     * jej już w ogóle. Od tego czasu powinna być wykorzystywana tylko podczas
     * przepisywania danych z bazy.
     *
     * @param contentType typ plik
     *
     * @see #contentType
     * @see #getContentType() 
     */
    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
    
    public String getContentTypeClass() {
        if (contentType.contains("pdf")) {
            return "PDF";
        }
        if (contentType.contains("msword")) {
            return "MSWORD";
        }
        if (contentType.contains("zip")) {
            return "ARCHIVE";
        }
        if (contentType.equalsIgnoreCase("text/plain")) {
            return "TEXT";
        }
        
        if (contentType.contains("image")) {
            return "IMAGE";
        }
        return "UNKNOWN";
    }

    /**
     * Zwraca rozmiar pliku w bajtach. Jest to właściwie rozmiar tablicy z danymi<br/>
     * {@code getFileSize().toInt() == getFileData().length}.
     *
     * @return rozmiar pliku w bajtach
     *
     * @see #fileSize
     */
    public Long getFileSize() {
        return fileSize;
    }

    /**
     * Ustawia rozmiar pliku (wartość w bajtach). Po pierwszym użyciu rozmiar nie powinien być
     * zmieniany i od tego momentu metoda powinna być wykorzystaywan tylko przez mechanizm
     * przepisujący informacje z bazy danych.
     *
     * @param fileSize rozmiar pliku w bajtach
     *
     * @see #fileSize
     * @see #getFileSize()
     */
    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    /**
     * Zwraca rozmiar plik sformatowany w sposób czytelny dla człowieka.
     * 
     * @return rozmiar plik sformatowany w sposób czytelny dla człowieka
     *
     * @see FileUtils#byteCountToDisplaySize(long)
     */
    public String getHumanReadableFileSize() {
        return FileUtils.byteCountToDisplaySize(getFileSize());
    }

    public String getDigest() {
        return digest;
    }

    public void setDigest(String digest) {
        this.digest = digest;
    }

    /**
     * Zwraca skrót nazwy pliku i identyfikatora.
     *
     * @return skrót nazwy pliku i identyfikatora
     *
     * @see #hashedFileName
     */
    public String getHashedFileName() {
        return hashedFileName;
    }

    /**
     * Ustawia skrót z nazwy pliku i identyfikatora. Metoda powinna być używana tylko
     * przez mechanizm przepisywania danych z bazy danych.
     *
     * @param hashedFileName skrót nazwy pliku i identyfikatora
     *
     * @see #hashedFileName
     * @see #getHashedFileName() 
     */
    public void setHashedFileName(String hashedFileName) {
        this.hashedFileName = hashedFileName;
    }

    /**
     * Zwraca oryginalną nazwę pliku. Jest to nazwa pliku, pod jaką będzie on pokazywany
     * w szczegółach zgłoszenia.
     * 
     * @return oryginalna nazwa pliku
     *
     * @see #originalFileName
     */
    public String getOriginalFileName() {
        return originalFileName;
    }

    /**
     * Ustawia nazwę pliku. Metoda powinna być używana tylko
     * przez mechanizm przepisywania danych z bazy danych.
     * 
     * @param originalFileName nazwa pliku
     *
     * @see #originalFileName
     * @see #getOriginalFileName() 
     */
    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }
    
    private void calculateAndSetHash() {
        this.hashedFileName = 
            DigestUtils.shaHex(originalFileName + contentType + 
                               ticket.getTicketId() + System.currentTimeMillis());
    }
}
