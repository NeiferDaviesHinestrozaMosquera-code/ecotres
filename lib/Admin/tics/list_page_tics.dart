import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'detail_page_tics.dart';
import 'form_page_tics.dart';

class CustomeText extends StatelessWidget {
  const CustomeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'EcoTics',
      style: TextStyle(fontSize: 18.0),
    );
  }
}

class CardAction {
  static const String Edit = 'Editar';
  static const String Delete = 'Borrar';

  static const List<String> choice = <String>[Edit, Delete];
}

class ListNoteTics extends StatefulWidget {
  @override
  _ListNoteTicsState createState() => _ListNoteTicsState();
}

class _ListNoteTicsState extends State<ListNoteTics> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Icon customIcon = Icon(Icons.search);
  Widget space = CustomeText();
  bool check = true;
  bool sort = false;
  String? name;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: space),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    check ? Icons.search : Icons.clear,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      if (check) {
                        check = false;
                        space = Container(
                            child: TextField(
                          autofocus: true,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: "Escribe tu EcoTexto...",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              name = val;
                              //print(name);
                            });
                          },
                        ));
                      } else {
                        check = true;
                        space = CustomeText();
                      }
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.sort_by_alpha),
                  color: Colors.black,
                  onPressed: () {
                    if (sort == false) {
                      setState(() {
                        sort = true;
                      });
                    } else {
                      setState(() {
                        sort = false;
                      });
                    }
                  },
                )
              ],
            ),
          ],
        ),
        elevation: 5.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyCustomForm()),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: (name != "" && name != null)
            ? _db
                .collection('EcoTics')
                .orderBy('titulo', descending: sort)
                .where('titulo', isGreaterThanOrEqualTo: name)
                .where('titulo', isLessThan: name! + 'z')
                .snapshots()
            : _db
                .collection("EcoTics")
                .orderBy('titulo', descending: sort)
                .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) return CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                //print(snapshot.data.docs.elementAt(index).id);
                //var row = index + 1;
                String title = snapshot.data!.docs.elementAt(index)['titulo'];
                String subtitle =
                    snapshot.data!.docs.elementAt(index)['descripcion'];
                String? imageUrl =
                    snapshot.data!.docs.elementAt(index)['image'];
                String id = snapshot.data!.docs.elementAt(index).id;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: imageUrl != null
                                ? Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    width: width / 0.5,
                                    height: 200.0,
                                  )
                                : Image.network(
                                    "https://gift-cards.ad.iq/images/empty-image.jpg",
                                    fit: BoxFit.cover,
                                    width: width / 0.5,
                                    height: 200.0,
                                  ),
                            onTap: () {
                              // Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoteDetails(
                                          title: title,
                                          subtitle: subtitle,
                                          imgUrl: imageUrl,
                                          id: id,
                                        )),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: Colors.grey,
                                  child: Image.network(
                                      "https://cdn.goconqr.com/uploads/media/image/9997753/desktop_5f8b9feb-c62a-4bb6-8069-2a1a219d0e7b.png"),
                                ),
                              ),
                              Container(
                                width: width / 1.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(subtitle),
                                  ],
                                ),
                              ),
                              PopupMenuButton(
                                  color: Colors.black,
                                  itemBuilder: (BuildContext context) {
                                    return CardAction.choice
                                        .map((String choice) {
                                      if (choice == CardAction.Edit) {
                                        return PopupMenuItem<String>(
                                          child: Column(
                                            children: [
                                              TextButton.icon(
                                                  label: Text(choice),
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyCustomForm(
                                                                title: title,
                                                                subtitle:
                                                                    subtitle,
                                                                imgUrl:
                                                                    imageUrl,
                                                                id: id,
                                                              )),
                                                    );
                                                  })
                                            ],
                                          ),
                                        );
                                      } else {
                                        return PopupMenuItem<String>(
                                          child: Column(
                                            children: [
                                              TextButton.icon(
                                                  label: Text(choice),
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    FirebaseFirestore.instance
                                                        .collection('EcoTics')
                                                        .doc(id)
                                                        .delete();
                                                    // await _db.runTransaction(
                                                    //     (Transaction myTransaction) async {
                                                    //   print(myTransaction);
                                                    //   myTransaction.delete(snapshot
                                                    //       .data.docs[index].reference);
                                                    // });
                                                  })
                                            ],
                                          ),
                                        );
                                      }
                                    }).toList();
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
