import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PROFILE'),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                Map<String, dynamic> user = snapshot.data!.data()!;
                return ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(width: 100, height: 100,
                          child: Image.network("https://ui-avatars.com/api/?name=${user['name']}",
                          fit: BoxFit.cover,),
                        ),
                        ),
                      ],
                    ),
                      SizedBox(height: 10,),
                    Text("${user['name']}" , 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),),
                    SizedBox(height: 5,),
                    Text("${user['email']}" , 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),),
                      SizedBox(height: 5,),
                    ListTile(
                      onTap: () {
                      },
                      leading: Icon(Icons.person),
                      title: Text("Update Profile"),
                    ),
                    ListTile(
                      onTap: () {
                      },
                      leading: Icon(Icons.vpn_key),
                      title: Text("Update Password"),
                    ),
                    if(user["role"] == "admin")
                    ListTile(
                      onTap: () {
                      },
                      leading: Icon(Icons.person_add),
                      title: Text("Add Pegawai"),
                    ),
                    ListTile(
                      onTap: ()=> controller.logout(),
                      leading: Icon(Icons.logout),
                      title: Text("Logout"),
                    ),
                    
                  ],
                );
              } else {
                return Center(child: Text('Tidak ada Data'));
              }
            }));
  }
}
