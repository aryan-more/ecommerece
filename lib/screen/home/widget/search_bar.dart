import 'package:ecommerece/screen/home/home.dart';
import 'package:ecommerece/utils/theme.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    required this.theme,
    required this.query,
  }) : super(key: key);

  final AppTheme theme;
  final String? query;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController queryController;

  @override
  void initState() {
    queryController = TextEditingController(text: widget.query);
    super.initState();
  }

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  void onSubmit() {
    HomeScreen.navigate(context: context, query: queryController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(color: widget.theme.textColor.withAlpha(25), borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: TextField(
          controller: queryController,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              onSubmit();
            }
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: queryController.clear,
            ),
            hintText: 'Search Products',
          ),
        ),
      ),
    );
  }
}
