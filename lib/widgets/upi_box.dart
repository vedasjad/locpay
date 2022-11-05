// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:locpay/constants.dart';
// import 'package:locpay/screens/scanner.dart';
//
// class UpiBox extends StatefulWidget {
//   const UpiBox({Key? key}) : super(key: key);
//
//   @override
//   State<UpiBox> createState() => _UpiBoxState();
// }
//
// class Controller {
//
// }
//
// class _UpiBoxState extends State<UpiBox> {
//   String upi = qr_code.upi;
//   String code = qr_code.code;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.5,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: MediaQuery.of(context).size.height / 2.5,
//                   margin: const EdgeInsets.all(10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     color: kBackgroundColour,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: const [
//                               Text(
//                                 'Beneficiary UPI',
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   fontFamily: 'Raleway',
//                                   color: kContainerColour,
//                                   fontSize: 25.0,
//                                   fontWeight: FontWeight.w900,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 'Money will go directly into Beneficiary\'s Bank Account',
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   fontFamily: 'Raleway',
//                                   color: kContainerColour,
//                                   fontSize: 15.0,
//                                   // fontWeight: FontWeight.w900,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             const Text(
//                               'To',
//                               style: TextStyle(
//                                 fontFamily: 'Raleway',
//                                 color: kContainerColour,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 17,
//                               ),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.fromLTRB(
//                                   5.0, 10.0, 10.0, 10.0),
//                               width: MediaQuery.of(context).size.width * 0.78,
//                               child: TextFormField(
//                                 controller: controllerUpi,
//                                 keyboardType: TextInputType.text,
//                                 style: const TextStyle(
//                                   // fontFamily: 'Raleway',
//                                   color: Colors.black,
//                                   // fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                                 decoration: const InputDecoration(
//                                   fillColor: kContainerColour,
//                                   filled: true,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(10),
//                                     ),
//                                   ),
//                                   hintText: "abc@upi",
//                                   contentPadding: EdgeInsets.fromLTRB(
//                                       10.0, 10.0, 10.0, 10.0),
//                                   hintStyle: TextStyle(
//                                     fontFamily: 'Raleway',
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 cursorColor: Colors.black,
//                                 // onFieldSubmitted: (value) {
//                                 //   Controller().controllerUpi.text =
//                                 //       value.toString();
//                                 //   debugPrint(value.toString());
//                                 // },
//                                 // onSaved: (value) {
//                                 //   Controller().controllerUpi.text =
//                                 //       value.toString();
//                                 //   debugPrint(value.toString());
//                                 // },
//                                 onChanged: (value) {
//                                   controllerUpi.text =
//                                       value.toString();
//                                   debugPrint(value.toString());
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             const Text(
//                               'Name',
//                               style: TextStyle(
//                                 fontFamily: 'Raleway',
//                                 color: kContainerColour,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 17,
//                               ),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.fromLTRB(
//                                   5.0, 10.0, 10.0, 10.0),
//                               width: MediaQuery.of(context).size.width * 0.7,
//                               child: TextFormField(
//                                 controller: controllerName,
//                                 keyboardType: TextInputType.text,
//                                 textCapitalization: TextCapitalization.words,
//                                 style: const TextStyle(
//                                   // fontFamily: 'Raleway',
//                                   color: Colors.black,
//                                   // fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                                 decoration: const InputDecoration(
//                                   fillColor: kContainerColour,
//                                   filled: true,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(10),
//                                     ),
//                                   ),
//                                   hintText: "Walter White",
//                                   contentPadding: EdgeInsets.fromLTRB(
//                                       10.0, 10.0, 10.0, 10.0),
//                                   hintStyle: TextStyle(
//                                     fontFamily: 'Raleway',
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 cursorColor: Colors.black,
//                                 onChanged: (value) {
//                                   controllerName.text =
//                                       value.toString();
//                                   debugPrint(value.toString());
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Phone No.',
//                               style: TextStyle(
//                                 fontFamily: 'Raleway',
//                                 color: kContainerColour,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 17,
//                               ),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.fromLTRB(
//                                   5.0, 10.0, 10.0, 10.0),
//                               width: MediaQuery.of(context).size.width * 0.65,
//                               child: TextFormField(
//                                 controller: controllerPhnumber,
//                                 keyboardType: TextInputType.phone,
//                                 style: const TextStyle(
//                                   // fontFamily: 'Raleway',
//                                   color: Colors.black,
//                                   // fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                                 decoration: const InputDecoration(
//                                   fillColor: kContainerColour,
//                                   filled: true,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(10),
//                                     ),
//                                   ),
//                                   hintText: "+91",
//                                   contentPadding: EdgeInsets.fromLTRB(
//                                       10.0, 10.0, 10.0, 10.0),
//                                   hintStyle: TextStyle(
//                                     fontFamily: 'Raleway',
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 cursorColor: Colors.black,
//                                 onChanged: (value) {
//                                   controllerPhnumber.text =
//                                       value.toString();
//                                   debugPrint(value.toString());
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         // Container(
//                         //   margin:
//                         //       const EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 10.0),
//                         //   width: MediaQuery.of(context).size.width * 0.9,
//                         //   child: TextFormField(
//                         //     keyboardType: TextInputType.text,
//                         //     style: const TextStyle(
//                         //       fontFamily: 'Raleway',
//                         //       color: Colors.black,
//                         //       fontWeight: FontWeight.bold,
//                         //       fontSize: 17,
//                         //     ),
//                         //     decoration: const InputDecoration(
//                         //       alignLabelWithHint: true,
//                         //       fillColor: kContainerColour,
//                         //       filled: true,
//                         //       border: OutlineInputBorder(
//                         //         borderRadius: BorderRadius.all(
//                         //           Radius.circular(10),
//                         //         ),
//                         //       ),
//                         //       hintText: "Message (Optional)",
//                         //       contentPadding:
//                         //           EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                         //       hintStyle: TextStyle(fontSize: 17),
//                         //     ),
//                         //     cursorColor: Colors.black,
//                         //     textCapitalization: TextCapitalization.words,
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
