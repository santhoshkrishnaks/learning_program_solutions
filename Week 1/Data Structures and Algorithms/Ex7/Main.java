class Finance{
    public static double predictFutureVal(int principal,double interest,int year){
        if(year==0){
            return principal;
        }
        return predictFutureVal(principal, interest, year-1)*(1+interest);
    }
}
public class Main {
    public static void main(String[]args){
        int principal=30000;
        double intrst=0.05;
        int year=5;
        double FutureVal=Finance.predictFutureVal(principal,intrst,year);
        System.out.printf("Predicted Future Value of principal with compound interest: %.2f\n",FutureVal);
    }
}