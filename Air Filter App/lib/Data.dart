import 'package:flutter/material.dart' ;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';



Future<Map<String,List<String>>> SolarData() async {
  final url = 'https://air-filter-iitb-default-rtdb.firebaseio.com/.json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    List<String> InnerTempi = [];
    List<String> InnerDust = [];
    List<String> OutterTemp = [];
    List<String> time= [];
    List<String> date= [];
    List<String> OutterDust= [];
    jsonData.forEach((key, value) {
      String keySplit = key.split(" ")[0];
      date.add(keySplit.substring(0, 10));
      time.add(keySplit.substring(10));
      value.forEach((a,b){
        if(a == "InnerTemp"){InnerTempi.add(b.toString());}
        else if(a == "OutterTemp"){OutterTemp.add(b.toString());}
        else if(a == "InnerDust"){InnerDust.add(b.toString());}
        else if(a == "OutterDust"){OutterDust.add(b.toString());}
      });
    });
    Map<String,List<String>> rows= {};
    rows["Date"] = date;
    rows["Time"] = time;
    rows["InnerTemp"] = InnerTempi;
    rows["OutterTemp"] = OutterTemp;
    rows["InnerDust"] = InnerDust;
    rows["OutterDust"] = OutterDust;
    return rows;
  } else {
    throw Exception('Failed to load data');
  }
}


class DataPage extends StatefulWidget { // Changed to final
  const DataPage({super.key,
  });

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage>{
  
  @override
  Widget build(BuildContext context){
    SolarData();
    return Scaffold(
      body: FutureBuilder(
        future: SolarData(), 
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data != null){
              Map<String,List<String>> data = snapshot.data!;
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Time")),
                        DataColumn(label: Text("Inner\nTemperature(\u2103)")),
                        DataColumn(label: Text("Inner\nDust (µg/m³)")),
                        DataColumn(label: Text("Outter\nTemperature(\u2103)")),
                        DataColumn(label: Text("Outter\nDust(µg/m³)")),
                      ],
                      rows: [
                        ...List.generate(
                          data["Date"]!.length-2,
                          (index) => DataRow(cells: [
                            DataCell(Text(data["Date"]![index])),
                            DataCell(Text(data["Time"]![index])),
                            DataCell(Text(data["InnerTemp"]![index])),
                            DataCell(Text(data["OutterTemp"]![index])),
                            DataCell(Text(data["InnerDust"]![index])),
                            DataCell(Text(data["OutterDust"]![index])),
                          ])
                        ),
                      ],
                    ),
                  ),
                );
            }
            else{
              return Center(
                child: Text(
                  "No data to show",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
          );
          }
        }
          print("condition failed");
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {});
    });
  }
}