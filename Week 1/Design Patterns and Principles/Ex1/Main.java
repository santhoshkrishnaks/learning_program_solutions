class Main{
    public static void main(String args[]){
        Log inst1=Log.getInstance();
        Log inst2=Log.getInstance();
        if(inst1==inst2){
            System.out.println("Singleton done");
        }
    }
}
class Log{
    private static Log inst;
    private Log(){
        System.out.println("Singleton is Initiated");
    }
    public static Log getInstance(){
        if(inst==null){
            inst=new Log();
        }
        return inst;
    }
}