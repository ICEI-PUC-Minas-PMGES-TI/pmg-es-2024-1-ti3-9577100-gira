import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

class SearchBarState extends State<SearchBarWidget> {

  final _inputController = TextEditingController();

  bool hasText = false;
  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.only(right: 2, left: 2, bottom: 0, top: 0),
          decoration: const BoxDecoration(
            color: GiraColors.fields,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _inputController,
                onChanged: _filterChange,
                onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Pesquise pelo nome...',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20,
                    fontFamily: GiraFonts.poorStory
                  ),
                  prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey[500]),
                ),
              )
            ]
          ),
        ),
      ],
    );
  }

  Future<void> _filterChange(String text) async{

    setState(() {
      hasText = text.isNotEmpty;
    });
    
    if ((_debounceTimer != null && _debounceTimer!.isActive) || !hasText) _debounceTimer!.cancel();
    
    
    final duration = hasText && widget.debounceDuration != null ? widget.debounceDuration! : Duration.zero;
    _debounceTimer = Timer(duration, () {

      widget.onFilterChange!.call(text);
    });
  }
}

class SearchBarWidget extends StatefulWidget {

  final void Function(String)? onFilterChange;
  final Duration? debounceDuration;

  SearchBarWidget({
    Key? key, 
    this.onFilterChange,
    this.debounceDuration,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => SearchBarState();
}
