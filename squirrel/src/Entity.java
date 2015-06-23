import java.util.Random;


public abstract class Entity {

	private char symbol;
	private int row;
	private int column;

	public abstract void create();
	
	public char put(int newRow, int newColumn) {
		char rtnChar = 0;
		Maze.maze[this.row][this.column] = 32;
		Maze.historyList.add(String.valueOf(this.row) + "," + String.valueOf(this.column));
		this.row = newRow;
		this.column = newColumn;
		rtnChar = Maze.maze[this.row][this.column];
		Maze.maze[this.row][this.column] = this.symbol;
		return rtnChar;
	}
	
	public int getRandomRow() {
		Random random = new Random();
		return random.nextInt(Maze.MAX_MAZE_ROW);
	}
	
	public int getRandomColumn() {
		Random random = new Random();
		return random.nextInt(Maze.MAX_MAZE_COLUMN);
	}
	
	public char getSymbol() {
		return symbol;
	}

	public void setSymbol(char symbol) {
		this.symbol = symbol;
	}

	public int getRow() {
		return row;
	}

	public int getColumn() {
		return column;
	}

}
