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
    final response = await http.get(Uri.parse('https://data-iitb-default-rtdb.firebaseio.com//.json'));
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
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 186, 255, 223), Color.fromARGB(255, 255, 223, 186)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
                        'Welcome To WICTRE',
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
                    'Real-Time Water Monitoring App',
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
                        SolarStill(context,empty,empty,empty),
                        Dynamic_card(context,empty),
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
                        SolarStill(context,empty,empty,empty),
                        Dynamic_card(context,empty),
                      ],
                    );
                  }
                  else{
                    String temp = snapshot.data!["AT"].toString(), btds = snapshot.data!["TDS"].toString(), gtemp = snapshot.data!["GST"].toString(), humidity = snapshot.data!["AH"].toString(), permeate = snapshot.data!["yield"].toString(), btemp = snapshot.data!["WT"].toString();
                    return Column(
                      children: [
                        Temperature_card(context,temp,humidity),
                        SolarStill(context,gtemp,btemp,btds),
                        Dynamic_card(context,permeate),
                      ],
                    );
                  }
                }
              ),
              Card(
                elevation: 8,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 223, 186),
                        Color.fromARGB(255, 186, 255, 223),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
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
                    ],
                  ),
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
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 223, 186),
            Color.fromARGB(255, 186, 255, 223),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
                Text("Ambient Conditions",
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
          ],
        )
      ),
    ),
  );
}

Widget Dynamic_card(context,String permeate) {
  final ValueNotifier<int> rtds = ValueNotifier<int>(250);
  
  return Card(
    elevation: 8,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 223, 186),
            Color.fromARGB(255, 186, 255, 223),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.water),
                SizedBox(width: 10,),
                Text("Resultant Water",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'TDS of Recieved Water',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(247, 4, 4, 4),
                      ),),
                    Text(
                      "${rtds.value} ppm",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(247, 4, 4, 4),
                      ),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        ValueListenableBuilder<int>(
                          valueListenable: rtds,
                          builder: (context, value, child) {
                            Color indicatorColor = value > 250 ? Colors.red : Colors.green;
                            return Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: indicatorColor,
                                shape: BoxShape.circle,
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Yield',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(247, 4, 4, 4),
                      ),),
                    Text(
                      "$permeate ml",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(247, 4, 4, 4),
                      ),),
                    SizedBox(height: 20,)
                  ],
                )
              ],  
            ),
            SizedBox(height: 10,),
          ])
      ),
    ),
  );
}

Widget SolarStill(context,String gtemp,String btemp,String b_tds,) {
  return Card(
    elevation: 8,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 223, 186),
            Color.fromARGB(255, 186, 255, 223),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Row(children: [SizedBox(width: MediaQuery.of(context).size.width * 0.17,), Icon(Icons.sunny),SizedBox(width:5),Text(
              'Solar Still Parameters',
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
                    Text("Glass Temperature",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(247, 4, 4, 4),
                    ),),
                    Text("$gtemp °C",style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(247, 4, 4, 4)
                    ),),
                    SizedBox(height: 15,),
                    Text("Basin TDS",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(247, 4, 4, 4),
                    ),),
                    Text("$b_tds ppm",style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(247, 4, 4, 4)
                    ),),
                  ]
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                    Text("Basin Temperature",
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
                    Text("EC",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(247, 4, 4, 4),
                    ),),
                    Text("${b_tds} μS/cm",style: TextStyle(
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
    ),
  );
}