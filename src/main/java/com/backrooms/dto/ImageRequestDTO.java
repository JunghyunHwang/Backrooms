package com.backrooms.dto;

import lombok.Getter;
import org.apache.ibatis.type.Alias;

import java.util.ArrayList;
import java.util.List;

@Getter
@Alias("ImageRequestDTO")
public class ImageRequestDTO {
    private final int kind;
    private final List<Integer> useList;

    public ImageRequestDTO(int kind) {
        this.kind = kind;
        this.useList = new ArrayList<>();
    }

    public void addUse(int hotelOrRoomNum) {
        useList.add(hotelOrRoomNum);
    }
}
