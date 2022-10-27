import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

//#212832
//#3A3D46
//#00ADB4
//#EEEEEE

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBackgroundColour,
      body: SafeArea(
        child: SlidingUpPanel(
          defaultPanelState: PanelState.OPEN,
          minHeight: screenHeight * 0.65,
          maxHeight: screenHeight * 0.88,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 18.0,
              color: Colors.black45,
            )
          ],
          color: kBlueColour,
          margin: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          body: const Text(
            'Hey, Asjad!',
            style: TextStyle(
              fontSize: 45.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          panel: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: TextField(
                  style: const TextStyle(
                    color: kTextColour,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    fillColor: kContainerColour,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        width: 1.5,
                        color: kContainerColour,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.cyan,
                        width: 1.5,
                      ),
                    ),
                    hintText: "Pay friends and merchants",
                    hintStyle: const TextStyle(
                      color: kHintColour,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.cyan,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.cyan,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kContainerColour,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Transfer Money',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.qr_code_scanner,
                                    size: 40.0,
                                    color: Colors.cyan,
                                  ),
                                ),
                                Text(
                                  '\nScan\n& Pay\n\n',
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  Icons.account_box_outlined,
                                  size: 40.0,
                                  color: Colors.cyan,
                                ),
                                Text(
                                  '\nTo Phone\nNumber',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            Column(
                              children: const [
                                Icon(
                                  Icons.account_balance,
                                  size: 40.0,
                                  color: Colors.cyan,
                                ),
                                Text(
                                  '\nTo\nAccount\n\n',
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  Icons.account_balance_wallet,
                                  size: 40.0,
                                  color: Colors.cyan,
                                ),
                                Text(
                                  '\nCheck\nBalance',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            Column(
                              children: const [
                                Icon(
                                  Icons.archive_rounded,
                                  size: 40.0,
                                  color: Colors.cyan,
                                ),
                                Text(
                                  '\nTo Self\nAccount\n\n',
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  Icons.account_balance_wallet,
                                  size: 40.0,
                                  color: Colors.cyan,
                                ),
                                Text(
                                  '\nCheck\nBalance',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            Column(
                              children: const [
                                Icon(
                                  Icons.account_balance_wallet,
                                  size: 40.0,
                                  color: Colors.cyan,
                                ),
                                Text(
                                  '\nCheck\nBalance\n\n',
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  Icons.account_balance_wallet,
                                  size: 40.0,
                                  color: Colors.cyan,
                                ),
                                Text(
                                  '\nCheck\nBalance',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: kContainerColour,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Send Money',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          //textAlign: TextAlign.start,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const <Widget>[
                            Icon(
                              Icons.account_circle_rounded,
                              size: 40.0,
                            ),
                            Icon(
                              Icons.account_balance,
                              size: 40.0,
                            ),
                            Icon(
                              Icons.archive_rounded,
                              size: 40.0,
                            ),
                            Icon(
                              Icons.account_balance_wallet,
                              size: 40.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
