import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:agent_app/theme/colors.dart' show appColors;
import 'package:flutter/material.dart';

class MultiSelectionDropdown extends StatefulWidget {
  final String? title;
  final List<String>? selectedIds;
  final bool? mandatory;
  final List<Map<String, dynamic>> items;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectionDropdown({
    super.key,
    this.title,
    this.mandatory,
    this.selectedIds,
    required this.items,
    required this.onSelectionChanged,
  });

  @override
  State<MultiSelectionDropdown> createState() => _MultiSelectionDropdownState();
}

class _MultiSelectionDropdownState extends State<MultiSelectionDropdown> {
  late List<String> _selectedItems;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedIds ?? [];
  }

  void _toggleItem(String itemId) {
    setState(() {
      if (_selectedItems.contains(itemId)) {
        _selectedItems.remove(itemId);
      } else {
        _selectedItems.add(itemId);
      }
    });
    widget.onSelectionChanged(_selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Assign Multiple IDs::: $_selectedItems");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                Text(
                  widget.title!,
                  style: context.textTheme.bodyMedium,
                ),
                if (widget.mandatory ?? false)
                   Text(" *", style: context.textTheme.bodyMedium?.copyWith(color: appColors.error)),
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
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: _isExpanded ? 10.0 : 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _selectedItems.isEmpty
                              ? "Select ${widget.title ?? 'Items'}"
                              : widget.items
                              .where((item) =>
                              _selectedItems.contains(item['id']))
                              .map((item) => item['name'])
                              .join(', '),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: _selectedItems.isEmpty
                                ? Colors.grey
                                :  appColors.appBlack,
                          ),
                        ),
                      ),
                      Icon(
                        _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color:   appColors.appBlack,
                      ),
                    ],
                  ),
                ),
                if (_isExpanded)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        final isSelected = _selectedItems.contains(item['id']);

                        return GestureDetector(
                          onTap: () => _toggleItem(item['id']),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.grey[200] :   appColors.appWhite,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['name'],
                                  style: context.textTheme.bodyMedium
                                ),
                                Icon(
                                  isSelected
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: isSelected ?   appColors.secondary : Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 6);
                      },
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
