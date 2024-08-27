import 'package:flutter/material.dart' ;
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class MetalPage extends StatefulWidget {
  @override
  _MetalPageState createState() => _MetalPageState();
}

class _MetalPageState extends State<MetalPage>{

  // static const LatLng _pGooglePlex = LatLng(19.131422, 72.916072);
  // static const LatLng _pWICTRE = LatLng(19.135185, 72.918706);
  // static const LatLng _pViharLake = LatLng(19.146539, 72.912851);
  // static const LatLng _pPowaiLake = LatLng(19.127635, 72.913884);
  // static const LatLng _pGulmoharPond = LatLng(19.129927, 72.915027);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFc4cbe1),
      body: Column(
        children: [
          // GoogleMap(
          //   initialCameraPosition: CameraPosition(
          //     target: _pGooglePlex,zoom: 0.13),
          //   markers: {
          //     Marker(
          //       markerId: MarkerId("Vihar Lake"),
          //       icon: BitmapDescriptor.defaultMarker,
          //       position: _pViharLake
          //     ),
          //     Marker(
          //       markerId: MarkerId("Powai Lake"),
          //       icon: BitmapDescriptor.defaultMarker,
          //       position: _pPowaiLake
          //     ),
          //     Marker(
          //       markerId: MarkerId("Gulmohar Pond"),
          //       icon: BitmapDescriptor.defaultMarker,
          //       position: _pGulmoharPond
          //     ),
          //     Marker(
          //       markerId: MarkerId("WICTRE"),
          //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          //       position: _pWICTRE
          //     )
          //   },
          //   ),
          Image.asset(
            'assets/images/map.png',
            fit: BoxFit.cover,
            scale: 0.8, // Adjusted to make the image responsive
            ), // Adjusted to make the SizedBox responsive
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05,top:MediaQuery.of(context).size.width * 0.01 ,bottom: MediaQuery.of(context).size.height * 0.01), // Adjusted to make the padding responsive
            child:ListView(
              primary: true,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Center(child: Text("Powai Lake",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
                  fontWeight: FontWeight.w500,
                ),)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005), // Adjusted to make the SizedBox responsive
                Center(child: Text("Vihar Lake",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
                  fontWeight: FontWeight.w500,
                ),)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005), // Adjusted to make the SizedBox responsive
                Center(child: Text("WICTRE",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
                  fontWeight: FontWeight.w500,
                  color: Colors.red
                ),)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005), // Adjusted to make the SizedBox responsive
                Center(child: Text("Gulmohar Pond",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045, // Adjusted to make the font size responsive
                  fontWeight: FontWeight.w500,
                ),)),
              ],
            )
            )
          ,Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, bottom: MediaQuery.of(context).size.height * 0.01), // Adjusted to make the padding responsive
            child:ListView(
              primary: true,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Column(
                    children:[
                    Text("Cd (Cadmium)",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width * 0.04 // Adjusted to make the font size responsive
                    ),),
                    Text("Reading Time",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    ),),
                    Text("Device-id",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    ),),
                    ],
                  ),
                  Column(
                    children:[
                    Text("1 ppm",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width * 0.04 // Adjusted to make the font size responsive
                    )),
                    Text("16/07/2024, 06:15",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    )),
                    Text("sample1",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    )),
                    ],
                  )
                ]),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015), // Adjusted to make the SizedBox responsive
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Column(
                    children:[
                    Text("As (Arsenic)",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width * 0.04 // Adjusted to make the font size responsive
                    )),
                    Text("Reading Time",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    ),),
                    Text("Device-id",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    ),),
                    ],
                  ),
                  Column(
                    children:[
                    Text("0.1 ppm",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width * 0.04 // Adjusted to make the font size responsive
                    )),
                    Text("16/07/2024, 06:15",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    )),
                    Text("sample1",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    )),
                    ],
                  )
                ]),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015), // Adjusted to make the SizedBox responsive
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Column(
                    children:[
                    Text("Hg (Mercury)",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width * 0.04, // Adjusted to make the font size responsive
                      color: Colors.red
                    )),
                    Text("Reading Time",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    ),),
                    Text("Device-id",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    ),),
                    ],
                  ),
                  Column(
                    children:[
                    Text("0.08 ppm",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width * 0.04, // Adjusted to make the font size responsive
                      color: Colors.red
                    )),
                    Text("16/07/2024, 06:15",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    )),
                    Text("sample1",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    )),
                    ],
                  )
                ]),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015), // Adjusted to make the SizedBox responsive
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Column(
                    children:[
                    Text("Pb (Lead)",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width * 0.04 // Adjusted to make the font size responsive
                    )),
                    Text("Reading Time",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    ),),
                    Text("Device-id",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    ),),
                    ],
                  ),
                  Column(
                    children:[
                    Text("0.1 ppm",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width * 0.04 // Adjusted to make the font size responsive
                    )),
                    Text("16/07/2024, 06:15",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    )),
                    Text("sample1",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038 // Adjusted to make the font size responsive
                    )),
                    ],
                  )
                ]),
              ],
            )
            )
        ],
      ) 
    );
  }
}
