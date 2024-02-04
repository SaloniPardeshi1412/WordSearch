import 'package:flutter/material.dart';
import 'package:grid_view_demo/resources/color_manager.dart';
import 'package:grid_view_demo/resources/font_manager.dart';
import 'package:grid_view_demo/resources/string_manager.dart';
import 'package:grid_view_demo/resources/theme_manager.dart';
import '../resources/value_manager.dart';
import 'grid_creation_screen.dart';

class GridCreation {
  List<List<String>> createGrid(int m, int n, List<List<String>> gridData) {
    List<List<String>> grid = List.generate(m, (_) => List.filled(n, ''));
    if (gridData.length == m && gridData.every((row) => row.length == n)) {
      grid = List.from(gridData);
    }
    return grid;
  }
}

class AlphabetInput extends StatefulWidget {
  final int m;
  final int n;

  AlphabetInput({required this.m, required this.n});

  @override
  _AlphabetInputState createState() => _AlphabetInputState();
}

class _AlphabetInputState extends State<AlphabetInput> {
  List<List<String>> grid = [];
  List<List<String>> gridData = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeGrid();
  }

  void initializeGrid() {
    grid = List.generate(widget.m, (_) => List.filled(widget.n, ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.teal,
        title: Text(AppStrings.alphaInput,
            style: AppBarThemeConstant.appBarTextStyle),
      ),
      backgroundColor: ColorManager.white, // Set background color
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Text(
                AppStrings.enterAlpha,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: FontSize.s18,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.black,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.m * widget.n,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.n,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 0.5,
              ),
              itemBuilder: (BuildContext context, int index) {
                int row = (index / widget.n).floor();
                int column = index % widget.n;
                return GridTile(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.lightGrey,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: TextField(
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 18,
                          color: ColorManager.black),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                        hintText: '',
                      ),
                      onChanged: (value) {
                        setState(() {
                          String uppercaseValue = value.toUpperCase();
                          grid[row][column] = uppercaseValue;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSize.s20),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 12,
                  right: MediaQuery.of(context).size.width / 12),
              child: ElevatedButton(
                onPressed: () {
                  GridCreation gridCreation = GridCreation();
                  gridData = gridCreation.createGrid(widget.m, widget.n, grid);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GridCreationScreen(gridData: gridData,),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 6,
                  backgroundColor: ColorManager.indigo,
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                ),
                child: Text(AppStrings.submit,
                    style: ButtonThemeConstant.buttonTextStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
