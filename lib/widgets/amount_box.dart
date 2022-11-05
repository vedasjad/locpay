import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locpay/constants.dart';
import 'package:locpay/screens/scanner.dart';
import 'package:upi_pay/upi_pay.dart';
import 'dart:math';
import 'dart:io';

class AmountBox extends StatefulWidget {
  const AmountBox({Key? key}) : super(key: key);

  @override
  State<AmountBox> createState() => _AmountBoxState();
}

class _AmountBoxState extends State<AmountBox> {
  TextEditingController controllerAmount = TextEditingController();
  TextEditingController controllerMessage = TextEditingController();
  String upi = qr_code.upi;
  String code = qr_code.code;
  final startIndex = qr_code.code.indexOf('&pn=') + 4;
  final endIndex = qr_code.code.indexOf('&mc=');
  late String name_final = qr_code.code.substring(startIndex, endIndex);
  late String name = name_final.replaceAll('%20%20', ' ');

  List<ApplicationMeta>? _apps;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 0), () async {
      _apps = await UpiPay.getInstalledUpiApplications(
          statusType: UpiApplicationDiscoveryAppStatusType.all);
      setState(() {});
    });
  }

  @override
  void dispose() {
    controllerAmount.dispose();
    super.dispose();
  }

  Future<void> _onTap(ApplicationMeta app) async {
    final transactionRef = Random.secure().nextInt(1 << 32).toString();
    debugPrint("Starting transaction with id $transactionRef");

    final a = await UpiPay.initiateTransaction(
      amount: controllerAmount.text,
      app: app.upiApplication,
      receiverName: name,
      receiverUpiAddress: qr_code.upi,
      transactionRef: transactionRef,
      transactionNote: 'UPI Payment',
    );

    debugPrint(a.toString());
  }

  GridView _appsGrid(List<ApplicationMeta> apps) {
    apps.sort((a, b) => a.upiApplication
        .getAppName()
        .toLowerCase()
        .compareTo(b.upiApplication.getAppName().toLowerCase()));
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      // childAspectRatio: 1.6,
      physics: const NeverScrollableScrollPhysics(),
      children: apps
          .map(
            (it) => Material(
              key: ObjectKey(it.upiApplication),
              // color: Colors.grey[200],
              child: InkWell(
                onTap: Platform.isAndroid ? () async => await _onTap(it) : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    it.iconImage(48),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      alignment: Alignment.center,
                      child: Text(
                        it.upiApplication.getAppName(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kIconColour,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'To $name',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: kContainerColour,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '$upi',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: kContainerColour,
                                  fontSize: 15.0,
                                  // fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, right: 4, left: 4, bottom: 8),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            controller: controllerAmount,
                            style: const TextStyle(
                              color: kContainerColour,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: 20,
                            ),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              hintText: '₹',
                              hintStyle: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 17,
                                color: kHintColour,
                              ),
                              labelText: 'Amount',
                              labelStyle: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 17,
                                color: kContainerColour,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                            ),
                            cursorColor: Colors.black,
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     const Text(
                        //       '₹',
                        //       style: TextStyle(
                        //         color: kContainerColour,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 40,
                        //       ),
                        //     ),
                        //     Container(
                        //       margin: const EdgeInsets.fromLTRB(
                        //           5.0, 10.0, 10.0, 10.0),
                        //       width: MediaQuery.of(context).size.width * 0.8,
                        //       child: TextFormField(
                        //         keyboardType: TextInputType.phone,
                        //         style: const TextStyle(
                        //           // fontFamily: 'Raleway',
                        //           color: Colors.black,
                        //           // fontWeight: FontWeight.bold,
                        //           fontSize: 20,
                        //         ),
                        //         decoration: const InputDecoration(
                        //           fillColor: kContainerColour,
                        //           filled: true,
                        //           border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.all(
                        //               Radius.circular(10),
                        //             ),
                        //           ),
                        //           hintText: "Enter Amount",
                        //           contentPadding: EdgeInsets.fromLTRB(
                        //               10.0, 10.0, 10.0, 10.0),
                        //           hintStyle: TextStyle(
                        //             fontFamily: 'Raleway',
                        //             fontSize: 20,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //         cursorColor: Colors.black,
                        //         onTap: () {
                        //           amountHint = '';
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, right: 4, left: 4, bottom: 8),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            controller: controllerMessage,
                            style: const TextStyle(
                              color: kContainerColour,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: 20,
                            ),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              labelText: 'Message',
                              labelStyle: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 17,
                                color: kContainerColour,
                              ),
                              hintText: "(Optional)",
                              hintStyle: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 17,
                                color: kHintColour,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                            ),
                            cursorColor: Colors.black,
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            onChanged: (value) {
                              name = value.toString();
                              // debugPrint(value.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 32, bottom: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Pay Using',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                if (_apps != null) _appsGrid(_apps!.map((e) => e).toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
