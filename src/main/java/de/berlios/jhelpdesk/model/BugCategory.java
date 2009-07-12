package de.berlios.jhelpdesk.model;

/**
 * @author jjhop
 */
public class BugCategory implements Comparable<BugCategory> {

	private Long bugCategoryId;
	private Long parentCategory; // != null jesli jest podkategorią
	private String categoryName;
	private String categoryDesc;
	private Long left;
	private Long right;
	private Integer depth;
	private boolean isActive;

	public BugCategory() {}

	public BugCategory(int categoryId, String categoryName) {
		this.bugCategoryId = new Long(categoryId);
		this.categoryName = categoryName;
	}

	/**
	 * @return Returns the bugCategoryId.
	 */
	public Long getBugCategoryId() {
		return bugCategoryId;
	}

	/**
	 * @param bugCategoryId
	 *            The bugCategoryId to set.
	 */
	public void setBugCategoryId(Long bugCategoryId) {
		this.bugCategoryId = bugCategoryId;
	}

	/**
	 * @return Returns the categoryDesc.
	 */
	public String getCategoryDesc() {
		return categoryDesc;
	}

	/**
	 * @param categoryDesc
	 *            The categoryDesc to set.
	 */
	public void setCategoryDesc(String categoryDesc) {
		this.categoryDesc = categoryDesc;
	}

	/**
	 * @return Returns the categoryName.
	 */
	public String getCategoryName() {
		return categoryName;
	}

	/**
	 * @param categoryName
	 *            The categoryName to set.
	 */
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	/**
	 * @return the depth
	 */
	public Integer getDepth() {
		return depth;
	}

	/**
	 * @param depth
	 *            the depth to set
	 */
	public void setDepth(Integer depth) {
		this.depth = depth;
	}

	/**
	 * @return the left
	 */
	public Long getLeft() {
		return left;
	}

	/**
	 * @param left
	 *            the left to set
	 */
	public void setLeft(Long left) {
		this.left = left;
	}

	/**
	 * @return the right
	 */
	public Long getRight() {
		return right;
	}

	/**
	 * @param right
	 *            the right to set
	 */
	public void setRight(Long right) {
		this.right = right;
	}

	/**
	 * @return Returns the isActive.
	 */
	public boolean isActive() {
		return isActive;
	}

	/**
	 * @param isActive
	 *            The isActive to set.
	 */
	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

	/**
	 * @return Returns the parentCategory.
	 */
	public Long getParentCategory() {
		return parentCategory;
	}

	/**
	 * @param parentCategory
	 *            The parentCategory to set.
	 */
	public void setParentCategory(Long parentCategory) {
		this.parentCategory = parentCategory;
	}

	public String toString() {
		return categoryName;
	}

	public boolean hasChildNodes() {
		return left + 1 != right;
	}

	public int compareTo(BugCategory o) {
		if (BugCategory.class.equals(o.getClass())) {
			throw new RuntimeException("Operation not supported!");
		}
		return getLeft().compareTo(((BugCategory) o).getLeft());
	}
}