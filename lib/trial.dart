import 'package:flutter/material.dart';

void main() => runApp(DropDown());

int disId;

class DropDown extends StatefulWidget {
  final int givenID;
  DropDown({
    this.givenID,
  }) : super();

  final String title = "Dropdown list";

  @override
  DropDownState createState() => DropDownState();
}

class Diseases {
  int id;
  String name;
  Diseases(this.id, this.name);

  static List<Diseases> getDiseases() {
    return <Diseases>[
      Diseases(1, 'Malaria'),
      Diseases(2, 'Typhoid'),
      Diseases(3, 'Hepatitis'),
      Diseases(4, 'Jaundice'),
      Diseases(5, 'Diabetes mellitus'),
      Diseases(6, 'Diarrhoeal Diseases'),
      Diseases(7, 'Epilepsy'),
      Diseases(8, 'Cholera'),
      Diseases(9, 'Hypertension'),
      Diseases(10, 'Arthritis'),
      Diseases(11, 'Alzheimer'),
      Diseases(12, 'AIDS/HIV'),
      Diseases(13, 'Tuberculosis'),
    ];
  }
}

class DropDownState extends State<DropDown> {
  //
  List<Diseases> _diseases = Diseases.getDiseases();
  List<DropdownMenuItem<Diseases>> _dropdownMenuItems;
  Diseases _selectedDisease;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_diseases);
     _selectedDisease = _dropdownMenuItems[widget.givenID].value;
    super.initState();
    
  }

  List<DropdownMenuItem<Diseases>> buildDropdownMenuItems(List diseases) {
    List<DropdownMenuItem<Diseases>> items = List();
    for (Diseases disease in diseases) {
      items.add(
        DropdownMenuItem(
          value: disease,
          child: Text(disease.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Diseases selectedDisease) {
    setState(() {
      _selectedDisease = selectedDisease;

      disId = _selectedDisease.id;
      print(disId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      style: new TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      value: _selectedDisease,
      items: _dropdownMenuItems,
      onChanged: onChangeDropdownItem,
    );
  }
}
