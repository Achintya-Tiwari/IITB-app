import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  _BottombarState createState() => _BottombarState(shell);
}

class _BottombarState extends State<Bottombar> {
  final StatefulNavigationShell shell;

  _BottombarState(this.shell);
  
  Widget build(BuildContext context) {
    int _selectedIndex = widget.shell.currentIndex;

    List<Widget> _headingoptions = <Widget>[
      Text("Home", style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Color(0xff042954)
        ),),
      Text("Solar Still Sensing", style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Color(0xff042954)
        ),),
      Text("Raw Data", style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Color(0xff042954)
        ),),      
    ];

    // Define different background colors for each page
    Color bottomNavBarColor;
    switch (_selectedIndex) {
      case 0:
        bottomNavBarColor = Color.fromARGB(255, 136, 250, 237); // Home color
        break;
      case 1:
        bottomNavBarColor = Color.fromARGB(255, 255, 223, 186); // Solar Still color
        break;
      case 2:
        bottomNavBarColor = Color.fromARGB(255, 186, 255, 223); // Raw Data color
        break;
      default:
        bottomNavBarColor = Color.fromARGB(255, 136, 250, 237); // Default color
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.05, // Set the height to 5% of the screen height
        title: _headingoptions.elementAt(_selectedIndex),
        elevation: 10,
        centerTitle: true,
        backgroundColor: bottomNavBarColor, // Set AppBar color to match Bottom Navigation Bar
      ),
      body: widget.shell,
      bottomNavigationBar: BottomNavigationBar(
        onTap: shell.goBranch,
        currentIndex: widget.shell.currentIndex,
        backgroundColor: bottomNavBarColor, // Use the dynamic color
        selectedItemColor: Color(0xff042954),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.sunny), label: "Solar Still"),
          BottomNavigationBarItem(icon: Icon(Icons.save_outlined), label: "Raw Data"),
        ],
      ),
    );
  }
}