package study.design.pattern.behavioral.command.ex1;

/**
 * @author cwy
 */
public class Swich {

    private Command flipUpCommand;
    private Command flipDownCommand;

    public Swich(Command flipUpCommand, Command flipDownCommand) {
        this.flipUpCommand = flipUpCommand;
        this.flipDownCommand = flipDownCommand;
    }

    public void flipUp() {
        this.flipUpCommand.execute();
    }

    public void flipDown() {
        this.flipDownCommand.execute();
    }

}
