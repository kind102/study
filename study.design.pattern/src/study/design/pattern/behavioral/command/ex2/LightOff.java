/*
 * @(#)LightOff.java $version 2015. 6. 16.
 *
 * Copyright 2015 NHN Ent. All rights Reserved.
 * NHN Ent PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package study.design.pattern.behavioral.command.ex2;

/**
 * @author cwy
 */
public class LightOff implements Command {

    @Override
    public void execute() {
        System.out.println("The light is off");
    }
}
