import 'package:flutter/material.dart';

class CustomContainerTask extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? colors;
  final String images;
  const CustomContainerTask({
    super.key, required this.title, required this.subTitle, required this.images, required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 180,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colors),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
       
            children: [
            
      Image(
          height: 50,width: 50,
          image: AssetImage(images)),
        const    SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Text(title,style:const TextStyle(color: Colors.white),),
            Text(subTitle,style:const TextStyle(color: Colors.white),),
             
            ],
          )
            ],
          ),
        ),
        
    
      ],
    );
  }
}
