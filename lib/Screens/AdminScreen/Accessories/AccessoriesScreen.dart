import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tvs_app/Screens/AdminScreen/Accessories/AccessoriesEdit.dart';
import 'package:tvs_app/Screens/AdminScreen/Accessories/AccessoriesSaleToCustomer.dart';
import 'package:tvs_app/Screens/AdminScreen/AllAdmin.dart';
import 'package:tvs_app/Screens/AdminScreen/AllCustomer.dart';
import 'package:tvs_app/Screens/AdminScreen/CustomerPaymentAdd.dart';
import 'package:tvs_app/Screens/AdminScreen/CustomerProfile.dart';
import 'package:tvs_app/Screens/AdminScreen/HomeScreen.dart';

import 'package:tvs_app/Screens/AdminScreen/PaymentHistory.dart';
import 'package:tvs_app/Screens/CommonScreen/ProductScreen.dart';


class AccessoriesScreen extends StatefulWidget {
  const AccessoriesScreen({super.key});

  @override
  State<AccessoriesScreen> createState() => _AccessoriesScreenState();
}

class _AccessoriesScreenState extends State<AccessoriesScreen> {

bool loading = true;

var DataLoad = "";
int moneyAdd =0;
var totalAccessoriesScreen = "";

   // Firebase All Customer Data Load

List  AllData = [];


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('accessoriesinfo');

Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();


       if (AllData.length == 0) {

      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {


          //  for (var i = 0; i < AllData.length; i++) {

          //       var money = AllData[i]["BikePaymentDue"];
          //       int moneyInt = int.parse(money);

      

          //             setState(() {
          //               totalAccessoriesScreen = AllData.length.toString();
          //               moneyAdd = moneyAdd + moneyInt;
          //               AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
          //             });

       
          //         }



          setState(() {
               AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
               loading = false;
          });




     }


    print(AllData);
}









@override
  void initState() {
    
    super.initState();
    // TODO: implement initState
    getData();
   
  }





 Future refresh() async{


    setState(() {
      
  getData();

    });




  }













  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,




       bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 9),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
      
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () async{



                   FirebaseAuth.instance
                  .authStateChanges()
                  .listen((User? user) {
                    if (user == null) {
                      print('User is currently signed out!');
                    } else {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(userName: user.displayName, userEmail: user.email, indexNumber: "1",)));
                    }
                  });





                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {

     Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2",)));


                },
                icon: const Icon(
                  Icons.electric_bike_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {


                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3",)));




                },
                icon: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {


                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCustomer(indexNumber: "4")));




                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),),
      ),











      appBar:  AppBar(
           systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Parts", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          ],
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,


        
      ),
      body: DataLoad == "0"? Center(child: Text("No Data Available")):RefreshIndicator(
        onRefresh: refresh,
        child: GridView.builder(
                itemCount: AllData.length,
                
                itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.only(top: 60),
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Theme.of(context).primaryColor)
                  // ),
                  // height: 230,

                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),

                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [


                        //Image Container 

                        // Center(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(2.0),
                        //     child: Container(
                        //         width: 130.0,
                        //         height: 130.0,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        //           color: Theme.of(context).primaryColor,
                        //         ),
                        //         child: Image.network(
                        //           "${AllData[index]["ImageLink"]}",
                        //           height: 130.0,
                        //           width: 130.0,
                        //         ),
                        //       ),
                        //   ),
                        // ),


                        Padding(
                          padding: const EdgeInsets.only(left: 18,top: 2, right: 3),
                          child: Text("Parts Name: ${AllData[index]["AccessoriesName"].toString()}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(left: 18,top: 2, right: 3),
                          child: Text("Model:- ${AllData[index]["Model"].toString()}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 18,top: 2, right: 3),
                          child: Text("ID:- ${AllData[index]["PartsID"].toString()}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
                        ),

                        

                        Padding(
                          padding: const EdgeInsets.only(left: 18,top: 2),
                          child: Text("Stock:- ${AllData[index]["AccessoriesAvailableNumber"]} available", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                        ),

                      

                        Padding(
                          padding: const EdgeInsets.only(left: 18,top: 2),
                          child: Text("Price:- ${AllData[index]["AccessoriesSalePrice"]}৳", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.green),),
                        ),


                        





                AllData[index]["AccessoriesAvailableNumber"]=="0"?Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Out Of Stock"),
                  ),
                ):        

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(width: 100, child:TextButton(onPressed: (){
                              
                         Navigator.push(
                      context,
                              
                             MaterialPageRoute(builder: (context) => AccessoriesSaleToCustomer(AccessoriesID: AllData[index]["AccessoriesID"], AccessoriesName: AllData[index]["AccessoriesName"], AccessoriesSalePrice: AllData[index]["AccessoriesSalePrice"], AccessoriesAvailableNumber: AllData[index]["AccessoriesAvailableNumber"])),
                    );
                              
                              
                              
                              
                  }, child: Text("Sale", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                       
                          backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                        ),),),
                ),



                Row(

                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [


                    IconButton(onPressed: (){


                         Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditAccessories(AcceessoriesID: AllData[index]["AccessoriesID"], AccessoriesAvailableNumber: AllData[index]["AccessoriesAvailableNumber"], AccessoriesName: AllData[index]["AccessoriesName"], AccessoriesSalePrice: AllData[index]["AccessoriesSalePrice"], ImageLink: AllData[index]["ImageLink"], Model:AllData[index]["Model"], PartsID: AllData[index]["PartsID"],)),
                              );



                    }, icon: Icon(Icons.edit, color: Theme.of(context).primaryColor,))





                  ],
                ),











                    ],





                  ),



                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 4,
                  mainAxisExtent: 350,
                ),
              ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}











void AccessoriesScreenPageToCustomerProfile(BuildContext context, String CustomerID){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerProfile(CustomerID: CustomerID)));
}





void EveryPaymentHistory(BuildContext context, String CustomerID, String CustomerPhoneNumber){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentHistory( CustomerPhoneNumber: CustomerPhoneNumber, CustomerID:CustomerID,)));
}








 void CustomerAddPayment(BuildContext context, String CustomerNID, String CustomerPhoneNumber, String BikePaymentDue, CustomerName, String CustomerID,){


  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerPaymentAdd(CustomerNID: CustomerNID, CustomerPhoneNumber: CustomerPhoneNumber, BikePaymentDue: BikePaymentDue, CustomerName: CustomerName, CustomerID: CustomerID,)));
}