import 'package:flutter/material.dart';


class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget({
    super.key,
    required this.iSend,
    required this.message,
    required this.date,
    required this.image,
  });

  final bool iSend;
  final String message;
  final String date;
  final String image;

  @override
  Widget build(BuildContext context) {
    final isRTL = Localizations.localeOf(context).languageCode == 'en';
    return Directionality(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(top: 8 ,left: 8 ,right: 8 ,bottom: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
          !iSend ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            !iSend
                ? CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: 23,
            )
                : Container(),
            SizedBox(width:MediaQuery.of(context).size.width*0.000999),
            Expanded(
              child: Column(
                crossAxisAlignment:
                !iSend ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.5),
                      decoration: BoxDecoration(
                        color: !iSend
                            ? Colors.blueGrey
                            : Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: iSend
                              ? Radius.circular(isRTL ? 0 : 16)
                              : Radius.circular(isRTL ? 16 : 0),
                          bottomRight: !iSend
                              ? Radius.circular(isRTL ? 0 : 16)
                              : Radius.circular(isRTL ? 16 : 0),),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8 ,right: 8 ,top: 8 ,bottom: 0),
                        child: Text(
                          message,
                          style: !iSend
                              ? const TextStyle(
                            fontSize: 16,
                            color: Colors.black26,
                            fontWeight: FontWeight.w400,
                          )
                              : const TextStyle(
                            fontSize: 16,
                            color: Colors.black26,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      mainAxisAlignment: !iSend
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        Text(
                          date,
                          style: !iSend
                              ? const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black12,
                          )
                              : const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
