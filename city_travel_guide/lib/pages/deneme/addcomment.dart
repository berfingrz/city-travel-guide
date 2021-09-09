import 'package:flutter/material.dart';
import 'package:city_travel_guide/data/database_helper.dart';
import 'package:city_travel_guide/pages/deneme/comment.dart';

class AddCommentPage extends StatelessWidget {
  final Comments comments;

  const AddCommentPage({Key key, @required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(comments.id == null ? "Add New Comment" : comments.userName),
      ),
      body: SingleChildScrollView(
          child: CommentsForm(comments: comments, child: AddCommentsForm())),
    );
  }
}

class CommentsForm extends InheritedWidget {
  final Comments comments;

  CommentsForm({Key key, @required Widget child, @required this.comments})
      : super(key: key, child: child);

  static CommentsForm of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CommentsForm>();
  }

  @override
  bool updateShouldNotify(CommentsForm oldWidget) {
    return comments.id != oldWidget.comments.id;
  }
}

class AddCommentsForm extends StatefulWidget {
  @override
  _AddCommentsFormState createState() => _AddCommentsFormState();
}

class _AddCommentsFormState extends State<AddCommentsForm> {
  final _formKey = GlobalKey<FormState>();
  DbHelper _dbHelper;

  @override
  void initState() {
    _dbHelper = DbHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Comments comments = CommentsForm.of(context).comments;

    return Column(
      children: <Widget>[
        Stack(
          children: [
            Image.asset(
              comments.avatar == null ? "images/person.jpg" : comments.avatar,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
            Positioned(
                bottom: 8,
                right: 8,
                child: IconButton(
                  onPressed: getFile,
                  icon: Icon(Icons.camera_alt),
                  color: Colors.white,
                ))
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Username:"),
                    initialValue: comments.userName,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Username required";
                      }
                    },
                    onSaved: (value) {
                      comments.userName = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Comment"),
                    initialValue: comments.userComment,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Comment required";
                      }
                    },
                    onSaved: (value) {
                      comments.userComment = value;
                    },
                  ),
                ),
                RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("Submit"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        if (comments.id == null) {
                          await _dbHelper.insertComment(comments);
                        } else {
                          await _dbHelper.updateComment(comments);
                        }

                        var snackBar = Scaffold.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "${comments.userComment} has been saved")),
                        );

                        snackBar.closed.then((onValue) {
                          Navigator.pop(context);
                        });
                      }
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void getFile() async {
    Comments comments = CommentsForm.of(context).comments;
  }
}
