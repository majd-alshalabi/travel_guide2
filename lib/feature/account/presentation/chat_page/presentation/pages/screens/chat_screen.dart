// import 'package:flutter/material.dart';
// import 'package:myth/features/chat/presentation/pages/chat_details.dart';
// import 'package:myth/features/chat/presentation/widget/chat_item_widget.dart';
// import 'package:travel_guide/feature/account/presentation/chat_page/presentation/pages/chat_details.dart';
//
// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: ListView.builder(
//           itemBuilder: (context, index) => InkWell(
//             onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                   const ChatDetails(senderName: "Harry Peterson"),
//                 ),
//             ),
//             child: ChatItemBox(
//                 lastLetter: "lastLetter",
//                 userImage: 'assets/icons/png/Search.png',
//                 userName: "userName",
//                 countOfLetters: '',
//                 date: '10/7'),
//           ),
//           itemCount: 10,
//         ));
//   }
// }
