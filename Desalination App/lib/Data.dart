import 'package:flutter/material.dart' ;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';



Future<Map<String,List<String>>> SolarData() async {
  final url = 'https://data-iitb-default-rtdb.firebaseio.com/.json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    List<String> AH = [];
    List<String> AT = [];
    List<String> GSTi = [];
    List<String> IH = [];
    List<String> IT = [];
    List<String> TDS = [];
    List<String> WT = [];
    List<String> time= [];
    List<String> date= [];
    List<String> permeate= [];
    jsonData.forEach((key, value) {
      String keySplit = key.split(" ")[0];
      date.add(keySplit.substring(0, 10));
      time.add(keySplit.substring(10));
      value.forEach((a,b){
        if(a == "AH"){AH.add(b.toString());}
        else if(a == "AT"){AT.add(b.toString());}
        else if(a == "GST"){GSTi.add(b.toString());}
        else if(a == "WT"){WT.add(b.toString());}
        else if(a == "IT"){IT.add(b.toString());}
        else if(a == "IH"){IH.add(b.toString());}
        else if(a == "TDS"){TDS.add(b.toString());}
        else if(a == "yield"){permeate.add(b.toString());}
      });
    });
    Map<String,List<String>> rows= {};
    rows["Date"] = date;
    rows["Time"] = time;
    rows["AH"] = AH;
    rows["AT"] = AT;
    rows["GST"] = GSTi;
    rows["WT"] = WT;
    rows["IT"] = IT;
    rows["IH"] = IH;
    rows["TDS"] = TDS;
    rows["yield"] = permeate;
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
                        DataColumn(label: Text("Ambient \nHumidity(%)")),
                        DataColumn(label: Text("Ambient \nTemperature(\u2103)")),
                        DataColumn(label: Text("Glass Surface \nTemperature(\u2103)")),
                        DataColumn(label: Text("Inner \nHumidity(%)")),
                        DataColumn(label: Text("Inner \nTemperature(\u2103)")),
                        DataColumn(label: Text("TDS(ppm)")),
                        DataColumn(label: Text("Water \nTemperature(\u2103)")),
                        DataColumn(label: Text("Yield (ml)")),
                      ],
                      rows: [
                        ...List.generate(
                          data["Date"]!.length-2,
                          (index) => DataRow(cells: [
                            DataCell(Text(data["Date"]![index])),
                            DataCell(Text(data["Time"]![index])),
                            DataCell(Text(data["AH"]![index])),
                            DataCell(Text(data["AT"]![index])),
                            DataCell(Text(data["GST"]![index])),
                            DataCell(Text(data["WT"]![index])),
                            DataCell(Text(data["IT"]![index])),
                            DataCell(Text(data["IH"]![index])),
                            DataCell(Text(data["TDS"]![index])),
                            DataCell(Text(data["yield"]![index])),
                          ])
                        ),
                      ],
                    ),
                  ),
                );
            }
          }
          print("condition failed");
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 20), (timer) {
      setState(() {});
    });
  }
}