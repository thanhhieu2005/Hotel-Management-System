import 'package:flutter/material.dart';
import 'package:hotel_management_system/services/staff_info.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/views/screens/main/manager/manager_home_page.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/receptionist_page.dart';
import 'package:hotel_management_system/views/screens/main/waiter/waiter_page.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/warehouse_page.dart';
import 'package:hotel_management_system/widgets/main_appbar.dart';
import 'package:hotel_management_system/widgets/custom_menu_sidebar.dart';
import 'package:hotel_management_system/views/screens/main/accountant/accountant_page.dart';
import 'package:provider/provider.dart';
import 'kitchen/kitchenpage.dart';

class MainScreen extends StatefulWidget {
  static const String nameRoute = '/main';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => MainScreen(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomMenuSidebar(
        staff: authProvider.currentStaff,
      ),
      appBar: MainAppbar(
          roleName: StaffInfo.setUpRoleName(authProvider.currentStaff.role)),
      body: _navigaToRolePage(authProvider.currentStaff.role),
    );
  }

  _navigaToRolePage(int role) {
    switch (role) {
      case 1:
        return ManagerHomePage();
      case 2:
        return AccountantPage();
      case 3:
        return ReceptionistPage();
      case 4:
        return KitchenPage();
      case 5:
        return WarehousePage();
      case 6:
        return WaiterPage();
      default:
        return null;
    }
  }
}
