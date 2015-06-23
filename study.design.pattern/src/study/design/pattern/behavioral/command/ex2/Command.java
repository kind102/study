/*
 * @(#)Command.java $version 2015. 6. 16.
 *
 * Copyright 2015 NHN Ent. All rights Reserved.
 * NHN Ent PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package study.design.pattern.behavioral.command.ex2;

/**
 * @author cwy
 */
public interface Command {

    public static String TV_ON = "TvOn";
    public static String TV_OFF = "TvOff";
    public static String LIGHT_ON = "LightOn";
    public static String LIGHT_OFF = "LightOff";

    void execute();

}
