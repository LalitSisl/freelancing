import 'package:flutter/material.dart';
import 'package:freelancing/Utils/constant.dart';

class MultiChip extends StatefulWidget {
  late final List<String> reportList;
  late final Function(List<String>)? onSelectionChanged;
  late final Function(List<String>)? onMaxSelected;
  late final int? maxSelection;

  // ignore: prefer_const_constructors_in_immutables
  MultiChip(this.reportList,
      {this.onSelectionChanged, this.onMaxSelected, this.maxSelection});

  @override
  State<MultiChip> createState() => _MultiChipState();
}

class _MultiChipState extends State<MultiChip> {
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];

    // ignore: avoid_function_literals_in_foreach_calls
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selectedColor: ColorPalette.themeBlue,
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            if (selectedChoices.length == (widget.maxSelection ?? -1) &&
                !selectedChoices.contains(item)) {
              widget.onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
                widget.onSelectionChanged?.call(selectedChoices);
              });
            }
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

class MultiChiplocation extends StatefulWidget {
  late final List<String> location;
  late final Function(List<String>)? onSelectionChanged;
  late final Function(List<String>)? onMaxSelected;
  late final int? maxSelection;

  MultiChiplocation(this.location,
      {this.onSelectionChanged, this.onMaxSelected, this.maxSelection});

  @override
  State<MultiChiplocation> createState() => _MultiChiplocationState();
}

class _MultiChiplocationState extends State<MultiChiplocation> {
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];

    widget.location.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selectedColor: ColorPalette.themeBlue,
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            if (selectedChoices.length == (widget.maxSelection ?? -1) &&
                !selectedChoices.contains(item)) {
              widget.onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
                widget.onSelectionChanged?.call(selectedChoices);
              });
            }
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
