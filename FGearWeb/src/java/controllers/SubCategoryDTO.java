/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author User
 */
public class SubCategoryDTO {
    private int subId;
    private String name;
    private String slug;
    private int categoryId;

    public SubCategoryDTO() {}

    public SubCategoryDTO(int subId, String name, String slug, int categoryId) {
        this.subId = subId;
        this.name = name;
        this.slug = slug;
        this.categoryId = categoryId;
    }

    public int getSubId() { return subId; }
    public void setSubId(int subId) { this.subId = subId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
}