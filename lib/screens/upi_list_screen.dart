import 'package:flutter/material.dart';
import 'package:locpay/screens/upi_fill.dart';
import 'package:locpay/services/upi_list.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:locpay/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Actions { share, delete, archive }

class UpiListScreen extends StatefulWidget {
  const UpiListScreen({Key? key}) : super(key: key);

  @override
  State<UpiListScreen> createState() => _UpiListScreenState();
}

class _UpiListScreenState extends State<UpiListScreen> {
  // List<Beneficiary> users = allUsers;
  // Stream<List<Beneficiary>> readUsers() => FirebaseFirestore.instance
  //     .collection('users')
  //     .snapshots()
  //     .map((snapshot) => snapshot.docs
  //         .map((doc) => Beneficiary.fromJson(doc.data()))
  //         .toList());
  // void _onDismissed(int index, Actions action) {
  //   final user = users[index];
  //   setState(() {
  //     users.removeAt(index);
  //   });

  //   switch (action) {
  //     case Actions.delete:
  //       _showSnackBar(
  //         context,
  //         '${user.name} is deleted',
  //         Colors.red,
  //       );
  //       break;
  //     case Actions.archive:
  //       _showSnackBar(
  //         context,
  //         '${user.name} is archived',
  //         Colors.blue,
  //       );
  //       break;
  //     case Actions.share:
  //       _showSnackBar(
  //         context,
  //         '${user.name} is shared',
  //         Colors.green,
  //       );
  //       break;
  //   }
  // }

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Widget buildUserListTitle(Beneficiary beneficiary) =>
  //     Builder(builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 0.0),
  //         child: ListTile(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15.0),
  //           ),
  //           tileColor: kContainerColour,
  //           contentPadding: const EdgeInsets.all(16),
  //           leading: const Icon(
  //             Icons.account_circle,
  //             color: kBackgroundColour,
  //             size: 55.0,
  //           ),
  //           title: Text(
  //             beneficiary.name,
  //             style: const TextStyle(
  //               fontFamily: 'Raleway',
  //               fontSize: 20.0,
  //               fontWeight: FontWeight.w900,
  //             ),
  //           ),
  //           subtitle: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 beneficiary.upi,
  //                 style: const TextStyle(
  //                   fontSize: 15.0,
  //                 ),
  //               ),
  //               Text(
  //                 beneficiary.phnumber.toString(),
  //                 style: const TextStyle(
  //                   fontSize: 15.0,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           onTap: () {
  //             final slidable = Slidable.of(context)!;
  //             final isClosed =
  //                 slidable.actionPaneType.value == ActionPaneType.none;
  //             if (isClosed) {
  //               slidable.openStartActionPane();
  //             } else {
  //               slidable.close();
  //             }
  //           },
  //         ),
  //       );
  //     });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kContainerColour,
      appBar: AppBar(
        backgroundColor: kIconColour,
        title: const Text(
          'UPI Contacts',
          style: TextStyle(
            fontFamily: 'Raleway',
            color: kContainerColour,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.cabin))],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SlidableAutoCloseBehavior(
              closeWhenOpened: true,
              child: ListView(
                  // children: beneficiaries.map(buildUserListTitle).toList(),
                  ),
              // child: ListView.builder(
              //   itemCount: beneficiaries.length,
              //   itemBuilder: (context, index) {
              //     final beneficiary = beneficiaries[index];
              //     return Slidable(
              //       key: UniqueKey(),
              //       startActionPane: ActionPane(
              //         motion: const StretchMotion(),
              //         children: [
              //           SlidableAction(
              //             borderRadius: BorderRadius.circular(15),
              //             backgroundColor: Colors.green,
              //             icon: Icons.share,
              //             label: 'Share',
              //             onPressed: (context) =>
              //                 _onDismissed(index, Actions.share),
              //           ),
              //           SlidableAction(
              //             borderRadius: BorderRadius.circular(15),
              //             backgroundColor: kBackgroundColour,
              //             icon: Icons.archive,
              //             label: 'Archive',
              //             onPressed: (context) =>
              //                 _onDismissed(index, Actions.archive),
              //           ),
              //         ],
              //       ),
              //       endActionPane: ActionPane(
              //         motion: const BehindMotion(),
              //         dismissible: DismissiblePane(
              //           onDismissed: () {
              //             _onDismissed(index, Actions.delete);
              //           },
              //         ),
              //         children: [
              //           SlidableAction(
              //             borderRadius: BorderRadius.circular(15),
              //             backgroundColor: Colors.red,
              //             icon: Icons.delete,
              //             label: 'Delete',
              //             onPressed: (context) =>
              //                 _onDismissed(index, Actions.delete),
              //           ),
              //         ],
              //       ),
              //       child: buildUserListTitle(beneficiary),
              //     );
              //   },
              // ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        child: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const UpiFill()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
