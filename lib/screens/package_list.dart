import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/review_widget.dart';

import '../global_methods.dart';
import 'add_packages.dart';

class PackageList extends StatefulWidget {
  const PackageList({Key? key}) : super(key: key);

  @override
  State<PackageList> createState() => _ProductState();
}

class _ProductState extends State<PackageList> {
  GlobalMethods _globalMethods = GlobalMethods();

  get width => null;

  Future<void> delete(BuildContext context, String id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text(
                "All information about this package will be deleted and cannot be undone! Do you want to continue?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await FirebaseFirestore.instance
                      .collection("packages")
                      .doc(id)
                      .delete();
                },
                child: const Text("Yes"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    bool _isLoading = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Package List "),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.white,
      bottomSheet: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadPackages(),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            height: 45,
            color: Colors.purple,
            child: const Text(
              'Add new package',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          // <2> Pass `Stream<QuerySnapshot>` to stream
          stream: FirebaseFirestore.instance.collection('packages').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 25),
                          child: Column(children: [
                            Card(
                              elevation: 10,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 250,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(snapshot
                                                .data!.docs[index]['image']),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                inactiveProduct(
                                                  productId: snapshot
                                                      .data!.docs[index]['id'],
                                                  image: snapshot.data!
                                                      .docs[index]['image'],
                                                  title: snapshot.data!
                                                      .docs[index]['title'],
                                                  description:
                                                      snapshot.data!.docs[index]
                                                          ['description'],
                                                  price: snapshot.data!
                                                      .docs[index]['price'],
                                                );
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  Icon(
                                                    Icons
                                                        .remove_moderator_outlined,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    " Inactive",
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    print("edit");
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                UploadPackages(
                                                                  image: snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      ['image'],
                                                                  id: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index]['id'],
                                                                  title: snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      ['title'],
                                                                  description: snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'description'],
                                                                  price: snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      ['price'],
                                                                )));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Icon(
                                                        Icons.edit,
                                                        color: Colors.blue,
                                                      ),
                                                      Text(
                                                        " Edit",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ],
                                        
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                print("edit");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                ReviewsWidget(
                                                                  productTitle: snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      ['title'],
                                                                )));
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                  ),
                                                  Text(
                                                    " View review",
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    height: 320,
                                    width: 180,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Title: ${snapshot.data!.docs[index]['title']}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple,
                                            ),
                                          ),
                                          Text(
                                            "Price : ${snapshot.data!.docs[index]['price']}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black45,
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.black,
                                          ),
                                          const Text(
                                            "Description",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                ['description'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }

  void inactiveProduct(
      {required productId,
      required image,
      required title,
      required price,
      required description}) async {
    try {
      await FirebaseFirestore.instance
          .collection('inactiveProducts')
          .doc(productId)
          .set({
        'title': title,
        'description': description,
        'price': price,
        'image': image,
        'id': productId,
        'createdAt': Timestamp.now()
      });
      await FirebaseFirestore.instance
          .collection("packages")
          .doc(productId)
          .delete();

      _globalMethods.showDialogues(context, "Product inactived successfully.");
    } catch (e) {
      print(e);
    }
  }
}
