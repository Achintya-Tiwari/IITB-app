// ignore: file_names
import 'pages/Data.dart';
import 'pages/metal.dart';
import 'pages/oil.dart';
import 'pages/solar.dart';

import 'pages/home.dart';
import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0 ;
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SolarPage(),
    OilPage(),
    MetalPage(),
    
  ];

  List<Widget> _headingoptions = <Widget>[
    Text("Home",style: TextStyle(
        fontSize:  23,
        fontWeight: FontWeight.bold,
        color: Color(0xff042954)
      ),),
    Text("Solar Still Sensing",style: TextStyle(
        fontSize:  23,
        fontWeight: FontWeight.bold,
        color: Color(0xff042954)
      ),),
    Text("Oil Sensing",style: TextStyle(
        fontSize:  23,
        fontWeight: FontWeight.bold,
        color:  Color(0xff042954)
      ),),
    Text("Heavy Metal",style: TextStyle(
        fontSize:  23,
        fontWeight: FontWeight.bold,
        color:  Color(0xff042954)
      ),),
  ];

  void _onItemTap(int index){
    setState(() {
      _selectedIndex = index;  
    });
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.05, // Set the height to 5% of the screen height
      title: _headingoptions.elementAt(_selectedIndex),
      elevation: 10,
      centerTitle: true,
      backgroundColor: Color(0xff74b8dc),
      actions: [
        IconButton(
          icon: Icon(Icons.dataset_outlined,),
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) {
              switch(_selectedIndex){
                case(1):
                  return DataPage(page: "Solar");
                case(2):
                  return DataPage(page: "Oil");
                case(3):
                  return DataPage(page: "Metal");
                default:
                  return DataPage(page: "Home");
              }
            }));
          },),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 20,
        selectedItemColor: Color(0xff042954),
        unselectedFontSize: 20,
        unselectedItemColor: Color(0xff042954),
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            backgroundColor: Color.fromARGB(255, 99, 140, 176),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            backgroundColor: Color(0xff74bcc6), 
            label: "Solar Still",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.oil_barrel_rounded),
            backgroundColor: Color(0xff94adc2), 
            label: "Oil Sensing",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api_outlined),
            backgroundColor: Color(0xff88939f), 
            label: "Heavy Metal Sensing",
          ),  
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),   
    );
  }
}
