/*import 'package:flutter/material.dart';
import 'package:testbed/TreeView/TreeViewNode.dart';
import 'package:testbed/TreeView/TreeViewOrgan.dart';

///�?持搜索功�?
class SearchBar extends StatefulWidget {
  final List<TreeViewNode> list;
  final Function onResult;

  SearchBar(this.list, this.onResult);

  @override
  State<StatefulWidget> createState() {
    return SearchBarState();
  }
}

class SearchBarState extends State<SearchBar> {
  static bool _delOff = true; //�?否展示删除按�?
  static String _key = ""; //搜索的关�?�?

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 320.0,
        height: 50,
        color: Colors.grey,
        padding: EdgeInsets.all(5),
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(8),
              suffixIcon: GestureDetector(
                child: Offstage(
                  offstage: _delOff,
                  child: Icon(
                    Icons.highlight_off,
                    color: Colors.grey,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _key = "";
                    search(_key);
                  });
                },
              )),
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _key,
              selection: TextSelection.fromPosition(
                TextPosition(
                  offset: _key == null ? 0 : _key.length, //保证光标在最�?
                ),
              ),
            ),
          ),
          onChanged: search,
        ),
      ),
    );
  }

  ///关键字查�?
  void search(String value) {
    _key = value;
    List<TreeViewNode> tmp = List();
    if (value.isEmpty) { //如果关键字为空，代表全匹�?
      _delOff = true;
      widget.onResult(null);
    } else { //如果有关�?字，那么就去查找关键�?
      _delOff = false;
      for (TreeViewNode n in widget.list) {
        if (n.type == TreeViewNode.typeMember) {
          Member m = n.object as Member;
          if (m.name.toLowerCase().contains(value.toLowerCase())) { //匹配大小�?
            tmp.add(n);
          }
        }
      }
      widget.onResult(tmp);
    }
  }
}
*/