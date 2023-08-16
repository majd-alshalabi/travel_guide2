import 'package:flutter/material.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';


class ChatItemBox extends StatelessWidget {
   ChatItemBox({super.key,
    required this.lastLetter,
   required  this.userImage,
    required this.userName,
     required this.countOfLetters,
     required this.date,
   });
  String userImage;
  String userName;
  String lastLetter;
  String countOfLetters;
  String date;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const  TravelGuideUserAvatar(imageUrl: '', width: 20),
             SizedBox(width: 3,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(userName,


                    //TODO OOOOOOOOOOOOOOOOOOOO
                    style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: theme.white,
                  ) ,

                  ),
                ),
               const SizedBox(
                  height: 10,
                ),
                Text(lastLetter,
                  //TODO OOOOOOOOOOOOOOOOOOOO

                  style:const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey,
                  ) ,maxLines: 1,)
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                countOfLetters.isNotEmpty
                ? Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: Text(countOfLetters , style:const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.black,
                    ) ,),
                  ),
                ):const SizedBox(    width: 25,
                  height: 25,),
                const SizedBox(
                  height: 17,
                ),
                Text(date, style:const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.orange,
                ) ,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
