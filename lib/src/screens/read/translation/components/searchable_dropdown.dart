// Searchable Dropdown widget
import 'package:flutter/material.dart';

class SearchableDropdown extends StatefulWidget {
  final Widget hint;
  final String? value;
  final Function(String?) onChanged;
  final List<DropdownMenuItem<String>> items;

  const SearchableDropdown({
    super.key,
    required this.hint,
    this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  final String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: widget.hint,
      value: widget.value,
      onChanged: (String? value) => widget.onChanged(value),
      items: widget.items,
      icon: const Icon(Icons.arrow_drop_down),
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
