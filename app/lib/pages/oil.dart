import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class OilPage extends StatefulWidget {
  @override
  _OilPageState createState() => _OilPageState();
}

class _OilPageState extends State<OilPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffc4cbe1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Added spacing between AppBar and first Graph
            Center(
              child: AspectRatio(
                aspectRatio: 2.0,
                child: LineChart(
                  LineChartData(
                    maxY: 60,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(9, 25),
                          FlSpot(10, 27.85),
                          FlSpot(11, 32.78),
                          FlSpot(12, 39.72),
                          FlSpot(13, 42.82),
                          FlSpot(14, 50.76),
                          FlSpot(15, 52.04),
                          FlSpot(16, 49.92),
                          FlSpot(17, 45.48),
                          FlSpot(18, 38.28),
                        ],
                        isCurved: true,
                        color: Colors.orange,
                        dotData: FlDotData(show: true),
                        isStrokeCapRound: true,
                        dashArray: [5, 5],
                      ),
                    ],
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        axisNameSize: 40,
                        axisNameWidget: Text(
                          "Water Temperature (°C)",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04, // Adjusted font size for responsiveness
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                      )
                  )
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04), // Adjusted spacing for responsiveness
            Center(
              child: AspectRatio(
                aspectRatio: 2.0,
                child: LineChart(
                  LineChartData(
                    maxY: 60,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(9, 20),
                          FlSpot(10, 22.62),
                          FlSpot(11, 28.15),
                          FlSpot(12, 35.10),
                          FlSpot(13, 37.64),
                          FlSpot(14, 43.60),
                          FlSpot(15, 48.47),
                          FlSpot(16, 41.92),
                          FlSpot(17, 38.17),
                          FlSpot(18, 30.07),
                        ],
                        isCurved: true,
                        color: Colors.orange,
                        dotData: FlDotData(show: true),
                        isStrokeCapRound: true,
                        dashArray: [5, 5],
                      ),
                    ],
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        axisNameSize: 40,
                        axisNameWidget: Text(
                          "pH",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04, // Adjusted font size for responsiveness
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                      )
                  )
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04), // Adjusted spacing for responsiveness
            Center(
              child: AspectRatio(
                aspectRatio: 2.0,
                child: BarChart(
                  BarChartData(
                    maxY: 600,
                    barGroups: [
                      BarChartGroupData(
                        x: 9,
                        barRods: [
                          BarChartRodData(
                            toY: 96,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 10,
                        barRods: [
                          BarChartRodData(
                            toY: 131,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 11,
                        barRods: [
                          BarChartRodData(
                            toY: 197,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 12,
                        barRods: [
                          BarChartRodData(
                            toY: 249,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 13,
                        barRods: [
                          BarChartRodData(
                            toY: 315,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 14,
                        barRods: [
                          BarChartRodData(
                            toY: 388,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 15,
                        barRods: [
                          BarChartRodData(
                            toY: 445,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 16,
                        barRods: [
                          BarChartRodData(
                            toY: 315,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 17,
                        barRods: [
                          BarChartRodData(
                            toY: 234,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 18,
                        barRods: [
                          BarChartRodData(
                            toY: 164,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ],
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        axisNameSize: 40,
                        axisNameWidget: Text(
                          "TDS (ppm)",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04, // Adjusted font size for responsiveness
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
