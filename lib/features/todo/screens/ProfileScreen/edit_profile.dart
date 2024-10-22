import 'package:flutter/material.dart';
import 'package:todoapp/common/wigets/elevatedbutton/custom_elevatedbutton.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const SizedBox(height: 100),
     
        const CircleAvatar(
          
          backgroundImage: AssetImage("assets/images/man.png"),radius: 50,child: Icon(Icons.camera)
          ),
          const SizedBox(height: 50),
             const   Align(
            alignment: Alignment.bottomLeft,
            child:  Text("Full Name",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
            const SizedBox(height: 10),

          TextFormField(
            
            decoration: InputDecoration(
      hintText: "hridoy",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
             const SizedBox(height: 10),
             const   Align(
            alignment: Alignment.bottomLeft,
            child:  Text("Email",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
            const SizedBox(height: 10),
          TextFormField(
            
            decoration: InputDecoration(
            hintText: 'hridoydhar@gmail.com',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
             const SizedBox(height: 10),
             const   Align(
            alignment: Alignment.bottomLeft,
            child:  Text("Password",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
            const SizedBox(height: 10),
          TextFormField(
            
            decoration: InputDecoration(
            hintText: '********',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 50),
            CustomElevatedbutton(hSize: 50, vSize: 10, onPressed: (){}, name: "Save", textColor: Colors.white)
        
            ],),
      ),),);
  }
}