interface UserDisplayer {
    String display();
}

class UserDisplayerCreator(){
    private String message = "User created";
    public String display() {
        return this.message;
    }
}

class UserDisplayerDeleter(){
    private String message = "User deleted";
    public String display() {
        return this.message;
    }
}

class UserController(){
    UserDisplayer displayer;

    void display(char flag) {
        if(flag == 'c') {
            this.displayer = new UserDisplayerCreator();
            this.displayer.display();
        } 
        if(flag == 'd') {
            this.displayer = UserDisplayerDeleter();
            this.displayer.display();
        }
    }
}

//CONTROLLER
// we use a controller to display a message based on a flag 
//instead of having the logic in each of the display classes

//PROTECTED VARIATIONS
//the display messages are private, you cannot change them outside the 
//displayer classes

//POLYMORPHISM
//we use an interface to display different types of messages

//INFORMATION EXPERT 
//the controller is the information expert, assigning the right implementation
//of the displayer based on a given flag

//HIGH COHESION
//here the classes are small and only have a single responsibility