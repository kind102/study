import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Maze {

    final static int MAX_MAZE_ROW = 20;
    final static int MAX_MAZE_COLUMN = 50;
    static char[][] maze = new char[MAX_MAZE_ROW][MAX_MAZE_COLUMN];
    static List<String> historyList = new ArrayList<>();

    static {
        Maze.create("src\\Maze.txt");
    }

    static void create(String filename) {
        FileInputStream in = null;
        try {
            in = new FileInputStream(filename);
            int i = 0;
            int row = 0;
            int col = 0;
            while ((i = in.read()) != -1) {
                if (i == 13 || i == 10)
                    continue;
                maze[row][col] = (char)i;
                if (col == (MAX_MAZE_COLUMN - 1)) {
                    row++;
                    col = 0;
                } else {
                    col++;
                }
            }
            in.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            if (in != null)
                try {
                    in.close();
                } catch (IOException e) {
                }
        }
    }

    static void display() {
        for (int i = 0; i < MAX_MAZE_ROW; i++) {
            for (int j = 0; j < MAX_MAZE_COLUMN; j++) {
                if (maze[i][j] == '&')
                    System.out.print((char)32);
                else
                    System.out.print(maze[i][j]);
                if (j == 49)
                    System.out.println("");
            }
        }
        System.out.println("");
    }

    static boolean availale(int row, int col) {
        char value = maze[row][col];
        if (value == '*')
            return false;
        return true;
    }

    static boolean checkHistoryLocation(int row, int col) {
        String value = String.valueOf(row) + "," + String.valueOf(col);
        for (String history : historyList) {
            if (history.equals(value))
                return false;
        }
        return true;
    }

}
