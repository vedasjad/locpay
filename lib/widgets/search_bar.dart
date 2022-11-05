import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:locpay/constants.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
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
                color: kIconColour,
                width: 1.5,
              ),
            ),
            hintText: "Pay friends and merchants",
            hintStyle: const TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: kHintColour,
            ),
            prefixIcon: const Icon(
              Icons.search,
              size: 30,
              color: kIconColour,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear,
                color: kIconColour,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
