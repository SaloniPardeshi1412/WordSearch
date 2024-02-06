import 'package:flutter/material.dart';
import 'package:grid_view_demo/resources/color_manager.dart';
import 'package:grid_view_demo/resources/font_manager.dart';
import 'package:grid_view_demo/resources/string_manager.dart';

import '../resources/theme_manager.dart';
import '../resources/value_manager.dart';
import 'alphabet_input_screen.dart';

class GridFormInput extends StatefulWidget {
  @override
  _GridFormInputState createState() => _GridFormInputState();
}

class _GridFormInputState extends State<GridFormInput> {
  int m = 0;
  int n = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.teal,
        title: Text(AppStrings.startHere,
            style: AppBarThemeConstant.appBarTextStyle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,
          right: MediaQuery.of(context).size.width/50,
          top: MediaQuery.of(context).size.width/50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSize.s50,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.transparent),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.blueGrey),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  prefixIcon: Icon(Icons.table_rows, color: ColorManager.blue),
                  hintText: AppStrings.enterRows,
                  hintStyle: TextStyle(color: ColorManager.black),
                  filled: true,
                  fillColor: ColorManager.blueFaint,
                ),
                onChanged: (value) {
                  setState(() {
                    m = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(height: AppSize.s10,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.transparent),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.blueGrey),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  prefixIcon:
                      Icon(Icons.view_column_sharp, color: ColorManager.blue),
                  hintText: AppStrings.enterCol,
                  hintStyle: TextStyle(color: ColorManager.black),
                  filled: true,
                  fillColor: ColorManager.blueFaint,
                ),
                onChanged: (value) {
                  setState(() {
                    n = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(
                height: AppSize.s30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (m > 0 && n > 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlphabetInput(m: m, n: n)),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: (m > 0 && n > 0)
                          ? ColorManager.indigo
                          : ColorManager.grey, // Conditional color setting
                    ),
                    child: Text(AppStrings.next,
                        style: ButtonThemeConstant.buttonTextStyle),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s50,),
              Text(
                AppStrings.instructions,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: FontSize.s20, color: ColorManager.primary),
              ),
              const SizedBox(height: AppSize.s15,),
              const Text(
                AppStrings.instructions1,
                style: TextStyle(fontSize: FontSize.s16, color: Colors.grey),
              ),
              const SizedBox(height: AppSize.s15,),
              const Text(
                AppStrings.instructions2,
                style: TextStyle(fontSize: FontSize.s16, color: Colors.grey),
              ),
              const SizedBox(height: AppSize.s15,),
              const Text(
                AppStrings.instructions3,
                style: TextStyle(fontSize: FontSize.s16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
