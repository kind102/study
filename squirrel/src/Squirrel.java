public class Squirrel extends Entity {

    int points;
    int Total_number_of_nuts_collected;

    private Nuts nuts;
    private Nuts poisonousMushroom;

    @Override
    public void create() {
        super.setSymbol('@');
        createNut();
        creategetPoisonousMushroom();
    }

    public void moveLeft() {
        int moveCol = super.getColumn() - 1;
        moveChracter(super.getRow(), moveCol);
    }

    public void moveRight() {
        int moveCol = super.getColumn() + 1;
        moveChracter(super.getRow(), moveCol);
    }

    public void moveUp() {
        int moveRow = super.getRow() - 1;
        moveChracter(moveRow, super.getColumn());
    }

    public void moveDown() {
        int moveRow = super.getRow() + 1;
        moveChracter(moveRow, super.getColumn());
    }

    private void moveChracter(int row, int column) {
        char returnValue = 0;
        int getPoint = 0;
        if (Maze.availale(row, column)) {
            returnValue = super.put(row, column);
            if (nuts.isNuts(returnValue) > 0) {
                getPoint = getNutsPoint();

                this.points += getPoint;
                this.Total_number_of_nuts_collected += 1;

                System.out.println("!!! Squirrel got " + getPoint + " points (Total " + this.points + " points) !!!");

                if (this.Total_number_of_nuts_collected < nuts.getTotal_Nuts()) {
                    createNut();
                }
            } else if (poisonousMushroom.isNuts(returnValue) > 0) {
                getPoint = ((PoisonousMushroom)poisonousMushroom).getNutrition_Points();
                this.points += getPoint;
                System.out.println("!!! Squirrel got " + getPoint + " points (Total " + this.points + " points) !!!");
                if (this.points >= 0)
                    creategetPoisonousMushroom();
            }
        } else {
            System.out.println("Wall!!");
        }
    }

    private void createNut() {
        nuts = null;
        nuts = Nuts.getTheOneOfNuts();
        if (nuts instanceof Almond)
            nuts.setSymbol('A');
        else
            nuts.setSymbol('P');
        nuts.create();
    }

    private void creategetPoisonousMushroom() {
        poisonousMushroom = Nuts.getPoisonousMushroom();
        poisonousMushroom.setSymbol('M');
        poisonousMushroom.create();
    }

    public int getPoints() {
        return points;
    }

    public int getTotal_number_of_nuts_collected() {
        return Total_number_of_nuts_collected;
    }

    public boolean checkedTotalPoints() {
        if (this.Total_number_of_nuts_collected == nuts.getTotal_Nuts()) {
            System.out.println("Squirrel successfully collected all the nuts. Total points " + this.points + ".");
            return true;
        }
        if (this.points < 0) {
            System.out.println("");
            return true;
        }
        return false;
    }

    private int getNutsPoint() {
        if (nuts instanceof Almond)
            return ((Almond)nuts).getNutrition_Points();
        else
            return ((Peanut)nuts).getNutrition_Points();
    }
}
