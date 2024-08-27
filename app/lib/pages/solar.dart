import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart' ;
import 'package:http/http.dart' as http;
import 'dart:convert';

class SolarPage extends StatefulWidget {
  SolarPage({Key? key,}) : super(key:key) ;
  @override
  _SolarPageState createState() => _SolarPageState();
}

class _SolarPageState extends State<SolarPage>{
  late List<LiveData> chartData1,chartData2,ChartData3;
  late ChartSeriesController _chartSeriesController1,_chartSeriesController2,_chartSeriesController3;
  @override
  void initState(){
    Timer.periodic(const Duration(seconds: 2), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var chart_1,chart_2,chart_3;
    Future<num> totalSales = getyield(DateTime.now().subtract(Duration(days: 1)).toString().split(' ')[0]);
    return Scaffold(
            backgroundColor: Color(0xffc4cbe1),
            body: Column(
              children: [
                DateChanger(),
                Card(
                  elevation: 8,
                  color: Color.fromARGB(255, 164, 173, 209),
                  child:Column(children: [ 
                    SizedBox(height: 20,),
                    StatefulBuilder(
                      builder: (context, setState) {
                        setState(() {
                          chart_1 = chart1(DateTime.now().subtract(Duration(days: 1)).toString().split(' ')[0]);
                        });
                        return chart_1;
                      },
                    ),
                    ]
                  )
                ),
                Card(
                  elevation: 8,
                  color: Color.fromARGB(255, 164, 173, 209),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      StatefulBuilder(
                        builder: (context, setState) {
                          setState(() {
                            chart_2 = chart2(DateTime.now().subtract(Duration(days: 1)).toString().split(' ')[0]);
                          });
                          return chart_2;
                        },
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 8,
                  color: Color.fromARGB(255, 164, 173, 209),
                  child:Column(children: [ 
                    SizedBox(height: 20,),
                    StatefulBuilder(
                      builder: (context, setState) {
                        setState(() {
                          chart_3 = chart3(DateTime.now().subtract(Duration(days: 1)).toString().split(' ')[0]);
                        });
                        return chart_3;
                      },
                    ),
                    FutureBuilder(future: totalSales, 
                    builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.data != null){
                          return Center(child: Text('Total Permeate: ${snapshot.data} ml',
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043,
                                           fontWeight: FontWeight.w500 )
                          ),);
                        }}

                      return Center(child: Text('Total Permeate: Loading... ',
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043,
                                           fontWeight: FontWeight.w500 )),);
                    })
                    ]
                  )
                )
              ],
            ),
                  );
  }

  Widget DateChanger(){
    return FutureBuilder(
      future: getdates(), 
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data != null){
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                DropdownButton<String>(
                  value: snapshot.data![snapshot.data!.length -1],
                  icon: Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    ),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      chart1(newValue!);
                      chart2(newValue!);
                      chart3(newValue!);
                    });
                  },
                  items: snapshot.data!
                      .map<DropdownMenuItem<String>>((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      })
                      .toList(),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05,)
              ],
            );
            }
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: (){}, child:Text("Date")),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05,)
            ],
          );
        }
      );
  }

  Future<List<String>> getdates() async{
    List<String> dates = [];
    final url = 'https://data-iitb-default-rtdb.firebaseio.com/.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      jsonData.forEach((key, value) {
        String keySplit = key.split(" ")[0];
        dates.add(keySplit.substring(0, 10));
      });
    }
    dates = dates.toSet().toList();
    return dates;
  }

  Widget chart1(String date){
    return FutureBuilder(
      future: getChartData1(date), 
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data != null){
              return Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: SfCartesianChart(
                series: <ColumnSeries<LiveData, num>>[
                  ColumnSeries<LiveData, num>(
                    onRendererCreated: (ChartSeriesController controller2) {
                      _chartSeriesController1 = controller2;
                    },
                    dataSource: snapshot.data,
                    color: Color.fromARGB(255, 30, 143, 17),
                    xValueMapper: (LiveData sales, _) => sales.time,
                    yValueMapper: (LiveData sales, _) => sales.value,
                    enableTooltip: true,
                    animationDuration: 1000,
                    animationDelay: 1000,
                  )
                ],
                primaryXAxis: NumericAxis(
                    minimum: snapshot.data![0].time.toDouble()-1,
                    maximum: 24,
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 2,
                    title: AxisTitle(text: 'Time (hours)',textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),),
                primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: 'Water\nTemperature (\u2103)',textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),)
              ),
            );
            }
          }
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: SfCartesianChart(
              primaryXAxis: NumericAxis(
                    minimum: 0,
                    maximum: 24,
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 3,
                    title: AxisTitle(text: 'Time (hours)',textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),),
                primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: 100,
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: 'Water\nTemperature (\u2103)',textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),)
            ),),
            Center(
              child: Column(
                children: [SizedBox(height: 70,),CircularProgressIndicator()],
              ),
            ),
          ],
        );
      });
  }

    Widget chart2(String date){
    return FutureBuilder(
      future: getChartData2(date), 
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data != null){
              return Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: SfCartesianChart(
                series: <ColumnSeries<LiveData, num>>[
                  ColumnSeries<LiveData, num>(
                    onRendererCreated: (ChartSeriesController controller2) {
                      _chartSeriesController1 = controller2;
                    },
                    dataSource: snapshot.data,
                    color: Color.fromARGB(255, 170, 59, 31),
                    xValueMapper: (LiveData sales, _) => sales.time,
                    yValueMapper: (LiveData sales, _) => sales.value,
                    enableTooltip: true,
                    animationDuration: 1000,
                    animationDelay: 1000,
                  )
                ],
                primaryXAxis: NumericAxis(
                    minimum: snapshot.data![0].time.toDouble() -1 ,
                    maximum: 24,
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 2,
                    title: AxisTitle(text: 'Time (hours)',textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),),
                primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: 'Glass Surface\nTemperature (\u2103)',textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),)
              ),
            );
            }
          }
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: SfCartesianChart(
              primaryXAxis: NumericAxis(
                    minimum: 0,
                    maximum: 24,
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 3,
                    title: AxisTitle(text: 'Time (hours)',textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),),
                primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: 60,
                    interval: 20,
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: 'Glass Surface\nTemperature (\u2103)',textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),)
            ),),
            Center(
              child: Column(
                children: [SizedBox(height: 70,),CircularProgressIndicator()],
              ),
            ),
          ],
        );
      });
  }

  Widget chart3(String date){
    return FutureBuilder(
      future: getChartData3(date), 
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data != null){
              return Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: SfCartesianChart(
                series: <ColumnSeries<LiveData, num>>[
                  ColumnSeries<LiveData, num>(
                    onRendererCreated: (ChartSeriesController controller2) {
                      _chartSeriesController1 = controller2;
                    },
                    dataSource: snapshot.data,
                    color: Color.fromARGB(255, 144, 34, 82),
                    xValueMapper: (LiveData sales, _) => sales.time,
                    yValueMapper: (LiveData sales, _) => sales.value,
                    enableTooltip: true,
                    animationDuration: 1000,
                    animationDelay: 1000,
                  )
                ],
                primaryXAxis: NumericAxis(
                    minimum: snapshot.data![0].time.toDouble()-1,
                    maximum: 24,
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 2, // Changed from 3 to 5 to make a space of 2 between consecutive markings
                    title: AxisTitle(text: 'Time (hours)',textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),),
                primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: 800,
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: 'Yield (ml/m\u00b2)',textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),)
              ),
            );
            }
          }
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: SfCartesianChart(
              primaryXAxis: NumericAxis(
                    minimum: 0,
                    maximum: 24,
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 3,
                    title: AxisTitle(text: 'Time (hours)',textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),),
                primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: 800,
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: 'Yield (ml/m\u00b2)',textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),)
            ),),
            Center(
              child: Column(
                children: [SizedBox(height: 70,),CircularProgressIndicator()],
              ),
            ),
          ],
        );
      });
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    chartData1.add(LiveData(time++, (math.Random().nextInt(60) +30 )));
    _chartSeriesController1.updateDataSource(
      addedDataIndex: chartData1.length -1,
    );
    chartData2.add(LiveData(time++, (math.Random().nextInt(60) +30 )));
    _chartSeriesController2.updateDataSource(
      addedDataIndex: chartData2.length -1,
    );
    ChartData3.add(LiveData(time++, (math.Random().nextInt(60) +30 )));
    _chartSeriesController3.updateDataSource(
      addedDataIndex: ChartData3.length -1,
    );
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
}

Future<num> getyield(String date) async{
  num total=0;
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
      num permeate_total =0;
      num intercept = 80, B1 = -80, B2= 32,B3= -0.5;
      for(int i=0; i<dates.length; i++){
        if(dates[i] == date){
          num temp = num.parse(wt[i]) - num.parse(gst[i]) ;
          num temp_value = intercept + B1*temp + B2*temp*temp + B3*temp*temp*temp;
          permeate_total =permeate_total +temp_value;
        }
      }
      return permeate_total;
    }

  return total;
}

class LiveData{
    LiveData(this.time,this.value);
    final num time;
    final num value;
  }