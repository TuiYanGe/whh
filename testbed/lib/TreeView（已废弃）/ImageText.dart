/*import 'package:flutter/material.dart';

// ignore: public_member_api_docs
class ImageText extends StatelessWidget{
  // ignore: public_member_api_docs
  final double padding;
  final double width;
  final String title;
  final Color textColor;
  final double textSize;
  final IconData icon;

  ImageText(this.icon, this.title, {this.width=320.0, this.padding=0, this.textColor=Colors.black, this.textSize=14});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: AlignmentDirectional.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(padding, 0, 10, 0), child: _buildImage()),
                _buildText(),
              ],
            ),
          ),
          Container(color: Colors.black, height: 0.5,),
        ],
      ),
    );
  }

  Widget _buildText(){
    return Expanded(child: Text(title, style: TextStyle(color: textColor, fontSize: textSize,),));
  }

  Widget _buildImage(){
    return Icon(icon,);
  }

}*/