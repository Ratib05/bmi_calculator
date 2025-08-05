import 'package:flutter/material.dart';

// entry point of the app
void main() {
  runApp(const MyApp());
}

// This widget is the root of your application.
// set up gloabl config for the whole app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI calculator',

      debugShowCheckedModeBanner:
          false, // Hides debug banner that is in the top-right corner

      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home: MyHomePage(title: 'BMI calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // the title is passed to the appbar
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// this class holds the mutable (changeable) state
class _MyHomePageState extends State<MyHomePage> {
  // controllers are used to access the contents of textfields
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // this variable holds the output BMI string with the value and category
  String _bmiResult = '';

  // This method calculates the BMI and returns a string with the value and category
  String calculateBMI() {
    // convert the user input in the text fields into integers
    int height = int.tryParse(_heightController.text) ?? 0;
    int weight = int.tryParse(_weightController.text) ?? 0;

    // calculate the BMI weight / (height)^2
    double bmi = weight / ((height / 100) * (height / 100));
    String result;

    // classify the BMI
    if (bmi < 18.5) {
      result = "Underweight";
    } else if (bmi < 25) {
      result = "Healthy weight";
    } else if (bmi < 30) {
      result = "overweight";
    } else {
      result = "Obese";
    }

    // Return both the BMI number and its category
    return "BMI = ${bmi.toStringAsFixed(1)} ($result)";
  }

  // UI is built here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),

        // this button clears input and output
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _heightController.clear();
                _weightController.clear();
                _bmiResult = "";
              });
            },
            icon: Icon(Icons.delete), // trash icon
          ),
        ],
      ),

      // main content area of the app
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            // adds space around the inner column
            Padding(
              padding: EdgeInsets.all(200),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  // user input area
                  TextField(
                    controller: _heightController,

                    decoration: InputDecoration(
                      labelText: "Enter height in cm", // hint text
                      border:
                          OutlineInputBorder(), // border around the user input area, makes it easier to see
                    ),
                  ),

                  // creates vertical space between the two text fields
                  const SizedBox(height: 16),

                  TextField(
                    controller: _weightController,

                    decoration: InputDecoration(
                      labelText: "Enter weight in KG", // hint text
                      border:
                          OutlineInputBorder(), // border around the user input area, makes it easier to see
                    ),
                  ),

                  // creates vertical space between the text field and the result text
                  const SizedBox(height: 16),

                  Text(_bmiResult),
                ],
              ),
            ),

            // button used to trigger BMI calculation
            ElevatedButton(
              // when pressed -
              onPressed: () {
                setState(() {
                  _bmiResult =
                      calculateBMI(); // - trigger the function and update the UI
                });
              },

              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.blue, // make the background of the button blue
                foregroundColor:
                    Colors.white, // make the text of the button white
              ),

              child: const Text("Calculate BMI"),
            ),
          ],
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
