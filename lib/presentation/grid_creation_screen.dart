import 'package:flutter/material.dart';
import 'package:grid_view_demo/resources/color_manager.dart';
import 'package:grid_view_demo/resources/font_manager.dart';
import 'package:grid_view_demo/resources/string_manager.dart';
import '../resources/theme_manager.dart';
import '../resources/value_manager.dart';
import 'grid_view_screen.dart';

class GridCreationScreen extends StatefulWidget {
  final List<List<String>> gridData;

  GridCreationScreen({required this.gridData});

  @override
  _GridCreationScreenState createState() => _GridCreationScreenState();
}

class _GridCreationScreenState extends State<GridCreationScreen> {
  TextEditingController searchController = TextEditingController();
  String searchResult = '';
  late List<List<bool>> gridHighlight;

  void searchWord(String word) {
    bool found = false;
    int m = widget.gridData.length;
    int n = widget.gridData[0].length;
    List<List<bool>> highlightGrid =
    List.generate(m, (_) => List.filled(n, false));

    /// Search grid data - left to right (east)
    for (int i = 0; i < m; i++) {
      for (int j = 0; j <= n - word.length; j++) {
        if (widget.gridData[i].sublist(j, j + word.length).join('') == word) {
          for (int k = j; k < j + word.length; k++) {
            highlightGrid[i][k] = true;
          }
          found = true;
        }
      }
    }

    /// Search grid data - top to bottom (south)
    for (int i = 0; i <= m - word.length; i++) {
      for (int j = 0; j < n; j++) {
        List<String> columnValues = [];
        for (int k = i; k < i + word.length; k++) {
          columnValues.add(widget.gridData[k][j]);
        }
        if (columnValues.join('') == word) {
          for (int k = i; k < i + word.length; k++) {
            highlightGrid[k][j] = true;
          }
          found = true;
        }
      }
    }

    /// Search grid data - diagonal (south-east)
    for (int i = 0; i <= m - word.length; i++) {
      for (int j = 0; j <= n - word.length; j++) {
        List<String> diagonalValues = [];
        for (int k = 0; k < word.length; k++) {
          diagonalValues.add(widget.gridData[i + k][j + k]);
        }
        if (diagonalValues.join('') == word) {
          for (int k = 0; k < word.length; k++) {
            highlightGrid[i + k][j + k] = true;
          }
          found = true;
        }
      }
    }

    setState(() {
      searchResult = found ? AppStrings.found : AppStrings.notFound;
      gridHighlight = highlightGrid;
    });
  }

  bool wordMatchesAt(String word, int row, int col) {
    /// Check horizontally
    if (col + word.length <= widget.gridData[row].length) {
      String rowWord = widget.gridData[row].skip(col).take(word.length).join('');
      if (rowWord == word) return true;
    }

    /// Check vertically
    if (row + word.length <= widget.gridData.length) {
      String colWord = '';
      for (int i = 0; i < word.length; i++) {
        colWord += widget.gridData[row + i][col];
      }
      if (colWord == word) return true;
    }

    /// Check diagonally (top-left to bottom-right)
    if (row + word.length <= widget.gridData.length && col + word.length <= widget.gridData[row].length) {
      String diagWord = '';
      for (int i = 0; i < word.length; i++) {
        diagWord += widget.gridData[row + i][col + i];
      }
      if (diagWord == word) return true;
    }

    /// Check diagonally (top-right to bottom-left)
    if (row + word.length <= widget.gridData.length && col - word.length >= -1) {
      String diagWord = '';
      for (int i = 0; i < word.length; i++) {
        diagWord += widget.gridData[row + i][col - i];
      }
      if (diagWord == word) return true;
    }

    return false;
  }

  void highlightOccurrences(String word, int row, int col, List<List<bool>> highlightGrid) {
    for (int i = 0; i < word.length; i++) {
      highlightGrid[row][col] = true;
      row++;
      col++;
    }
  }

  @override
  void initState() {
    super.initState();
    gridHighlight = List.generate(
      widget.gridData.length,
          (_) => List.filled(widget.gridData[0].length, false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.teal,
        title: Text(AppStrings.startSearch,
            style: AppBarThemeConstant.appBarTextStyle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GridFormInput()));
            },
            color: ColorManager.greenDark,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: AppPadding.p20,
            bottom: AppPadding.p20,
            left: MediaQuery.of(context).size.width / 40,
            right: MediaQuery.of(context).size.width / 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: widget.gridData.length * widget.gridData[0].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.gridData[0].length,
                ),
                itemBuilder: (context, index) {
                  int row = (index / widget.gridData[0].length).floor();
                  int col = index % widget.gridData[0].length;
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.black),
                      color: gridHighlight[row][col]
                          ? ColorManager.primary
                          : ColorManager.white,
                    ),
                    child: Center(
                      child: Text(
                        widget.gridData[row][col],
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/20),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSize.s20),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: AppStrings.enterToSearch,
                labelStyle: TextStyle(color: ColorManager.black),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.blueGrey),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                filled: true,
                fillColor: ColorManager.blueFaint,
              ),
            ),
            const SizedBox(height: AppSize.s10),
            ElevatedButton(
              onPressed: () {
                String word = searchController.text.toUpperCase();
                searchWord(word);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.indigo, // Set button color
                padding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
              child: Text(AppStrings.check,
                  style: ButtonThemeConstant.buttonTextStyle),
            ),
            const SizedBox(height: AppSize.s10),
            Center(
              child: Text(
                searchResult,
                style: const TextStyle(fontSize: FontSize.s18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
