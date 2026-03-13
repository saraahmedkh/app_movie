import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/services/user_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../forget_password/forget_password_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String Selectedavatar = "assets/images/ava1.png";

  Future deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    setState(() {
      nameController.text = "";
      phoneController.text = "";
      Selectedavatar = "assets/images/ava1.png";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Account Deleted")),
    );
  }

  Future updateUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", nameController.text);
    await prefs.setString("phone", phoneController.text);
    await prefs.setString("avatar", Selectedavatar);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile Updated")),
    );
  }

  Future loadUser() async {
    final user = await UserStorage.getUser();
    setState(() {
      nameController.text = user["name"]!;
      phoneController.text = user["phone"]!;
      Selectedavatar = user["avatar"]!;
    });
  }

  List avatars = [
    "assets/images/ava1.png",
    "assets/images/ava2.png",
    "assets/images/ava3.png",
  ];
  bool showsavatars = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 20),

        /// Avatar
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(Selectedavatar),
        ),
        SizedBox(height: 15,),
        SizedBox(
          height: 100,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: avatars.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    Selectedavatar = avatars[index];
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(avatars[index]),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 20),

        /// Name
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: "John Safwat",
              filled: true,
            ),
          ),
        ),

        SizedBox(height: 15),

        /// Phone
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: phoneController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              hintText: "01200000000",
              filled: true,
            ),
          ),
        ),

        SizedBox(height: 15),

        /// Reset Password
        Padding(
          padding: EdgeInsets.only(left: 25),
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgetPasswordScreen()));
              },
              child: Text(
                "Reset Password",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 40),

        /// Delete Account
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              deleteAccount();
            },
            child: Text(
              "Delete Account",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),

        SizedBox(height: 15),

        /// Update Data
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              minimumSize: Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              updateUserData();
            },
            child: Text(
              "Update Data",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
