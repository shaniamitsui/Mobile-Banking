import 'package:flutter/material.dart';
import 'package:practice/base_screen.dart';
import 'package:practice/transfer.dart';
import 'package:intl/intl.dart';

var f = NumberFormat('####,####,####');

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({Key? key}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  List<Step> steps = [
    Step(
      title: const Text("Amount Confirmation"),
      isActive: true,
      state: StepState.complete,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              alignment: Alignment.topLeft,
              child: Text("Transfer Amount",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Glacial Bold',
                    color: const Color(0xFFFE971A),
                    fontSize: 15,
                  ))),
          Container(
              alignment: Alignment.topLeft,
              child: Text("PHP "+Variables().money().toString(),
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Glacial Bold',
                    color: const Color(0xFFFE971A),
                    fontSize: 25,
                  ))),
        ],
      ),
    ),
    Step(
        isActive: true,
        state: StepState.complete,
        title: const Text("Please Confirm Account Number"),
        content: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text("Account Number",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Glacial Bold',
                    color: const Color(0xFFFE971A),
                    fontSize: 15,
                  )),
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Text(f.format(Variables.transferAccDetails).toString(),
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Glacial Bold',
                      color: const Color(0xFFFE971A),
                      fontSize: 25,
                    )))
          ],
        )),
    Step(
        isActive: true,
        state: StepState.complete,
        title: const Text("Notes"),
        content: Column(children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text("Notes: ",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'Glacial Bold',
                  color: const Color(0xFFFE971A),
                  fontSize: 15,
                )),
          ),
          Container(
              alignment: Alignment.topLeft,
              child: Text(Variables.transferNotes,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Glacial Bold',
                    color: const Color(0xFFFE971A),
                    fontSize: 25,
                  ))),
        ]))
  ];
  StepperType stepperType = StepperType.horizontal;

  int currentStep = 0;
  bool complete = false;

  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
    if (complete) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BaseScreen()));
    }
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - currentStep);
      if (currentStep == 0) {
        Navigator.pop(context,
            MaterialPageRoute(builder: (context) => TransferMoneyScreen()));
        // return TransferMoneyScreen();
      }
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TransferMoneyScreen()));
    }
    ;
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  switchStepType() {
    setState(() => stepperType == StepperType.horizontal
        ? stepperType = StepperType.vertical
        : stepperType = StepperType.horizontal);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff231D25),
          centerTitle: true,
          title: Text("Confirmation"),
        ),
        body: Stack(
          children: <Widget>[
            Expanded(
              child: Theme(
                data: ThemeData(
                    primarySwatch: Colors.orange,
                    colorScheme: ColorScheme.light(primary: Colors.orange)),
                child: Stepper(
                  steps: steps,
                  currentStep: currentStep,
                  onStepContinue: next,
                  onStepCancel: cancel,
                  onStepTapped: (step) => goTo(step),
                ),
              ),
            )
          ],
        ));
  }
}
