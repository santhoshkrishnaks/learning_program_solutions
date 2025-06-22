import java.util.*;
class Product{
    int productId;
    String productName;
    String category;
    Product(int id,String name,String category){
        this.productId=id;
        this.productName=name;
        this.category=category;
    }

    public String toString(){
        return productId+" "+productName+" "+category;
    }
}

class Main{
    static Product linear(Product productsarr[], int id){
        for(Product product:productsarr){
            if(product.productId==id){
                return product;
            }
        }
        return null;
    }
    static Product binary(Product productsarr[],int id){
        int left=0,right=productsarr.length-1;
        while(left<=right){
            int mid=(left+right)/2;
            if(productsarr[mid].productId == id){
                return productsarr[mid];
            }
            else if(productsarr[mid].productId < id){
                left=mid+1;
            }
            else{
                right=mid-1;
            }
        }
        return null;
    }
    public static void main(String args[]){
        Product productsarr[]={
            new Product(1,"Mobile","Electronics"),
            new Product(8, "IronBox", "Electronics"),
            new Product(2,"BodySpray","Fashion"),
            new Product(12, "Pencil", "Stationery"),
            new Product(4, "Apple", "Fruits"),
            new Product(6, "Potato", "Vegetables")
        };

        Product lResult= linear(productsarr,6);

        Arrays.sort(productsarr, (a,b)-> a.productId-b.productId);        
        Product bResult= binary(productsarr,6);
        
        System.out.println("Linear Search Result: "+lResult);
        System.out.println("Binary Search Result: "+bResult);
    }
}