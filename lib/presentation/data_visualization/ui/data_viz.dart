import 'package:chatbotgpt/utils/constwidgets.dart';
import 'package:flutter/material.dart';

class DataViz extends StatefulWidget {
  const DataViz({super.key});

  @override
  State<DataViz> createState() => _DataVizState();
}

class _DataVizState extends State<DataViz> {
  CustomWidgets customWidgets = CustomWidgets();
  ConstWidgets constWidgets = ConstWidgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: customWidgets.textWidget(
              'DataShow', FontWeight.w600, 18, Colors.white),
          backgroundColor: Colors.indigo,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      customContainers(),
                      customContainers(),
                      customContainers(),
                      customContainers(),
                    ],
                  ),
                  Column(
                    children: [
                      customContainers(),
                      customContainers(),
                      customContainers(),
                      customContainers(),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

Widget customContainers() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 32, top: 32),
    child: Container(
      height: 500,
      width: 800,
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 5, // How much the shadow should spread
            blurRadius: 7, // The blur radius of the shadow
            offset:
                const Offset(0, 3), // Offset of the shadow from the container
          ),
        ],
        border: Border.all(
          color: Colors.indigo, // Border color
          width: 0.3,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
