import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testbed/TreeView2/utilities.dart';
class TreeViewNode<T>
{
  final String key;
  final String label;
  final Icon icon;
  final bool expanded;
  final List<TreeViewNode> children;
  final String description;

  TreeViewNode({
    @required this.key,
    @required this.label,
    this.icon,
    this.children: const[],
    this.expanded: false,
    this.description
  }):
    assert(key!=null),
    assert(label!=null);

  TreeViewNode copyWith({
    String key,
    String label,
    List<TreeViewNode> children,
    bool expanded,
    Icon icon,
    T data,
  }) =>
      TreeViewNode(
        key: key ?? this.key,
        label: label ?? this.label,
        icon: icon ?? this.icon,
        expanded: expanded ?? this.expanded,
        children: children ?? this.children,
        description:description??this.description,
      );
  factory TreeViewNode.fromMap(Map<String, dynamic> map) {
    String _key = map['key'];
    String _label = map['label'];
    Icon _icon;
    List<TreeViewNode> _children = [];
    if (_key == null) {
      _key = Utilities.generateRandom();
    }
    if (map['icon'] != null) {
      _icon = null;
    }
    if (map['children'] != null) {
      List<Map<String, dynamic>> _childrenMap = List.from(map['children']);
      _children = _childrenMap
          .map((Map<String, dynamic> child) => TreeViewNode.fromMap(child))
          .toList();
    }
    return TreeViewNode(
      key: '$_key',
      label: _label,
      icon: _icon,
      expanded: Utilities.truthful(map['expanded']),
      children: _children,
    );
  }
  bool get isParent => children.isNotEmpty;
  bool get hasIcon => icon != null && icon.icon != null;


}