/*
 * @(#)OrderType.java $version 2015. 6. 19.
 *
 * Copyright 2015 NHN Ent. All rights Reserved.
 * NHN Ent PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package study.design.pattern.etc.state.ex1;

/**
 * @author godo
 */
public enum OrderType {
    ORDER(1),
    CHANGE(2),
    CANCEL(3);

    private final int value;

    private OrderType(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

}
