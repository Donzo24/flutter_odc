import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _formKey = GlobalKey<FormBuilderState>();

  TextEditingController _emailEmail = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void login({required Map data}) async {

    var dioClient = new dio.Dio();

    // ProgressDialog dialog = ProgressDialog(context: context);

    // dialog.show(
    //   max: 100,
    //   msg: "Patienter..."
    // );

    try {
      dio.Response response = await dioClient.post(
        "https://reqres.in/api/login",
        data: data
      );

      // dialog.close();

      // print(response.statusCode);
      // Get.off(() => HomePage());
    } catch (e) {
      // print(e);
      Get.snackbar(
        "Erreur", 
        "Email ou mot de passe invalide",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        icon: Icon(Icons.error)
      );

      // dialog.close();
    }

    
    // if(response.statusCode == 400) {
    //   Get.off(() => HomePage());
    // } else {
    //   Get.snackbar(
    //     "Erreur", 
    //     response.data['error']
    //   );
    // }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/bg.jpg")
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.8),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create",
                style: TextStyle(
                  fontSize: 29
                ),
              ),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FormBuilderTextField(
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.email(context)
                        ]),
                        name: 'email',
                        initialValue: "test@gmail.com",
                        decoration: InputDecoration(
                          // errorText: "Email inalide",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.6),
                          labelStyle: const TextStyle(
                            fontSize: 28,
                            color: Colors.white
                          ),
                          label: Text("Email"),
                          hintText: "HSJSJJS",
                          prefixIcon: Icon(Icons.email),
                          suffixIcon: Icon(Icons.email),
                          // icon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FormBuilderTextField(
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.min(context, 4)
                        ]),
                        name: 'password',
                        initialValue: "53636",
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          label: Text("Mot de passe"),
                          prefixIcon: Icon(Icons.email),
                          suffixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GFButton(
                        shape: GFButtonShape.pills,
                        fullWidthButton: true,
                        textColor: Colors.white,
                        size: GFSize.LARGE,
                        color: GFColors.SUCCESS,
                        text: "Connexion",
                        onPressed: () {
                          
                          if(_formKey.currentState!.saveAndValidate()) {
                            // print(_formKey.currentState!.value);
                            login(data: _formKey.currentState!.value);
                            // print(_emailEmail.text);
                          } else {
                            print("Erreur");
                          }
                          
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "--Or--",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GFButton(
                        shape: GFButtonShape.pills,
                        type: GFButtonType.outline,
                        fullWidthButton: true,
                        textColor: Colors.white,
                        size: GFSize.LARGE,
                        color: GFColors.SUCCESS,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Connecter avec ace",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Image.asset(
                                "assets/images/google.png"
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          
                        },
                      ),
                    ),
                  ],
                )
              )
            ],
          ),
        )
      ),
    );
  }
}