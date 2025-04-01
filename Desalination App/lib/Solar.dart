import 'package:flutter/material.dart';
import 'GraphStructures.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ChartColumn()
            ],
          ),
          ),
      ),
    );
    }
}