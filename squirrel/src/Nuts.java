import java.util.Random;


public class Nuts extends Entity {

	private int Total_Nuts = 5;
	
	public void create() {
		int newRow = 0;
		int newCol = 0;
		while(true) {
			newRow = super.getRandomRow();
			newCol = super.getRandomColumn();
			if (Maze.availale(newRow, newCol) && Maze.checkHistoryLocation(newRow, newCol)) {
				super.put(newRow, newCol);
				break;
			}
		}
	}
	
	public int isNuts(char symbol) {
		if (super.getSymbol() ==  symbol) {
			return 1;
		}
		return 0;
	}
	
	public static Nuts getTheOneOfNuts() {
		Random random = new Random();
		int randomValue = random.nextInt(10);
		if ((randomValue % 2) == 0) {
			return new Almond();
		} else {
			return new Peanut();
		}
	}

	public static Nuts getPoisonousMushroom() {
		return new PoisonousMushroom();
	}
	
	public int getTotal_Nuts() {
		return Total_Nuts;
	}
	
}
