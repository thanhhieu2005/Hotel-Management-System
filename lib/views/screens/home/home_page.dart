import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/views/screens/login/login_page.dart';
import 'package:hotel_management_system/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String nameRoute = '/home';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => HomePage(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePagState createState() => _HomePagState();
}

class _HomePagState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          authProvider.currentStaff.fullName.toString(),
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text("Home Page", style: TextStyle(fontSize: 20)),
              Container(
                height: 60,
                width: 150,
                child: RoundedButton(
                    text: "Logout",
                    press: () {
                      authProvider.logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginPage.nameRoute, (route) => false);
                    },
                    textColor: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}