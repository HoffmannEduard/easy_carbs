import 'package:flutter/material.dart';

/// Eingabefeld für den Namen einer Mahlzeit.
///
/// - Übergibt den getrimmten Text über [onCommit].
/// - Commit erfolgt bei "Done" oder beim Verlassen des Feldes.
class NameSection extends StatefulWidget {
  const NameSection({
    super.key,
    required this.controller,
    required this.onCommit,
  });

  final TextEditingController controller;
  final ValueChanged<String> onCommit;

  @override
  State<NameSection> createState() => _NameSectionState();
}

class _NameSectionState extends State<NameSection> {
  final _focusNode = FocusNode();
  String _beforeEdit = '';

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _commit();
      }
      setState(() {}); // UI neu bauen → Border an/aus
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _commit() {
    final trimmed = widget.controller.text.trim();

    if (trimmed.isEmpty) {
      widget.controller.text = _beforeEdit;
      return;
    }

    if (trimmed != _beforeEdit) {
      widget.controller.text = trimmed;
      widget.onCommit(trimmed);
    }
  }

  void _startEditing() {
    _beforeEdit = widget.controller.text;
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _focusNode.hasFocus;

    return Center(
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
        readOnly: !isEditing,
        onTap: _startEditing,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _focusNode.unfocus(),
        decoration: InputDecoration(
  isDense: true,
  isCollapsed: !isEditing,
  filled: false,
  hintText: null,
  border: isEditing ? const OutlineInputBorder() : InputBorder.none,
  enabledBorder:
      isEditing ? const OutlineInputBorder() : InputBorder.none,
  focusedBorder:
      isEditing ? const OutlineInputBorder() : InputBorder.none,
  contentPadding: isEditing
      ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
      : EdgeInsets.zero,
),
      ),
    );
  }
}