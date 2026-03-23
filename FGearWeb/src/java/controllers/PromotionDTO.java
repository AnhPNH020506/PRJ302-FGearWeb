/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author User
 */
import java.sql.Date;

public class PromotionDTO {
    private int promotionId;
    private String code;
    private double discountValue;
    private Date startDate;
    private Date endDate;
    private int usageLimit;

    public PromotionDTO() {}

    public PromotionDTO(int promotionId, String code, double discountValue,
                        Date startDate, Date endDate, int usageLimit) {
        this.promotionId = promotionId;
        this.code = code;
        this.discountValue = discountValue;
        this.startDate = startDate;
        this.endDate = endDate;
        this.usageLimit = usageLimit;
    }

    // getters & setters
    public int getPromotionId() { return promotionId; }
    public void setPromotionId(int promotionId) { this.promotionId = promotionId; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public int getUsageLimit() { return usageLimit; }
    public void setUsageLimit(int usageLimit) { this.usageLimit = usageLimit; }
}