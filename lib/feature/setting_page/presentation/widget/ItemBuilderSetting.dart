import 'package:flutter/material.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class ItemBuilderSetting extends StatelessWidget {
  const ItemBuilderSetting({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.description,
    this.notActive = false,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String description;
  final bool notActive;

  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 13, right: 13, top: 2),
      child: TextButton(
        onPressed: onPressed.call,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    color: notActive ? Colors.grey : theme.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: StylesText.newDefaultTextStyle.copyWith(
                            fontSize: 20,
                            color: notActive ? Colors.grey : theme.black,
                          ),
                        ),
                        Text(
                          description,
                          style: StylesText.defaultTextStyle
                              .copyWith(fontSize: 14, color: theme.greyWeak),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: notActive ? Colors.grey : theme.blue,
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
