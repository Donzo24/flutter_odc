import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/entity/user_entity.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/message.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/getwidget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.database});
  AppDatabase database;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<User> users = [];
  int pageCourante = 10;
  PagingController<int, User> pagingController = PagingController(firstPageKey: 1);

  var _formKey = new GlobalKey<FormBuilderState>();

  List messages = [];
  double fontSize = 16;

  List<Utilisateur> utilisateurs = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    pagingController.addPageRequestListener((pageKey) {
      getUsersList(page: pageKey);
    });

    getUserList();

    // messages = [
    //   {
    //     'user': users[0],
    //     'message': "Message de la ",
    //     "heure": "16:21",
    //     "status": 3
    //   },
    //   {
    //     'user': users[2],
    //     'message': "Message de la ",
    //     "heure": "16:21",
    //     "status": 1
    //   },
    //   {
    //     'user': users[1],
    //     'message': "Message de la ",
    //     "heure": "16:21",
    //     "status": 3
    //   },
      
    // ];
  }

  void getUsersList({int page = 1}) {
    getUsers(page: page, pagingController: pagingController);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void getUserList() {
    widget.database.utilisateurDao.findAllUser().then((value) {
      setState(() {
        
        utilisateurs = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#181818"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
        onPressed: () {

          Get.bottomSheet(
            Container(
              height: MediaQuery.of(context).size.height/2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("assets/images/google.png"),
                      ),
                      title: Text("Ajout d'un utilisateur"),
                      subtitle: Text("Formulaire d'enregistrement"),
                    ),
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: FormBuilderTextField(
                              name: "nom",
                              decoration: InputDecoration(
                                labelText: "Nom de famille",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: FormBuilderTextField(
                              name: "prenom",
                              decoration: InputDecoration(
                                labelText: "Prenom",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: GFButton(
                              text: "Sauvergarder",
                              color: Colors.orange,
                              size: GFSize.LARGE,
                              fullWidthButton: true,
                              shape: GFButtonShape.pills,
                              onPressed: () {

                                if(_formKey.currentState!.saveAndValidate()) {

                                  widget.database.utilisateurDao.insertUtilisateur(
                                    Utilisateur(
                                      nom: _formKey.currentState!.value['nom'], 
                                      prenom:  _formKey.currentState!.value['prenom'],
                                      telephone: "66363"
                                    )
                                  );

                                  // Get.back();
                                  setState(() {
                                    
                                  });

                                  Get.snackbar("Success", "Succees");
                                }
                                
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                
              )
            )
          );
          
          // Get.defaultDialog(
          //   title: "HSJSJ",
          //   content: Container(
          //     child: Text("HSHJSJS"),
          //   )
          // );
        }
      ),
      appBar: AppBar(
        title: Text("Chat App"),
        actions: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(40))
              ),
              height: 45,
              width: 45,
              child: Center(
                child: Icon(Icons.add),
              ),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: HexColor("#181818"),
        leading: Padding(
          padding: EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/users/avatar-2.jpg"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: 180,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: List.generate(users.length, (index) {
            //       return createAvatar(user: users[index]);
            //     }),
            //   ),
            // ),
            // Container(
            //   height: 180,
            //   child: PagedListView(
            //     scrollDirection: Axis.horizontal,
            //     pagingController: pagingController,
            //     builderDelegate: PagedChildBuilderDelegate<User>(
            //       itemBuilder: (context, item, index) {
            //         return createAvatar(user: item);
            //       },
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Messages",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            FutureBuilder(
              future: widget.database.utilisateurDao.findAllUser(), 
              builder: (context, data) {

                if(data.connectionState == ConnectionState.active) {
                  return CircularProgressIndicator();
                }

                if(!data.hasError && data.hasData) {

                  List<Utilisateur> users = data.data as List<Utilisateur>;

                  return ListView(
                    shrinkWrap: true,
                    children: users.map((user) {
                        return createUserUi(user: user);
                    }).toList(),
                  );

                }

                return SizedBox();
              }
            ),

            ListView(
                    shrinkWrap: true,
                    children: utilisateurs.map((user) {
                        return createUserUi(user: user);
                    }).toList(),
              ),
            
            ListView(
                  shrinkWrap: true,
                  children: List.generate(messages.length, (index) {
                    return GestureDetector(
                      child: createMessage(message: messages[index]),
                      onTap: () {
                        //Changer de page dans l'application
                        Get.to(() => MessagePage(message: messages[index]));
                        //Chenger de page sans retour possible
                        //Get.off(() => MessagePage());
                        //Changer de page en supprimant toute les pages anterieurs eb cache
                        //Get.offAll(() => MessagePage());
                      },
                    );
                  }),
              )
            
          ],
        ),
      )
    );
  }

  Widget createMessage({required Map message}) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 5,
        left: 8,
        right: 8
      ),
      child: ListTile(
        textColor: Colors.white,
        title: Text(
          message['user']['nom'],
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text(
          message['message']
        ),
        leading: GestureDetector(
          onTap: () {
            setState(() {
              fontSize = fontSize+4;
            });
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(message['user']['image']),
          ),
        ),
        trailing: Column(
          children: [
            Text(
              message['heure']
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: HexColor("#301c70"),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Center(
                child: Text(
                  message['status'].toString()
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createUserUi({required Utilisateur user}) {

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/users/avatar-8.jpg"),
                ),
                true ? Positioned(
                  child: Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  )
                ):const SizedBox(),
                true ? Positioned(
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  )
                ):const SizedBox()
              ],
            ),
          ),
          Text(
            user.prenom,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
          )
        ],
      ),
    );
  }
}

  Widget createAvatar({required User user}) {

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.image),
                ),
                true ? Positioned(
                  child: Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  )
                ):const SizedBox(),
                true ? Positioned(
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  )
                ):const SizedBox()
              ],
            ),
          ),
          Text(
            user.firstName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
          )
        ],
      ),
    );
  }



class HexColor extends Color {
    static int _getColorFromHex(String hexColor) {
        hexColor = hexColor.toUpperCase().replaceAll("#", "");
        if (hexColor.length == 6) {
            hexColor = "FF" + hexColor;
        }
        return int.parse(hexColor, radix: 16);
    }

    HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}