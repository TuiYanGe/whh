import 'package:testbed/TreeView2/tree_view_node.dart';
import 'package:get/get.dart';
import 'dart:convert' show jsonDecode, jsonEncode;
enum InsertMode {
  // ignore: public_member_api_docs
  prepend,
  append,
  insert,
}

class TreeViewController{
  // ignore: public_member_api_docs
  final List<TreeViewNode> children;
  // ignore: public_member_api_docs
  final String selectedKey;
  TreeViewController({
    this.children: const [],
    this.selectedKey
  });



  TreeViewController loadJSON({String json: '[]'}) {
    List jsonList = jsonDecode(json);
    List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(jsonList);
    return loadMap(list: list);
  }
  TreeViewController loadMap({List<Map<String, dynamic>> list: const []}) {
    List<TreeViewNode> treeData =
        list.map((Map<String, dynamic> item) => TreeViewNode.fromMap(item)).toList();
    return TreeViewController(
      children: treeData,
      selectedKey: this.selectedKey,
    );
  }
  TreeViewController copyWith({List<TreeViewNode> children, String selectedKey}) {
    return TreeViewController(
      children: children ?? this.children,
      selectedKey: selectedKey ?? this.selectedKey,
    );
  }

  
  //增
  TreeViewController withAddNode(
    String key,
    TreeViewNode newNode, {
    TreeViewNode parent,
    InsertMode mode: InsertMode.append,
    int index,
  }) {
    List<TreeViewNode> _data =
        addNode(key, newNode, parent: parent, mode: mode, index: index);
    return TreeViewController(
      children: _data,
      selectedKey: this.selectedKey,
    );
  }
//增加节点的操作
  List<TreeViewNode> addNode(
    String key,
    TreeViewNode newNode, {
    TreeViewNode parent,
    InsertMode mode: InsertMode.append,
    int index,
  }) {
    List<TreeViewNode> _children = parent == null ? this.children : parent.children;
    return _children.map((TreeViewNode child) {
      if (child.key == key) {
        List<TreeViewNode> _children = child.children.toList(growable: true);
        if (mode == InsertMode.prepend) {
          _children.insert(0, newNode);
        } else if (mode == InsertMode.insert) {
          _children.insert(index ?? _children.length, newNode);
        } else {
          _children.add(newNode);
        }
        return child.copyWith(children: _children);
      } else {
        return child.copyWith(
          children: addNode(
            key,
            newNode,
            parent: child,
            mode: mode,
            index: index,
          ),
        );
      }
    }).toList();
  }
  //修改/更新节点
    TreeViewController withUpdateNode(String key, TreeViewNode newNode, {TreeViewNode parent}) {
    List<TreeViewNode> _data = updateNode(key, newNode, parent: parent);
    return TreeViewController(
      children: _data,
      selectedKey: this.selectedKey,
    );
  }
  List<TreeViewNode> updateNode(String key, TreeViewNode newNode, {TreeViewNode parent}) {
    List<TreeViewNode> _children = parent == null ? this.children : parent.children;
    return _children.map((TreeViewNode child) {
      if (child.key == key) {
        return newNode;
      } else {
        if (child.isParent) {
          return child.copyWith(
            children: updateNode(
              key,
              newNode,
              parent: child,
            ),
          );
        }
        return child;
      }
    }).toList();
  }

  TreeViewController withToggleNode(String key, {TreeViewNode parent}) {
    List<TreeViewNode> _data = toggleNode(key, parent: parent);
    return TreeViewController(
      children: _data,
      selectedKey: this.selectedKey,
    );
  }
  List<TreeViewNode> toggleNode(String key, {TreeViewNode parent}) {
    TreeViewNode _node = getNode(key, parent: parent);
    return updateNode(key, _node.copyWith(expanded: !_node.expanded));
  }
  TreeViewController withDeleteNode(String key, {TreeViewNode parent}) {
    List<TreeViewNode> _data = deleteNode(key, parent: parent);
    return TreeViewController(
      children: _data,
      selectedKey: this.selectedKey,
    );
  }
    List<TreeViewNode> deleteNode(String key, {TreeViewNode parent}) {
    List<TreeViewNode> _children = parent == null ? this.children : parent.children;
    List<TreeViewNode> _filteredChildren = [];
    Iterator iter = _children.iterator;
    while (iter.moveNext()) {
      TreeViewNode child = iter.current;
      if (child.key != key) {
        if (child.isParent) {
          _filteredChildren.add(child.copyWith(
            children: deleteNode(key, parent: child),
          ));
        } else {
          _filteredChildren.add(child);
        }
      }
    }
    return _filteredChildren;
  }
  //检索节点，以key为线索
  TreeViewNode getNode(String key, {TreeViewNode parent}) {
    TreeViewNode _found;
    List<TreeViewNode> _children = parent == null ? this.children : parent.children;
    Iterator iter = _children.iterator;
    while (iter.moveNext()) {
      TreeViewNode child = iter.current;
      if (child.key == key) {
        _found = child;
        break;
      } else {
        if (child.isParent) {
          _found = this.getNode(key, parent: child);
          if (_found != null) {
            break;
          }
        }
      }
    }
    return _found;
  }
  ///找父节点
  TreeViewNode getParent(String key, {TreeViewNode parent}) {
    TreeViewNode _found;
    List<TreeViewNode> _children = parent == null ? this.children : parent.children;
    Iterator iter = _children.iterator;
    while (iter.moveNext()) {
      TreeViewNode child = iter.current;
      if (child.key == key) {
        _found = parent ?? child;
        break;
      } else {
        if (child.isParent) {
          _found = this.getParent(key, parent: child);
          if (_found != null) {
            break;
          }
        }
      }
    }
    return _found;
  }
  ///  /// visible without the need to manually expand each node.
  List<TreeViewNode> expandToNode(String key) {
    List<String> _ancestors = [];
    String _currentKey = key;

    _ancestors.add(_currentKey);

    TreeViewNode _parent = this.getParent(_currentKey);
    while (_parent.key != _currentKey) {
      _currentKey = _parent.key;
      _ancestors.add(_currentKey);
      _parent = this.getParent(_currentKey);
    }
    TreeViewController _this = this;
    _ancestors.forEach((String k) {
      TreeViewNode _node = _this.getNode(k);
      TreeViewNode _updated = _node.copyWith(expanded: true);
      _this = _this.withUpdateNode(k, _updated);
    });
    return _this.children;
  }

  /// Collapses a node and all of the node's ancestors without the need to
  /// manually collapse each node.
  List<TreeViewNode> collapseToNode(String key) {
    List<String> _ancestors = [];
    String _currentKey = key;

    _ancestors.add(_currentKey);

    TreeViewNode _parent = this.getParent(_currentKey);
    while (_parent.key != _currentKey) {
      _currentKey = _parent.key;
      _ancestors.add(_currentKey);
      _parent = this.getParent(_currentKey);
    }
    TreeViewController _this = this;
    _ancestors.forEach((String k) {
      TreeViewNode _node = _this.getNode(k);
      TreeViewNode _updated = _node.copyWith(expanded: false);
      _this = _this.withUpdateNode(k, _updated);
    });
    return _this.children;
  }
}
