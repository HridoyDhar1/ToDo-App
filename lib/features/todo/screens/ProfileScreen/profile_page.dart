import 'package:flutter/material.dart';
import 'package:todoapp/common/wigets/elevatedbutton/custom_elevatedbutton.dart';
import 'package:todoapp/features/todo/screens/ProfileScreen/edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: Column(
 
      
      children: [
        const SizedBox(height: 100),
   const   Center(
        child: 
        CircleAvatar(backgroundImage: AssetImage("assets/images/man.png"),radius: 50,)
        ),
        const SizedBox(height: 20),
     const   Text("Hridoy Dhar",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                const    Text("@hridoydhar",style: TextStyle(fontSize: 15)),
                    const SizedBox(height: 20),
                    CustomElevatedbutton(hSize: 40, vSize: 10, onPressed: _editProfile, name: "Edit Profile", textColor: Colors.white),
                    const SizedBox(height: 50),
            
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(height: 80,width: 180,decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.1),
        spreadRadius: 1,blurRadius: 2,offset:const Offset(0, 3))
      ],
  
      color: const Color(0xffF7FAFF),
      borderRadius: BorderRadius.circular(10)),child:const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("On going ",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.normal),),
      SizedBox(height: 10),
       Text("10",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.normal))
        ],
      ),),
      const SizedBox(width: 5,),
      Container(height: 80,width: 180,decoration: BoxDecoration(
         boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.1),
        spreadRadius: 1,blurRadius: 2,offset:const Offset(0, 3))
      ],
      color:const Color(0xffF7FAFF),
      borderRadius: BorderRadius.circular(10)),child:const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Pending ",style: TextStyle(fontSize: 15,color: Colors.black)),
     SizedBox(height: 10),
          Text("10",style: TextStyle(fontSize: 15,color: Colors.black))
        ],
      ),),
  ],
)
    ],),),);
  }
  void _editProfile(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditProfile()));
  }
}