import 'package:flutter/material.dart';

class AgeDropDown extends StatefulWidget {
  final Function(String) onChanged;
  const AgeDropDown({super.key, required this.onChanged});

  @override
  State<AgeDropDown> createState() => _AgeDropDownState();
}

class _AgeDropDownState extends State<AgeDropDown> {
  final List<String> _dropDownItems = ["0", "1", "2", "3", "4", "5"];
  String _selectedItem = "0";
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Colors.red[50],
      value: _selectedItem,
      items: _dropDownItems.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      //onChanged: (value) {},
      onChanged: (String? value) {
        setState(() {
          _selectedItem = value!;
          widget.onChanged(_selectedItem);
        });
      },
    );
  }
}
