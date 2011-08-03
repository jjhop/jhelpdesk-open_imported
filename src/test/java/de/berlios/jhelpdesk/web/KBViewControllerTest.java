package de.berlios.jhelpdesk.web;

import java.lang.reflect.Field;
import java.util.Collections;

import org.easymock.EasyMock;
import org.junit.Test;
import static org.junit.Assert.*;

import org.springframework.ui.ModelMap;

import de.berlios.jhelpdesk.dao.ArticleCategoryDAO;
import de.berlios.jhelpdesk.dao.ArticleDAO;
import de.berlios.jhelpdesk.model.Article;
import de.berlios.jhelpdesk.model.ArticleCategory;

/**
 *
 * @author jjhop
 */
public class KBViewControllerTest {

    /**
     * Test of aboutView method, of class KBViewController.
     */
    @Test
    public void testAboutView() {
        KBViewController instance = new KBViewController();
        String expResult = "help/about";
        String result = instance.aboutView();
        assertEquals(expResult, result);
    }

    /**
     * Test of knowledgeBaseView method, of class KBViewController.
     */
    @Test
    public void testKnowledgeBaseView() throws Exception {
        ModelMap map = new ModelMap();
        KBViewController controllerInstance = new KBViewController();
        ArticleCategoryDAO articleCategoryDAOMock = EasyMock.createMock(ArticleCategoryDAO.class);
        EasyMock.expect(articleCategoryDAOMock.getAllCategories())
                .andReturn(Collections.<ArticleCategory>emptyList());
        EasyMock.replay(articleCategoryDAOMock);

        ArticleDAO articleDAOMock = EasyMock.createMock(ArticleDAO.class);
        // 10 to => KBViewController.NUM_OF_LAST_ADDED_ARTICLES (private)
        EasyMock.expect(articleDAOMock.getLastArticles(10))
                .andReturn(Collections.<Article>emptyList());
        EasyMock.replay(articleDAOMock);

        Field f = KBViewController.class.getDeclaredField("articleCategoryDAO");
        f.setAccessible(true);
        f.set(controllerInstance, articleCategoryDAOMock);

        Field f2 = KBViewController.class.getDeclaredField("articleDAO");
        f2.setAccessible(true);
        f2.set(controllerInstance, articleDAOMock);

        String expResult = "help/base";
        String result = controllerInstance.kBView(map);
        assertEquals(expResult, result);
        assertNotNull(map.get("categories"));
        assertNotNull(map.get("latest"));
    }

    /**
     * Test of knowledgeBaseItemView method, of class KBViewController.
     */
    @Test
    public void testKnowledgeBaseItemView() throws Exception {
        Long id = 1L;
        ModelMap map = new ModelMap();
        KBViewController controllerInstance = new KBViewController();

        Article toReturn = new Article();
        toReturn.setId(id);
        toReturn.setTitle("Test article");

        ArticleDAO articleDAOMock = EasyMock.createMock(ArticleDAO.class);
        EasyMock.expect(articleDAOMock.getById(id)).andReturn(toReturn);
        EasyMock.replay(articleDAOMock);

        Field f = KBViewController.class.getDeclaredField("articleDAO");
        f.setAccessible(true);
        f.set(controllerInstance, articleDAOMock);

        String expResult = "help/base/one";
        String result = controllerInstance.kBItemView(id, map);
        assertEquals(expResult, result);
        assertNotNull(map.get("article"));
        assertEquals(1L, ((Article)map.get("article")).getId().longValue());
    }

}