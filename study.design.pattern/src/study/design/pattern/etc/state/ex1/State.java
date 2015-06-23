/*
 * @(#)State.java $version 2015. 6. 19.
 *
 * Copyright 2015 NHN Ent. All rights Reserved.
 * NHN Ent PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package study.design.pattern.etc.state.ex1;

import study.design.pattern.etc.factory.ex1.OrderModel;

/**
 * @author godo
 */
public abstract class State {

    public abstract void handle(OrderModel orderModel);

}
