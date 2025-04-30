package com.backrooms.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("PayDTO")
public class PayDTO {
    private int payNum;
    private int memberNum;
    private int reservationNum;
    private String payMethod;
    private Date payDate;
    private String payment;
    private int payState;
}
