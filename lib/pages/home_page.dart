import 'package:flutter/material.dart';
import 'package:parsing_demo/model/emp_model.dart';
import 'package:parsing_demo/model/emplist_model.dart';
import 'package:parsing_demo/pages/details_page.dart';
import 'package:parsing_demo/services/http_service.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Employee> items =[];
// Get List
  void _apiEmpList() {
    Network.GET(Network.API_EMP_LIST, Network.paramsEmpty())
        .then((response) => {

              _showResponse(response),
            });
  }

  void _showResponse(String response) {
    EmpList empList = Network.parseEmpList(response);
    setState(() {
      items = empList.data;
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiEmpList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          return itemOfList(items[i]);
          //print(items[i]);
        },
      ),
    );
  }

  Widget itemOfList(Employee emp) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, Details_page.id);
        setState(() {
        });
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // employee information
              Text(emp.employee_name+"("+emp.employee_age.toString()+")",style: TextStyle(color: Colors.black,fontSize: 20),),
              SizedBox(height: 10,),
              // salary text
              Text("\$"+emp.employee_salary.toString(),style: TextStyle(color: Colors.black,fontSize: 18),),
            ],
          ),
        ),
      ),
    );
  }
}
