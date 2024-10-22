import 'package:flutter/material.dart';

class FromDivider extends StatelessWidget {
  const FromDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(child: Divider(color: Colors.grey,thickness: 0.5,indent: 60,endIndent: 5)),
      Text("or sing in with"),
              Flexible(child: Divider(color: Colors.grey,thickness: 0.5,indent: 5,endIndent: 50)),
    ],);
  }
}
