import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parsing_demo/model/emp_model.dart';
import 'package:parsing_demo/model/emplist_model.dart';
import 'package:parsing_demo/model/empone_model.dart';
import 'package:parsing_demo/model/user_model.dart';
import 'package:parsing_demo/model/user_model_delete.dart';
import 'package:parsing_demo/services/http_service.dart';

 class Details_page extends StatefulWidget {
   const Details_page({Key? key}) : super(key: key);
   static final String id="second_page";

   @override
   _Details_pageState createState() => _Details_pageState();
 }

 class _Details_pageState extends State<Details_page> {
 String getname='';
 String getsalary='';
 String getage='';
 late int createid;
 String updatename='';
 String updatesalary='';
 String updateage='';
 late int updateid;
 String createname='';
 String createsalary='';
 String createage='';
 String  deletemessage="";
 late EmpOne empone;
 late User Userdelete;
 late User user;
 late User user_update;
 // Get
   void _apiEmpOne(int id) {

     Network.GET(Network.API_EMP_ONE + id.toString(), Network.paramsEmpty())
         .then((response) => {
            empone = Network.parseEmpOne(response),

       setState(() {
         getname=empone.data.employee_name as String;
         getsalary=empone.data.employee_salary.toString();
         getage=empone.data.employee_age.toString();
       }),
     });
   }
   // Create
   void _usercreate(User user){
     Network.POST(Network.API_EMP_CREATE, Network.paramsCreate(user))
         .then((response) => {

       setState(() {
         createname=user.name as String;
         createsalary=user.salary.toString();
         createage=user.age.toString();
       }),
     });
   }
// Update
   void _userupdate(User user_update){
     Network.PUT(
         Network.API_EMP_UPDATE + user_update.id.toString(), Network.paramsUpdate(user_update))
         .then((response) => {
       setState(() {
         updatename=user_update.name as String;
         updatesalary=user_update.salary.toString();
         updateage=user_update.age.toString();
         updateid=user_update.id;
       }),
     });
   }
// Delete
   void _userdelete(int id){
     Network.DEL(Network.API_EMP_DELETE +id.toString(), Network.paramsEmpty())
         .then((response) =>
     {
     Userdelete=Network.parseuserdelete(response) as User,
       setState(() {
         deletemessage=Userdelete.id.toString();
       }),
     });
   }

   @override
   void initState() {
     // TODO: implement initState
     super.initState();
      user =User(id: 3666, name: "test", salary:"123", age: "23");
      user_update =User(id: 21, name: "test12", salary:"12345", age: "43");

     _usercreate(user);
     _apiEmpOne(1);
     _userupdate(user_update);
     _userdelete(2);
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(
         child: ListView(
           scrollDirection: Axis.vertical,
           padding: EdgeInsets.all(40),
           children: [
             // Get parsing method
            Container(
              child: Column(
                children: [
                  Text("Get parsing method",style: TextStyle(color: Colors.black,fontSize: 20),),
                  SizedBox(height: 10,),
                  Text("$getname(${getage})",style: TextStyle(color: Colors.black,fontSize: 16),),
                  Text("\$"+getsalary,style: TextStyle(color: Colors.black,fontSize: 14),),
                ],
              ),
            ),
             SizedBox(height: 200,),
        // Create parsing method
        Container(
          child: Column(
            children: [
              Text("Create method",style: TextStyle(color: Colors.black,fontSize: 20),),
              //   SizedBox(height: 7,),
              // Text("Yaratilgan foydalanuchining id:  ${createid.toString()}",style: TextStyle(color: Colors.blue,fontSize: 17),),
              SizedBox(height: 7,),
              Text("Yaratilgan foydalanuchining nomi:  ${createname}",style: TextStyle(color: Colors.green,fontSize: 16),),
              SizedBox(height: 7,),
              Text("Yaratilgan foydalanuchining yoshi:  ${createage}",style: TextStyle(color: Colors.black,fontSize: 16),),
              SizedBox(height: 7,),
              Text("Yaratilgan foydalanuchining maoshi:  ${createsalary}",style: TextStyle(color: Colors.red,fontSize: 16),),
            ],
          ),
        ),
             SizedBox(height: 200,),
            // Update parsing method
            Container(
              child: Column(
                children: [
                  Text("Update method",style: TextStyle(color: Colors.black,fontSize: 20),),
                  SizedBox(height: 7,),
                  Text("Yangilangan id:   ${user_update.id.toString()}",style: TextStyle(color: Colors.blue,fontSize: 17),),
                  SizedBox(height: 7,),
                  Text("Yangilangan nomi:   ${user_update.name.toString()}",style: TextStyle(color: Colors.green,fontSize: 16),),
                  SizedBox(height: 7,),
                  Text("Yangilangan yoshi:   ${user_update.age.toString()}",style: TextStyle(color: Colors.black,fontSize: 16),),
                  SizedBox(height: 7,),
                  Text("Yangilangan maoshi:   ${user_update.salary.toString()}",style: TextStyle(color: Colors.red,fontSize: 16),),
                ],
              ),
            ),
             // Delete parsing method
             SizedBox(height: 40,),
             Text("Delete method",style: TextStyle(color: Colors.black,fontSize: 20),),
             SizedBox(height: 7,),
             Text(deletemessage,style: TextStyle(color: Colors.blue,fontSize: 17),),
           ],
         ),
       ),
     );
   }
 }
