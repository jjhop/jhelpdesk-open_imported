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
package de.berlios.jhelpdesk.web.search;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.apache.lucene.analysis.SimpleAnalyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.NumericField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import de.berlios.jhelpdesk.model.Article;
import de.berlios.jhelpdesk.model.User;

/**
 * Klasa obsługująca wszystkie operacja na indeksie wyszukiwarki.
 *
 * @author jjhop
 */
@Component
public class LuceneIndexer {

    private final static Logger log = LoggerFactory.getLogger(LuceneIndexer.class);

    private @Value("${lucene.dir}") String indexDirectory;
    
    private QueryParser parser = new QueryParser(Version.LUCENE_30, "body", new SimpleAnalyzer());

    public List<Article> search(String searchQuery, int maxResultSize) throws SearchException {
        try {
            Query query = parser.parse(searchQuery);
            Directory directory = FSDirectory.open(new File(indexDirectory));
            IndexSearcher indexSearcher = new IndexSearcher(directory);
            TopDocs res = indexSearcher.search(query, maxResultSize);
            List<Article> result = new ArrayList<Article>();
            for (ScoreDoc scoreDoc : res.scoreDocs) {
                Document document = indexSearcher.doc(scoreDoc.doc);
                result.add(documentToArticle(document));
            }
            indexSearcher.close();
            return result;
        } catch (Exception ex) {
            log.error(ex.getMessage());
            throw new SearchException(ex);
        }
    }

    public synchronized void addToIndex(Article article) {
        IndexWriter indexWriter = null;
        try {
            indexWriter = getIndexWriter();
            indexWriter.addDocument(articleToDocument(article));
            indexWriter.commit();
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            throw new RuntimeException(ex);
        } finally {
            closeWriter(indexWriter);
        }
    }

    private IndexWriter getIndexWriter() throws Exception {
        File indexDir = new File(indexDirectory);
        Directory directory = FSDirectory.open(indexDir);
        try {
            return new IndexWriter(directory, new StandardAnalyzer(Version.LUCENE_30),
                                   false, IndexWriter.MaxFieldLength.UNLIMITED);
        } catch (IOException ex) {
            log.info(ex.getMessage());
        }
        log.info("Tworzymy index...");
        return new IndexWriter(directory, new StandardAnalyzer(Version.LUCENE_30),
                               true, IndexWriter.MaxFieldLength.UNLIMITED);
    }

    private void closeWriter(IndexWriter writer) {
        try {
            writer.close(true);
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            throw new RuntimeException(ex);
        }
    }
    
    public synchronized void updateIndexedArticle(Article article) {
        IndexWriter indexWriter = null;
        try {
            Document document = articleToDocument(article);
            indexWriter = getIndexWriter();
            indexWriter.updateDocument(
                    new Term("id", String.valueOf(article.getId())), document);
            indexWriter.commit();
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            throw new RuntimeException(ex);
        } finally {
            closeWriter(indexWriter);
        }
    }

    public synchronized void removeIndexedArticle(Long articleId) {
        IndexWriter indexWriter = null;
        try {
            indexWriter = getIndexWriter();
            indexWriter.deleteDocuments(new Term("id", String.valueOf(articleId)));
            indexWriter.commit();
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            throw new RuntimeException(ex);
        } finally {
            closeWriter(indexWriter);
        }
    }

    private Document articleToDocument(Article article) {
        Document doc = new Document();
        doc.add(new Field("id", String.valueOf(article.getId()),
                          Field.Store.YES, Field.Index.NOT_ANALYZED));
        doc.add(new Field("authorId", String.valueOf(article.getAuthor().getUserId()),
                          Field.Store.YES, Field.Index.NOT_ANALYZED));
        doc.add(new Field("authorFirstName", String.valueOf(article.getAuthor().getFirstName()),
                          Field.Store.YES, Field.Index.NOT_ANALYZED));
        doc.add(new Field("authorLastName", String.valueOf(article.getAuthor().getLastName()),
                          Field.Store.YES, Field.Index.NOT_ANALYZED));
        doc.add(new Field("title", article.getTitle(),
                          Field.Store.YES, Field.Index.ANALYZED));
        doc.add(new Field("lead", article.getLead(),
                          Field.Store.YES, Field.Index.ANALYZED));
        doc.add(new Field("body", article.getBody(),
                          Field.Store.NO, Field.Index.ANALYZED));
        doc.add(new NumericField("createdAt", Field.Store.YES, false)
                .setLongValue(article.getCreatedAt().getTime()));
        return doc;
    }

    private Article documentToArticle(Document doc) {
        Long articleId = Long.parseLong(doc.get("id"));
        Date createdAt = new Date(Long.parseLong(doc.get("createdAt")));
        User author = new User(
                Long.parseLong(doc.get("authorId")),
                doc.get("authorFirstName"),
                doc.get("authorLastName"));
        Article article = new Article(articleId, doc.get("title"), doc.get("lead"), createdAt);
        article.setAuthor(author);
        return article;
    }

    @PostConstruct
    protected final void initializeIndex() {
        try {
            IndexWriter w = getIndexWriter();
            w.commit();
            w.close();
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            throw new RuntimeException(ex);
        }
    }
}
