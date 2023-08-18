import 'dart:io';

import 'package:flutter/material.dart';


class ImageMessageWidget extends StatelessWidget {
  const ImageMessageWidget({
    super.key,
    required this.iSend,
    required this.message,
    required this.date,
    required this.image,
  });
  final bool iSend;
  final String message;
  final String date;
  final File image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      iSend ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width:MediaQuery.of(context).size.width*0.7,
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height*0.3),
            decoration: BoxDecoration(
              color: iSend ? Colors.blueGrey : Colors.grey,
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(16),
                bottomRight: const Radius.circular(16),
                topLeft: iSend ?  Radius.circular(0) : const Radius.circular(16),
                topRight: !iSend ? Radius.circular(0) : const Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    image,
                    width: MediaQuery.of(context).size.width*0.7,
                    height: MediaQuery.of(context).size.height*0.3,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment:Alignment.bottomRight,
                    child: Text(
                      date,
                      style: iSend? const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ):const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
