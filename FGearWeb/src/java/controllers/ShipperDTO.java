/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author User
 */
public class ShipperDTO {
    private int shipperId;
    private String companyName;
    private String contact;

    public ShipperDTO() {}

    public ShipperDTO(int shipperId, String companyName, String contact) {
        this.shipperId = shipperId;
        this.companyName = companyName;
        this.contact = contact;
    }

    public int getShipperId() { return shipperId; }
    public void setShipperId(int shipperId) { this.shipperId = shipperId; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
}