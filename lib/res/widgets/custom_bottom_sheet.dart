
import 'package:flutter/material.dart';


class CustomBottomSheet {
  void uploadStoreImage(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
          child: Wrap(
            spacing: 0,
            children: <Widget>[
              child,
            ],
          ),
        );
      },
    );
  }
}
