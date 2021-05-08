import 'package:flutter/material.dart';

class Toggle<T> extends StatefulWidget {
  final List<T> items;
  final int? initialIndex;
  final void Function(int, T) onChange;
  final Widget Function(T) builder;
  final Widget Function(T)? disableBuilder;

  Toggle(
      {Key? key,
      required this.items,
      this.initialIndex,
      required this.onChange,
      required this.builder,
      this.disableBuilder})
      : assert(initialIndex == null || initialIndex < items.length),
        super(key: key);

  @override
  _ToggleState<T> createState() => _ToggleState<T>();
}

class _ToggleState<T> extends State<Toggle<T>> {
  late Map<T, bool> _selections;

  @override
  void initState() {
    _selections = Map.fromIterable(widget.items,
        key: (item) => item,
        value: (item) => widget.initialIndex != null
            ? widget.items[widget.initialIndex!] == item
            : false);
    List.generate(
        widget.items.length,
        (index) =>
            widget.initialIndex != null ? widget.initialIndex == index : false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        children: _selections.entries
            .map((entry) => entry.value
                ? widget.builder(entry.key)
                : widget.disableBuilder != null
                    ? widget.disableBuilder!(entry.key)
                    : widget.builder(entry.key))
            .toList(),
        isSelected: _selections.values.toList(),
        onPressed: (int index) {
          final key = _selections.keys.elementAt(index);
          setState(() {
            _selections.entries.forEach((entry) {
              setState(() {
                _selections[entry.key] = entry.key == key;
              });
            });
          });
          widget.onChange(index, widget.items[index]);
        },
        selectedColor: Theme.of(context).secondaryHeaderColor,
        disabledColor: Theme.of(context).disabledColor,
        borderRadius: BorderRadius.circular(40));
  }
}
