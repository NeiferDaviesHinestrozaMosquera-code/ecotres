import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'detail_page_eco.dart';
//import 'form_page_eco.dart';

class CustomeText extends StatelessWidget {
  const CustomeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return
    
    Text(
      'EcoNovedad',
      style: TextStyle(fontSize: 18.0),
    );
  }
}



class ListNoteEco extends StatefulWidget {
  @override
  _ListNoteEcoState createState() => _ListNoteEcoState();
}

class _ListNoteEcoState extends State<ListNoteEco> {
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
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: space),
            
          ],
        ),
        elevation: 5.0,
      ),
     
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: (name != "" && name != null)
            ? _db
                .collection('EcoNovedad')
                .orderBy('titulo', descending: sort)
                .where('titulo', isGreaterThanOrEqualTo: name)
                .where('titulo', isLessThan: name! + 'z')
                .snapshots()
            : _db
                .collection("EcoNovedad")
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
                                      "http://1.bp.blogspot.com/-UCvCq25AqOM/UiYY8m5AptI/AAAAAAABHnQ/_TDR5u1Egw4/s1600/Dia%2Bde%2Bla%2BPaz%2B63.jpg"),
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
