import 'package:flutter/material.dart';

class SingleSelectionDropdown extends StatefulWidget {
  final String? title;
  final String? selectedId;
  final bool mandatory;
  final BorderRadiusGeometry? borderRadius;
  final List<Map<String, dynamic>> items;
  final Function(String?) onSelectionChanged;

  const SingleSelectionDropdown({
    super.key,
    this.title,
    this.selectedId,
    this.mandatory = false,
    this.borderRadius,
    required this.items,
    required this.onSelectionChanged,
  });

  @override
  State<SingleSelectionDropdown> createState() =>
      _SingleSelectionDropdownState();
}

class _SingleSelectionDropdownState extends State<SingleSelectionDropdown> {
  String? _selectedItem;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.items.any((item) => item['id'] == widget.selectedId)
        ? widget.selectedId
        : null;
  }

  void _selectItem(String itemId) {
    setState(() {
      _selectedItem = itemId;
      _isExpanded = false;
    });
    widget.onSelectionChanged(_selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              children: [
                Text(
                  widget.title!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
                if (widget.mandatory)
                  const Text(" *", style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            constraints: const BoxConstraints(minHeight: 45),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: _isExpanded ? 10.0 : 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedItem == null
                            ? "Select ${widget.title ?? ''}"
                            : widget.items.firstWhere(
                                (item) => item['id'] == _selectedItem)['name'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _selectedItem == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                      Icon(
                        _isExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                if (_isExpanded)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: widget.items.map((item) {
                        final isSelected = item['id'] == _selectedItem;
                        return GestureDetector(
                          onTap: () => _selectItem(item['id']),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.grey[200] : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item['name'],
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
