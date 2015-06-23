/*
 * @(#)CommandMain.java $version 2015. 6. 16.
 *
 * Copyright 2015 NHN Ent. All rights Reserved.
 * NHN Ent PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package study.design.pattern.behavioral.command;

import study.design.pattern.behavioral.command.ex1.Light;
import study.design.pattern.behavioral.command.ex1.Swich;
import study.design.pattern.behavioral.command.ex1.TurnOffLightCommand;
import study.design.pattern.behavioral.command.ex1.TurnOnLightCommand;
import study.design.pattern.behavioral.command.ex2.Command;
import study.design.pattern.behavioral.command.ex2.RemoteControl;

/**
 * @author cwy
 */
public class CommandMain {

    void doEx1() {
        Light light = new Light();
        TurnOnLightCommand onCmd = new TurnOnLightCommand(light);
        TurnOffLightCommand offCmd = new TurnOffLightCommand(light);

        Swich swich = new Swich(onCmd, offCmd);
        swich.flipUp();
        swich.flipDown();
    }

    void doEx2() {
        String[] cmdNames = {Command.TV_ON, Command.TV_OFF, Command.LIGHT_ON, Command.LIGHT_OFF};
        RemoteControl cmd = new RemoteControl();
        for (String name : cmdNames) {
            cmd.setCommand(name);
            cmd.press();
        }
    }

    public static void main(String[] args) {
        CommandMain cmd = new CommandMain();
        cmd.doEx2();

    }

}
