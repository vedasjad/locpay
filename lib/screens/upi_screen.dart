import 'package:flutter/material.dart';
import 'package:locpay/constants.dart';
import 'package:locpay/widgets/amount_box.dart';
import 'package:locpay/screens/scanner.dart';

class UpiScreen extends StatefulWidget {
  const UpiScreen({Key? key}) : super(key: key);
  @override
  State<UpiScreen> createState() => _UpiScreenState();
}

class _UpiScreenState extends State<UpiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kIconColour,
        title: const Text(
          'LocPay',
          style: TextStyle(
            fontFamily: 'Raleway',
            color: kContainerColour,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.cabin))],
      ),
      // bottomNavigationBar: TextButton(
      //   style: ButtonStyle(
      //     backgroundColor:
      //         MaterialStateColor.resolveWith((states) => kIconColour),
      //     fixedSize: MaterialStateProperty.resolveWith(
      //       (states) => Size(MediaQuery.of(context).size.width, 60.0),
      //     ),
      //   ),
      //   child: const Text(
      //     'PROCEED',
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //       fontFamily: 'Raleway',
      //       color: kContainerColour,
      //       fontSize: 25.0,
      //       fontWeight: FontWeight.w900,
      //     ),
      //   ),
      //   onPressed: () {},
      // ),
      body: SafeArea(
        child: Column(
          children: const <Widget>[
            AmountBox(),
          ],
        ),
      ),
    );
  }
}
