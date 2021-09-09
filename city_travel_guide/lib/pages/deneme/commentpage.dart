import 'package:flutter/material.dart';
import 'package:city_travel_guide/data/database_helper.dart';
import 'package:city_travel_guide/pages/deneme/comment.dart';
import 'package:city_travel_guide/pages/deneme/addcomment.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  DbHelper _dbHelper;

  @override
  void initState() {
    _dbHelper = DbHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddCommentPage(
                      comments: Comments(),
                    )),
          );
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: _dbHelper.getComments(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Comments>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            if (snapshot.data.isEmpty)
              return Text("Your comment page is empty");
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Comments comments = snapshot.data[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCommentPage(
                            comments: comments,
                          ),
                        ),
                      );
                    },
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onDismissed: (direction) async {
                        await _dbHelper.removeComment(comments.id);

                        setState(() {});

                        // ignore: deprecated_member_use
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content:
                              Text("${comments.userName} has been deleted"),
                          action: SnackBarAction(
                            label: "UNDO",
                            onPressed: () async {
                              await _dbHelper.insertComment(comments);

                              setState(() {});
                            },
                          ),
                        ));
                      },
                      child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                              comments.avatar == null
                                  ? "images/person.jpg"
                                  : comments.avatar,
                            ),
                            child: Text(
                              comments.userName[0].toUpperCase(),
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(comments.userName),
                          subtitle: Text(comments.userComment)),
                    ),
                  );
                });
          }),
    );
  }
}
