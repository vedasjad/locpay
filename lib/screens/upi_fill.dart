import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locpay/constants.dart';
import 'package:locpay/services/upi_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upi_pay/upi_pay.dart';
import 'dart:io';
import 'dart:math';

class UpiFill extends StatefulWidget {
  const UpiFill({Key? key}) : super(key: key);
  @override
  State<UpiFill> createState() => _UpiFillState();
}

class _UpiFillState extends State<UpiFill> {
  String? _upiAddrError;
  getList() async {}

  String upi = '';
  String name = '';
  String phnumber = '';
  TextEditingController controllerUpi = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPhnumber = TextEditingController();
  TextEditingController controllerAmount = TextEditingController();

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
    controllerUpi.dispose();
    super.dispose();
  }

  Future<void> _onTap(ApplicationMeta app) async {
    final err = _validateUpiAddress(upi);
    if (err != null) {
      setState(() {
        _upiAddrError = err;
      });
      return;
    }
    setState(() {
      _upiAddrError = null;
    });

    final transactionRef = Random.secure().nextInt(1 << 32).toString();
    debugPrint("Starting transaction with id $transactionRef");

    final a = await UpiPay.initiateTransaction(
      amount: controllerAmount.text,
      app: app.upiApplication,
      receiverName: controllerName.text,
      receiverUpiAddress: controllerUpi.text,
      transactionRef: transactionRef,
      transactionNote: 'UPI Payment',
    );

    debugPrint(a.toString());
  }

  // Widget _androidApps() {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 32, bottom: 32),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Container(
  //           margin: const EdgeInsets.only(bottom: 12),
  //           child: Text(
  //             'Pay Using',
  //             style: Theme.of(context).textTheme.bodyText1,
  //           ),
  //         ),
  //         if (_apps != null) _appsGrid(_apps!.map((e) => e).toList()),
  //       ],
  //     ),
  //   );
  // }

  Widget _vpaError() {
    return Container(
      margin: const EdgeInsets.only(top: 4, left: 12),
      child: Text(
        _upiAddrError!,
        style: const TextStyle(color: Colors.red),
      ),
    );
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

  // Future createUser(Beneficiary beneficiary) async {
  //   final docUser = FirebaseFirestore.instance.collection('users').doc();
  //   beneficiary.id = docUser.id;
  //   final json = beneficiary.toJson();
  //   await docUser.set(json);
  // }

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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cabin),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: kBackgroundColour,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Beneficiary UPI',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            color: kContainerColour,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Money will go directly into Beneficiary\'s Bank Account',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
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
                                        controller: controllerUpi,
                                        style: const TextStyle(
                                          color: kContainerColour,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0,
                                          fontSize: 18,
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
                                          labelText: 'To',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontSize: 20,
                                            color: kContainerColour,
                                          ),
                                          hintText: "walterwhite@upi",
                                          hintStyle: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontSize: 17,
                                            color: kHintColour,
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 15.0, 20.0, 5.0),
                                        ),
                                        cursorColor: Colors.black,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .singleLineFormatter,
                                        ],
                                        onChanged: (value) {
                                          upi = value.toString();
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value.toString().isEmpty) {
                                            return 'UPI VPA is required.';
                                          }
                                          if (value
                                                  .toString()
                                                  .split('@')
                                                  .length !=
                                              2) {
                                            return 'Invalid UPI VPA';
                                          }
                                          return null;
                                        }),
                                  ),
                                  if (_upiAddrError != null) _vpaError(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, right: 4, left: 4, bottom: 8),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      controller: controllerName,
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
                                        labelText: 'Name',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 17,
                                          color: kContainerColour,
                                        ),
                                        hintText: "Walter White",
                                        hintStyle: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 17,
                                          color: kHintColour,
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 5.0),
                                      ),
                                      cursorColor: Colors.black,
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .singleLineFormatter,
                                      ],
                                      onChanged: (value) {
                                        name = value.toString();
                                        // debugPrint(value.toString());
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, right: 4, left: 4, bottom: 8),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.phone,
                                      controller: controllerPhnumber,
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
                                        labelText: 'Phone Number',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 17,
                                          color: kContainerColour,
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 5.0),
                                      ),
                                      cursorColor: Colors.black,
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .singleLineFormatter,
                                      ],
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        value != null && value.length < 10
                                            ? 'Enter valid phone number'
                                            : null;
                                        return null;
                                      },
                                      onChanged: (value) {
                                        phnumber = value.toString();
                                        // debugPrint(value.toString());
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, right: 4, left: 4, bottom: 8),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
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
                                        labelText: 'Amount',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 17,
                                          color: kContainerColour,
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 5.0),
                                      ),
                                      cursorColor: Colors.black,
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .singleLineFormatter,
                                      ],
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
                          if (_apps != null)
                            _appsGrid(_apps!.map((e) => e).toList()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: TextButton(
      //   style: ButtonStyle(
      //     backgroundColor:
      //         MaterialStateColor.resolveWith((states) => kIconColour),
      //     fixedSize: MaterialStateProperty.resolveWith(
      //       (states) => Size(MediaQuery.of(context).size.width, 10.0),
      //     ),
      //   ),
      //   child: const Text(
      //     'PROCEED',
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //       fontFamily: 'Raleway',
      //       color: kContainerColour,
      //       fontSize: 5.0,
      //       fontWeight: FontWeight.w900,
      //     ),
      //   ),
      //   onPressed: () async {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (_) => const Screen()));
      //     await _onTap(_apps![0]);
      //
      //     setState(
      //       () {
      //         final user = Beneficiary(
      //           id: 'xyz',
      //           name: name,
      //           upi: upi,
      //           phnumber: int.tryParse(phnumber) ?? 0,
      //         );
      //         createUser(user);
      // doUpiTransaction(appMetaList[]);
      //         // debugPrint(controllerUpi.text);
      //         // debugPrint(controllerName.text);
      //         // debugPrint(controllerPhnumber.text);
      //       },
      //     );
      //   },
      // ),
    );
  }
}

String? _validateUpiAddress(String value) {
  if (value.isEmpty) {
    return 'UPI VPA is required.';
  }
  if (value.split('@').length != 2) {
    return 'Invalid UPI VPA';
  }
  return null;
}
