package com.backrooms.dto;

import org.apache.ibatis.type.Alias;

import java.util.ArrayList;
import java.util.List;

@Alias("ImageRequestDTO")
public class ImageRequestDTO {

    private int kind;
    private List<Integer> useList;

    public ImageRequestDTO(int kind) {
        this.kind = kind;
        this.useList = new ArrayList<Integer>();
    }

    public int getKind() {
        return kind;
    }

    public void setKind(int kind) {
        this.kind = kind;
    }

    public void setKind(ImageKind kind) {
        this.kind = kind.getValue();
    }

    public List<Integer> getUseList() {
        return useList;
    }

    public void clear() {
        this.kind = ImageKind.ERROR.getValue();
        useList.clear();
    }

    public void addUse(int hotelOrRoomNum) {
        useList.add(hotelOrRoomNum);
    }
}
