/*
 * @(#)TurnOnLightCommand.java $version 2015. 6. 16.
 *
 * Copyright 2015 NHN Ent. All rights Reserved.
 * NHN Ent PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package study.design.pattern.behavioral.command.ex1;

/**
 * @author cwy
 */
public class TurnOnLightCommand implements Command {

    private Light theLight;

    public TurnOnLightCommand(Light theLight) {
        this.theLight = theLight;
    }

    @Override
    public void execute() {
        this.theLight.turnOn();
    }

}
