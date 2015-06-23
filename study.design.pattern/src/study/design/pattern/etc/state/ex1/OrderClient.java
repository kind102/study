/*
 * @(#)OrderClient.java $version 2015. 6. 19.
 *
 * Copyright 2015 NHN Ent. All rights Reserved.
 * NHN Ent PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package study.design.pattern.etc.state.ex1;

import study.design.pattern.etc.factory.ex1.OrderModel;

/**
 * @author godo
 */
public class OrderClient {

    public static void main(String[] args) {
        OrderModel order = new OrderModel();
        order.setProductName("A Product");
        order.setTotalAmount(12000);

        OrderProcessingContext orderProcessingContext = new OrderProcessingContext(new OrderState());
        orderProcessingContext.processing(order);
        orderProcessingContext.setOtherState(new ChangeState());
        orderProcessingContext.processing(order);
        orderProcessingContext.setOtherState(new CancelState());
        orderProcessingContext.processing(order);
    }
}
