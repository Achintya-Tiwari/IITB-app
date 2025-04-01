import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ChartColumn extends StatefulWidget {
  const ChartColumn({super.key});

  @override
  _ChartColumnState createState() => _ChartColumnState();
}

class _ChartColumnState extends State<ChartColumn> {
  late Future<List<LiveData>> chartData1;
  late Future<List<LiveData>> chartData2;
  late Future<List<LiveData>> chartData3;
  late Future<List<LiveData>> chartData4;
  List<String> dates = []; // Store the dates
  String? selectedDate; // Store the selected date

  @override
  void initState() {
    super.initState();
    updateChartData();
    fetchDates(); // Fetch dates on initialization
    Timer.periodic(Duration(seconds: 50), (Timer t) => updateChartData());
  }

  void updateChartData() {
    String date = selectedDate ?? DateTime.now().subtract(Duration(days: 1)).toString().split(' ')[0];
    setState(() {
      chartData1 = getChartData1(date);
      chartData2 = getChartData2(date);
      chartData3 = getChartData3(date);
      chartData4 = getChartData4(date);
    });
  }

  Future<void> fetchDates() async {
    final url = 'https://data-iitb-default-rtdb.firebaseio.com/.json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> fetchedDates = [];
      jsonData.forEach((key, value) {
        String keySplit = key.split(" ")[0];
        fetchedDates.add(keySplit.substring(0, 10));
      });
      setState(() {
        dates = fetchedDates.toSet().toList();
        selectedDate = dates.isNotEmpty ? dates.last : 'No Dates Available'; // Remove duplicates
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(padding: EdgeInsets.all(16.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(selectedDate ?? 'No Date Selected', style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w700
                )),
                Text('Current Statistics', style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                )),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    showDateDropdown(); // Show dropdown on button press
                  }, 
                  icon: Icon(Icons.more_vert)
                )
              ],
            )
          ],
        ),
        SizedBox(height: 32,),
        Row(
          children: [
            Container(
              width: 20,
              height: 13,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 64, 214, 47),
                borderRadius: BorderRadius.circular(20)
              ),
            ),
            SizedBox(width: 10,),
            Text("Water Temp. (°C)",style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(width: 16,),
            Container(
              width: 20,
              height: 13,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 222, 100, 34),
                borderRadius: BorderRadius.circular(20)
              ),
            ),
            SizedBox(width: 10,),
            Text("Yield (ml/m\u00b2)",style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),),
          ],
        ),
        Row(
          children: [
            Container(
              width: 20,
              height: 13,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 123, 23, 68),
                borderRadius: BorderRadius.circular(20)
              ),
            ),
            SizedBox(width: 10,),
            Text("Glass Surface Temp. (°C)",style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(width: 10,),
            Container(
              width: 20,
              height: 13,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 51, 112, 143),
                borderRadius: BorderRadius.circular(20)
              ),
            ),
            SizedBox(width: 16,),
            Text("Basin Humidity",style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),)
          ],
        ),
        SizedBox(height: 16,),
      SingleChildScrollView(
        child: Column(
          children: [
          FutureBuilder<List<LiveData>>(
            future: chartData1,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Container(
                  height: 300,
                  child: SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(
                          enable: true,
                          format: 'Time: {x} hours\nTemperature: {y} °C',
                        ),
                    series: <SplineSeries<LiveData, num>>[
                      SplineSeries<LiveData, num>(
                        dataSource: snapshot.data!,
                        xValueMapper: (LiveData data, _) => data.time,
                        yValueMapper: (LiveData data, _) => data.value,
                        enableTooltip: true,
                      )
                    ],
                    primaryXAxis: NumericAxis(
                      title: AxisTitle(text: 'Time (hours)'),
                      interval: 1,
                    ),
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Water Temperature'),
                    ),
                  ),
                );
              }
              return Container(); // Fallback for any other state
            },
          ),
          FutureBuilder<List<LiveData>>(
            future: chartData2,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Container(
                  height: 300,
                  child: SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(
                          enable: true,
                          format: 'Time: {x} hours\nTemperature: {y} °C',
                        ),
                    series: <SplineSeries<LiveData, num>>[
                      SplineSeries<LiveData, num>(
                        dataSource: snapshot.data!,
                        xValueMapper: (LiveData data, _) => data.time,
                        yValueMapper: (LiveData data, _) => data.value,
                        enableTooltip: true,
                      )
                    ],
                    primaryXAxis: NumericAxis(
                      title: AxisTitle(text: 'Time (hours)'),
                      interval: 1,
                    ),
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Glass Surface Temp.'),
                    ),
                  ),
                );
              }
              return Container(); // Fallback for any other state
            },
          ),
          FutureBuilder<List<LiveData>>(
            future: chartData3,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Container(
                  height: 300,
                  child: SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(
                          enable: true,
                          format: 'Time: {x} hours\nTemperature: {y} °C',
                        ),
                    series: <SplineSeries<LiveData, num>>[
                      SplineSeries<LiveData, num>(
                        dataSource: snapshot.data!,
                        xValueMapper: (LiveData data, _) => data.time,
                        yValueMapper: (LiveData data, _) => data.value,
                        enableTooltip: true,
                      )
                    ],
                    primaryXAxis: NumericAxis(
                      title: AxisTitle(text: 'Time (hours)'),
                      interval: 1,
                    ),
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Yield'),
                    ),
                  ),
                );
              }
              return Container(); // Fallback for any other state
            },
          ),
          FutureBuilder<List<LiveData>>(
            future: chartData4,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Container(
                  height: 300,
                  child: SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(
                          enable: true,
                          format: 'Time: {x} hours\nTemperature: {y} °C',
                        ),
                    series: <SplineSeries<LiveData, num>>[
                      SplineSeries<LiveData, num>(
                        dataSource: snapshot.data!,
                        xValueMapper: (LiveData data, _) => data.time,
                        yValueMapper: (LiveData data, _) => data.value,
                        enableTooltip: true,
                      )
                    ],
                    primaryXAxis: NumericAxis(
                      title: AxisTitle(text: 'Time (hours)'),
                      interval: 1,
                    ),
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Basin Humidity'),
                    ),
                  ),
                );
              }
              return Container(); // Fallback for any other state
            },
          ),
          ],
        ),
      ),
      ],),
      ),
    );
  }

  void showDateDropdown() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Date"),
          content: SingleChildScrollView(
            child: ListBody(
              children: dates.map((date) {
                return ListTile(
                  title: Text(date),
                  onTap: () {
                    setState(() {
                      selectedDate = date; // Update selected date
                      updateChartData(); // Update charts with the selected date
                    });
                    Navigator.of(context).pop(); // Close the dialog
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<LiveData>> getChartData4(String date) async{
    final url = 'https://data-iitb-default-rtdb.firebaseio.com/.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> GST = [];
      List<String> times= [];
      List<String> dates= [];
      jsonData.forEach((key, value) {
        String keySplit = key.split(" ")[0];
        dates.add(keySplit.substring(0, 10));
        times.add(keySplit.substring(10));
        value.forEach((a,b){
          if(a == "IH"){GST.add(b.toString());
          };
        });
      });
      if (DateTime.parse(date).day == DateTime.now().subtract(Duration(days: 1)).day) {
        date = dates[dates.length -1];
      }
      List<LiveData> chart= [];
      for(int i=0; i<dates.length; i++){
        if(dates[i] == date){
          num temp_time = num.parse(times[i].substring(0,2))+(num.parse(times[i].substring(3,5))/60)+(num.parse(times[i].substring(6))/3600) ;
          num temp_wt = num.parse(GST[i]);
          chart.add(LiveData(temp_time, temp_wt));  
        }
      }
      return chart;
    }
    return <LiveData>[];
  }

  Future<List<LiveData>> getChartData3(String date) async{
    final url = 'https://data-iitb-default-rtdb.firebaseio.com/.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> permeate = [];
      List<String> wt = [];
      List<String> gst = [];
      List<String> times= [];
      List<String> dates= [];
      jsonData.forEach((key, value) {
        String keySplit = key.split(" ")[0];
        dates.add(keySplit.substring(0, 10));
        times.add(keySplit.substring(10));
        value.forEach((a,b){
          if(a == "yield"){permeate.add(b.toString());}
          else if(a == "WT"){wt.add(b.toString());}
          else if(a == "GST"){gst.add(b.toString());}
        });
      });
      if (DateTime.parse(date).day == DateTime.now().subtract(Duration(days: 1)).day) {
        date = dates[dates.length -1];
      }
      List<LiveData> chart= [];
      num intercept = 80, B1 = -80, B2= 32,B3= -0.5;
      for(int i=0; i<dates.length; i++){
        if(dates[i] == date){
          num temp = num.parse(wt[i]) - num.parse(gst[i]) ;
          num temp_value = intercept + B1*temp + B2*temp*temp + B3*temp*temp*temp;
          num temp_time = num.parse(times[i].substring(0,2))+(num.parse(times[i].substring(3,5))/60)+(num.parse(times[i].substring(6))/3600) ;
          chart.add(LiveData(temp_time, temp_value));  
        }
      }
      return chart;
    }
    return <LiveData>[];
  }
  
  Future<List<LiveData>> getChartData2(String date) async{
    final url = 'https://data-iitb-default-rtdb.firebaseio.com/.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> GST = [];
      List<String> times= [];
      List<String> dates= [];
      jsonData.forEach((key, value) {
        String keySplit = key.split(" ")[0];
        dates.add(keySplit.substring(0, 10));
        times.add(keySplit.substring(10));
        value.forEach((a,b){
          if(a == "GST"){GST.add(b.toString());
          };
        });
      });
      if (DateTime.parse(date).day == DateTime.now().subtract(Duration(days: 1)).day) {
        date = dates[dates.length -1];
      }
      List<LiveData> chart= [];
      for(int i=0; i<dates.length; i++){
        if(dates[i] == date){
          num temp_time = num.parse(times[i].substring(0,2))+(num.parse(times[i].substring(3,5))/60)+(num.parse(times[i].substring(6))/3600) ;
          num temp_wt = num.parse(GST[i]);
          chart.add(LiveData(temp_time, temp_wt));  
        }
      }
      return chart;
    }
    return <LiveData>[];
  }

  Future<List<LiveData>> getChartData1(String date) async{
    final url = 'https://data-iitb-default-rtdb.firebaseio.com/.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> WT = [];
      List<String> times= [];
      List<String> dates= [];
      jsonData.forEach((key, value) {
        String keySplit = key.split(" ")[0];
        dates.add(keySplit.substring(0, 10));
        times.add(keySplit.substring(10));
        value.forEach((a,b){
          if(a == "WT"){WT.add(b.toString());
          };
        });
      });
      List<LiveData> chart= [];
      
      if (DateTime.parse(date).day == DateTime.now().subtract(Duration(days: 1)).day) {
        date = dates[dates.length -1];
      }
      for(int i=0; i<dates.length; i++){
        if(dates[i] == date){
          num temp_time = num.parse(times[i].substring(0,2))+(num.parse(times[i].substring(3,5))/60)+(num.parse(times[i].substring(6))/3600) ;
          num temp_wt = num.parse(WT[i]);
          chart.add(LiveData(temp_time, temp_wt));  
        }
      }
      return chart;
    }
    return <LiveData>[];
  }
}

class LiveData{
    LiveData(this.time,this.value);
    final num time;
    final num value;
  }