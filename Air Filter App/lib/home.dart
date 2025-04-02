import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late StreamController<Map<String,dynamic>> _dataController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _dataController = StreamController<Map<String,dynamic>>();
    fetchData(); // Initial fetch
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      fetchData(); // Fetch data every 10 seconds
    });
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://air-filter-iitb-default-rtdb.firebaseio.com/.json'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      Map<String,dynamic> display = {};
      var lastKey = jsonData.keys.last;
      var lastValue = jsonData[lastKey];
      lastValue.forEach((a, b) {
        display[a] = b;
      });
      _dataController.add(display);
    }
    else {
      _dataController.addError('Failed to load data');
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer
    _dataController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(image: AssetImage('assets/IIT.png'),
                    width: MediaQuery.of(context).size.width * 0.24,
                    height: MediaQuery.of(context).size.width * 0.24,),
                  Column(
                    children: [
                      Text(
                        'Welcome To NEMO lab',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'get your latest Updates here',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(247, 10, 10, 10),
                        ),
                      ),
                    ],
                  ),
                  Image(image: AssetImage('assets/WICTRE.png'),
                    width: MediaQuery.of(context).size.width * 0.19,
                    height: MediaQuery.of(context).size.width * 0.19,),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    'Real-Time Air Filter Monitoring App',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(247, 4, 4, 4),
                    ),
                  ),
                ),
              ),
              StreamBuilder<Map<String,dynamic>>(
                stream: _dataController.stream,
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    String empty= "--";
                    return Column(
                      children: [
                        Temperature_card(context,empty,empty),
                        Air_filter(context,empty,empty,empty),
                      ],
                    );
                  }
                  else if(snapshot.hasError){
                    return Text('Error: ${snapshot.error}');
                  }
                  else if(!snapshot.hasData || snapshot.data!.isEmpty) {
                    String empty= "--";
                    return Column(
                      children: [
                        Temperature_card(context,empty,empty),
                        Air_filter(context,empty,empty,empty),
                      ],
                    );
                  }
                  else{
                    String InnerDust = snapshot.data!["InnerDust"].toString(), otemp = snapshot.data!["OutterTemp"].toString(), outterDust = snapshot.data!["OutterDust"].toString(), itemp = snapshot.data!["InnerTemp"].toString();
                    return Column(
                      children: [
                        Temperature_card(context,otemp,outterDust),
                        Air_filter(context,otemp,itemp,InnerDust),
                      ],
                    );
                  }
                }
              ),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: const Color.fromARGB(255, 198, 118, 212), // Purple border color
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Legend',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(247, 4, 4, 4),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          'Ready for use or discharge',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Color.fromARGB(247, 4, 4, 4),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20,),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          'Harmful for use or discharge',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Color.fromARGB(247, 4, 4, 4),
                          ),
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'Moderate for use or discharge',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                color: Color.fromARGB(247, 4, 4, 4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
              ),
              Center(child: Text("navigate to individual pages for detailed info",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4),
                    ),),)
            ],
          ),
        ),
      ),
    );
  }
}

Widget Temperature_card(context,String temp,String humidity) {
  return Card(
    elevation: 8,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: const Color.fromARGB(255, 198, 118, 212), // Light Blue border
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud),
              SizedBox(width: 10,),
              Text("Ambient(Inlet) Conditions",
              style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),)
            ],
          ),
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  'Temperature',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  "$temp °C",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  'Humidity',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  "$humidity %",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Dust Concentration',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "$humidity µg/m³",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4),
                    )
                  )
                )
              ],
            ),
          )
      ]),
        ],
      )
    ),
  );
}

Widget Air_filter(context,String gtemp,String btemp,String b_InnerDust,) {
  return Card(
    elevation: 8,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: const Color.fromARGB(255, 198, 118, 212), // Light blue border color
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      children: [
        SizedBox(height: 10,),
        Row(children: [SizedBox(width: MediaQuery.of(context).size.width * 0.17,), Icon(Icons.sunny),SizedBox(width:5),Text(
            'Air Filter(outlet) Parameters',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(247, 4, 4, 4),
            ),
          ),],), 
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                  Text(" Outlet Dust\nconcentration",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4),
                  ),),
                  Text("$gtemp µg/m³",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4)
                  ),),
                  SizedBox(height: 15,),
                  Text("Humidity",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4),
                  ),),
                  Text("$b_InnerDust %",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4)
                  ),),
                ]
            ),
            SizedBox(width: 10,),
            Column(
              children: [
                  Text("Temperature",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4),
                  ),),
                  Text("$btemp °C",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4)
                  ),),
                  SizedBox(height: 15,),
                  Text("            Air flow\n(differential pressure)",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4),
                  ),),
                  Text("${b_InnerDust} kpa",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4)
                  ),),
                ]
            )
          ],
        ),
        SizedBox(height: 15,)
      ],
    ),
  );
}