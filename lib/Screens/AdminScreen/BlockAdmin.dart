import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tvs_app/Screens/AdminScreen/AllAdmin.dart';
import 'package:tvs_app/Screens/AdminScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;




class BlockAdmin extends StatefulWidget {
  const BlockAdmin({super.key});

  @override
  State<BlockAdmin> createState() => _BlockAdminState();
}

class _BlockAdminState extends State<BlockAdmin> {
  TextEditingController myEmailController = TextEditingController();
  TextEditingController myPassController = TextEditingController();



  bool loading = false;

  var ServerMsg = "";

  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();
 

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.purple),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Set New Admin",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor: const Color(0xFFEA3799),
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ): Container(

        child:  CustomPaint(
          painter: CurvePainter(),

     
              
            
            
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            
                    
               
            
            
            
                    TextField(
                     
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Email',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.purple: Colors.black
                  ),
                          hintText: 'Enter Your Email',
            
                          //  enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //     ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3, color: Colors.purple),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                          
                          
                          ),
                      controller: myEmailController,
                    ),
            
            
            
            
                    SizedBox(
                      height: 10,
                    ),
            
            
            
            
            
            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 150, child:TextButton(onPressed: () async{

                          setState(() {
                            loading = true;
                          });

                         final docUser = FirebaseFirestore.instance.collection("admin").doc(myEmailController.text.trim());


                      var updateData ={


                        "AdminApprove":"false"
                      };


                      FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) async{
                          if (user == null) {
                            print('User is currently signed out!');
                          } else {





                               var AdminMsg = "Dear Admin, ${myEmailController.text.trim()} Admin কে ${user.email} Admin access off করেছে।";



                  final response = await http
                      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&to=01721915550&message=${AdminMsg}'));

                  if (response.statusCode == 200) {
                    // If the server did return a 200 OK response,
                    // then parse the JSON.
                    print(jsonDecode(response.body));
                    
                  
                  } else {
                    // If the server did not return a 200 OK response,
                    // then throw an exception.
                    throw Exception('Failed to load album');
                  }
                

                          }
                        });




                   












                          docUser.update(updateData).then((value) =>      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3",)),
                      )).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                              content: const Text('Something Wrong'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));





                           

                
















                      setState(() {
                            loading = false;
                          });




                        }, child: Text("Block Admin", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
              ),),),



                    




                      ],
                    )
            
            
            
                  ],
                ),
              ),
            ),
        ),
      
      
    );
  }
}



class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}