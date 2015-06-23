import java.util.Scanner;

public class HungrySquirrelGame {

    public static void main(String[] args) {

        Scanner scan = new Scanner(System.in);
        String command = "";

        Maze.display();

        int newRow = 0, newCol = 0;
        while (true) {
            System.out.print("Enter the Squirrel position (x position,y position): ");
            command = scan.nextLine();
            try {
                newRow = Integer.parseInt(command.split(",")[0]);
                newCol = Integer.parseInt(command.split(",")[1]);
                if (newRow > 20 || newCol > 50) {
                    System.out.println("Position not available. Try again!");
                    continue;
                }

                if (Maze.availale(newRow, newCol)) {
                    break;
                }
            } catch (Exception e) {
            }
            System.out.println("Position not available. Try again!");
        }

        Squirrel squirrel = new Squirrel();
        squirrel.create();
        squirrel.put(newRow, newCol);

        Maze.display();

        System.out.println("User input accepted.");
        System.out.println("Enter commands u,d,l,r to move Up, Down, Left, and Right respectively.");
        while (true) {
            System.out.print("Enter command: ");
            command = scan.nextLine();
            command = command.toUpperCase();
            switch (command) {
                case "L":
                    squirrel.moveLeft();
                    break;
                case "R":
                    squirrel.moveRight();
                    break;
                case "U":
                    squirrel.moveUp();
                    break;
                case "D":
                    squirrel.moveDown();
                    break;
                default:
                    System.out.println("Not Command !!");
            }
            Maze.display();
            if (squirrel.checkedTotalPoints())
                break;
        }
        System.out.println("Thank you for playing this game");
    }
}
