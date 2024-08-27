import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

Widget Temperature_card(context) {
  return Card(
    elevation: 8,
    color: Color.fromARGB(255, 164, 173, 209),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'Temperature',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  '25 C',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 30),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'pH',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  '6.7 pH',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 30),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'TDS',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  '600 ppm',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget Metal_card(context) {
  return Card(
    color: Color.fromARGB(255, 164, 173, 209),
    elevation: 8,
    child: Column(
      children: [
        Row(children: [SizedBox(width: MediaQuery.of(context).size.width * 0.17,), Icon(Icons.api_outlined),SizedBox(width:5),Text(
            'Heavy Metal Sensing',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05, // Adjusted to make the font size responsive
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(247, 4, 4, 4),
            ),
          ),],), 
        Text("WICTRE",style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.05,
          fontWeight: FontWeight.w500,

        ),), 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // added main axis alignment
          children: [
            Column(
                children: [
                  Text("Cadmium(Cd)",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4),
                  ),),
                  Text("1 ppm",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4),
                  ),),
                  Row( // added main axis alignment
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(5,5),
                            backgroundColor: Colors.green,
                          ),
                          child: Text('Safe',style: TextStyle(
                            color: Colors.white
                          ),),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(5,5),
                          backgroundColor: Colors.red,
                        ),
                        child: Text('Unsafe',style: TextStyle(
                          color: Colors.white
                        ),),
                      ),
                    ]
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "Arsenic(As)",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),),
                  Text("0.1 ppm",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4),
                  ),),
                  Row(// added main axis alignment
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(5,5),
                            backgroundColor: Colors.green,
                          ),
                          child: Text('Safe',style: TextStyle(
                            color: Colors.white
                          ),),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(5,5),
                          backgroundColor: Colors.red,
                        ),
                        child: Text('Unsafe',style: TextStyle(
                          color: Colors.white
                        ),),
                      ),
                    ]
                  )
                ],
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // applied main axis alignment to space evenly
          children: [
              Column(
                children: [
                  Text(
                    "Mercury(Hg)",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),
                  ),
                  Text("0.8 ppm",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4),
                  ),),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(5,5),
                            backgroundColor: Colors.green,
                          ),
                          child: Text('Safe',style: TextStyle(
                            color: Colors.white
                          ),),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(5,5),
                          backgroundColor: Colors.red,
                        ),
                        child: Text('Unsafe',style: TextStyle(
                          color: Colors.white
                        ),),
                      ),
                    ]
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "Lead(Pb)",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(247, 4, 4, 4),
                  ),),
                  Text("0.1 ppm",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(247, 4, 4, 4),
                  ),),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(5,5),
                            backgroundColor: Colors.green,
                          ),
                          child: Text('Safe',style: TextStyle(
                            color: Colors.white
                          ),),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(5,5),
                          backgroundColor: Colors.red,
                        ),
                        child: Text('Unsafe',style: TextStyle(
                          color: Colors.white
                        ),),
                      ),
                    ]
                  )
                ],
              ),
          ],
        ),
      ],
    ),
  );
}

Widget oil_card(context) {
  return Card(
    color: Color.fromARGB(255, 164, 173, 209),
    elevation: 8,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
      child: Column(
        children: [
          Row(children: [Icon(Icons.oil_barrel_rounded), SizedBox(width: 5),Text("Oil sensing",style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.055, // Adjusted to make the font size responsive
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(247, 4, 4, 4),
          )),],),
          SizedBox(height: MediaQuery.of(context).size.width * 0.02), // Adjusted to make the height responsive
          Text("Motor Oil",style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(247, 4, 4, 4),
          )),
          SizedBox(height: MediaQuery.of(context).size.width * 0.01), // Adjusted to make the height responsive
          Row(
            children: [
              Text("Input",style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(247, 4, 4, 4),
          )),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01), // Adjusted to make the width responsive
              Text("130 ppm",style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(247, 4, 4, 4),
          ))
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.01), // Adjusted to make the height responsive
          Row(
            children: [
              Text("Output",style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04, // Adjusted to make the font size responsive
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(247, 4, 4, 4),
          )),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01), // Adjusted to make the width responsive
              Text("30 ppm",style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04, // Adjusted to make the font size responsive
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(247, 4, 4, 4),
          ))
            ],
          ),
        ],
      ),
    ),
  );
}

Widget solar_card(context) {
  return Card(
    color: Color.fromARGB(255, 164, 173, 209),
    elevation: 8,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: Row(
              children: [Icon(Icons.sunny), SizedBox(width: 5), Text("Solar Still",style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.055,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(247, 4, 4, 4),
            )),],
            )
          ),
          Row(
            children: [
              Text("Input", style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(247, 4, 4, 4),
              )),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Text("600 ppm", style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(247, 4, 4, 4),
              ))
            ],
          ),
          Row(
            children: [
              Text("permeate", style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(247, 4, 4, 4),
              )),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Text("20 ppm", style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(247, 4, 4, 4),
              ))
            ],
          ),
          SizedBox(height: 10,)
        ],
      ),
    ),
  );
}

class _HomePage extends State<HomePage> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFc4cbe1),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(right: 10,left: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Added center alignment
                  children: [
                    SizedBox(width: 10),
                    Image.asset(
                      'assets/images/WICTRE.png',
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width * 0.2,
                    ),
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
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
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
              Temperature_card(context),
              Metal_card(context),
              Row(
                children: [
                  oil_card(context),
                  solar_card(context),
                ],
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