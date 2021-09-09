import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final Widget child;
  final dynamic formKey;
  final dynamic sendButtonMethod;
  final dynamic commentController;
  final String userImage;
  final String labelText;
  final String errorText;
  final Widget sendWidget;
  final Color backgroundColor;
  final Color textColor;
  final bool withBorder;

  //Constructor
  CommentBox(
      {this.child,
      this.formKey,
      this.sendButtonMethod,
      this.commentController,
      this.userImage,
      this.labelText,
      this.errorText,
      this.sendWidget,
      this.backgroundColor,
      this.textColor,
      this.withBorder});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: child),
        Divider(
          height: 1,
        ),
        ListTile(
          tileColor: backgroundColor,
          leading: Container(
            height: 40.0,
            width: 40.0,
            decoration: new BoxDecoration(
                color: Colors.blue,
                borderRadius: new BorderRadius.all(Radius.circular(50))),
            child: CircleAvatar(
                radius: 50, backgroundImage: NetworkImage(userImage)),
          ),
          title: Form(
            key: formKey,
            child: TextFormField(
              maxLines: 4,
              minLines: 1,
              cursorColor: textColor,
              style: TextStyle(color: textColor),
              controller: commentController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: textColor),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: textColor)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: textColor)),
                labelText: labelText,
                focusColor: textColor,
                fillColor: textColor,
                labelStyle: TextStyle(color: textColor),
              ),
              validator: (value) => value.isEmpty ? errorText : null,
            ),
          ),
          // ignore: deprecated_member_use
          trailing: OutlinedButton(
            onPressed: sendButtonMethod,
            child: sendWidget,
          ),
        ),
      ],
    );
  }
}
