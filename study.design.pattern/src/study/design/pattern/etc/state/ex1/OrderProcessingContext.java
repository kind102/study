/*
 * @(#)OrderProcessingContext.java $version 2015. 6. 19.
 *
 * Copyright 2015 NHN Ent. All rights Reserved.
 * NHN Ent PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package study.design.pattern.etc.state.ex1;

import study.design.pattern.etc.factory.ex1.OrderModel;

/**
 * @author godo
 */
public class OrderProcessingContext {

    private State state;

    public OrderProcessingContext(State state) {
        this.state = state;
    }

    public void setOtherState(State state) {
        this.state = state;
    }

    public void processing(OrderModel orderModel) {
        this.state.handle(orderModel);
    }
}
