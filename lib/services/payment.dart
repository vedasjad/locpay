import 'package:flutter/material.dart';
import 'package:upi_pay/upi_pay.dart';

Future doUpiTransaction(ApplicationMeta appMeta) async {
  final UpiTransactionResponse response = await UpiPay.initiateTransaction(
    app: appMeta.upiApplication,
    receiverUpiAddress: 'thenotsosociableguy@okhdfcbank',
    receiverName: 'Asjad',
    transactionRef: 'UPITXREF001',
    amount: '1.00',
  );
  debugPrint(response.status.toString());
}
