package com.backrooms.dto;

public enum ImageKind {
  ERROR(-1),
  HOTEL(0),
  ROOM(1),
  REVIEW(2),
  NOTICE(3),
  EVENT(4),
  QNA(5);

  private final int value;

  private ImageKind(int value) {
    this.value = value;
  }

  public int getValue() {
    return value;
  }

  public static ImageKind fromInt(int value) {
    for (ImageKind type : ImageKind.values()) {
      if (type.getValue() == value) {
        return type;
      }
    }

    assert false : "Invalid type";
    return ERROR;
  }
}
