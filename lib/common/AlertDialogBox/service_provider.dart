import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class ServiceProvider extends StatefulWidget {
  const ServiceProvider({super.key});

  @override
  State<ServiceProvider> createState() => _ServiceProviderState();
}

class _ServiceProviderState extends State<ServiceProvider> {
  List<dynamic> category = [];
  String? categoryId;

  @override
  void initState() {
    super.initState();

    category.add({"id": 1, "name": "Personal Services"});
    category.add({"id": 2, "name": "Home Maintenance"});
    category.add({"id": 3, "name": "Education"});
    category.add({"id": 4, "name": "Household and Other Services"});
    category.add({"id": 5, "name": "Health and Wellness"});
    category.add({"id": 6, "name": "Professional Services"});
    category.add({"id": 7, "name": "Event and Entertainment"});
    category.add({"id": 8, "name": "Food and Beverage"});
    category.add({"id": 9, "name": "Transportation"});
    category.add({"id": 10, "name": "Travel and Hospitality"});
    category.add({"id": 11, "name": "Technology and Digital Services"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(
                color: Colors.black54,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FormHelper.dropDownWidget(
              context,
              "Select Service Category",
              categoryId,
              category,
              (onChangedVal) {
                categoryId = onChangedVal;
              },
              (onValidateVal) {
                if (onValidateVal == null) {
                  return 'Plesae Select Category';
                }
                return null;
              },
              //borderColor: Colors.white,
              //borderFocusColor: Colors.white,
              //borderRadius: 2,
              optionValue: "id",
              optionLabel: "name",
            ),
          )
        ],
      ),
    );
  }
}
