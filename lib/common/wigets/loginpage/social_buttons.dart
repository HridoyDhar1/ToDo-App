
import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                height: 25,width: 25,
                image: AssetImage("assets/icons/Facebook.png"))),
        ),const SizedBox(width: 10),
         Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                height: 25,width: 25,
                image: AssetImage("assets/icons/Google.png"))),
        ),
        const SizedBox(width: 10),
         Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                height: 25,width: 25,
                image: AssetImage("assets/icons/linkdin.png"))),
        )
      ],
    );
  }
}
