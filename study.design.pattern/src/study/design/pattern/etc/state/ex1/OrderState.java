/*
 * @(#)OrderState.java $version 2015. 6. 19.
 *
 * Copyright 2015 NHN Ent. All rights Reserved.
 * NHN Ent PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package study.design.pattern.etc.state.ex1;

import study.design.pattern.etc.factory.ex1.OrderModel;

/**
 * @author godo
 */
public class OrderState extends State {

    @Override
    public void handle(OrderModel orderModel) {
        OrderType orderType = OrderType.ORDER;
        orderModel.setState(orderType.getValue());
        System.out.println(orderModel.getState() + " order state");
    }

}
