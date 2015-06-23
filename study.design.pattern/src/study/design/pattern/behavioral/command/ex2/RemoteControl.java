/*
 * @(#)RemoteControl.java $version 2015. 6. 16.
 *
 * Copyright 2015 NHN Ent. All rights Reserved.
 * NHN Ent PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package study.design.pattern.behavioral.command.ex2;

/**
 * @author cwy
 */
public class RemoteControl {

    private String cmdPrifix = "study.design.pattern.behavioral.command.ex2.";
    private String cmdName = "";
    private Command command;

    public void setCommand(String commandName) {
        if (commandName == null || "".equals(commandName)) {
            System.out.println("Not found the command name");
        } else {
            try {
                Class<?> clz = Class.forName(cmdPrifix + commandName);
                command = (Command)clz.newInstance();
            } catch (Exception e) {
                command = null;
            } finally {
                this.cmdName = commandName;
            }
        }
    }

    public void press() {
        if (command != null)
            command.execute();
        else
            System.out.println("Fail to request the command[\"" + this.cmdName + "\"]");
    }

}
