import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/utils/themes.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:travel_guide/injection.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.type,
      required this.prefix,
      required this.color,
      required this.controllerName,
      required this.label,
      this.valedate});
  final Color color;
  final String? Function(String?)? valedate;
  final String label;
  final Icon prefix;
  final TextEditingController controllerName;
  final TextInputType type;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerName,
      keyboardType: type,
      validator: valedate,
      decoration: InputDecoration(
        labelText: label,
        border: InputBorder.none,
        prefixIcon: prefix,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1,
            )),
        focusedBorder: const OutlineInputBorder(
            //Outline border type for TextFeild
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1,
            )),
      ),
    );
  }
}

class CustomBottom extends StatelessWidget {
  final Color buttonColor;
  final double height;
  final String text;
  final Function onPress;
  final Color borderColor;
  final TextStyle textStyleForButton;
  const CustomBottom(
      {super.key,
      required this.text,
      required this.height,
      required this.buttonColor,
      required this.onPress,
      required this.borderColor,
      required this.textStyleForButton});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPress();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 3),
          color: buttonColor,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyleForButton,
          ),
        ),
      ),
    );
  }
}

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey,
      ),
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  final double width;

  const TitlePlaceholder({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 12.0,
            color: theme.black,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: width,
            height: 12.0,
            color: theme.black,
          ),
        ],
      ),
    );
  }
}

enum ContentLineType {
  twoLines,
  threeLines,
}

class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({
    Key? key,
    required this.lineType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 96.0,
            height: 72.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10.0,
                  color: Colors.grey,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    color: theme.white,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                Container(
                  width: 100.0,
                  height: 10.0,
                  color: Colors.grey,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SettAlKolUserAvatar extends StatelessWidget {
  const SettAlKolUserAvatar({
    Key? key,
    required this.imageUrl,
    required this.width,
  }) : super(key: key);
  final String imageUrl;
  final double width;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    try {
      return CircleAvatar(
        radius: width / 2,
        backgroundColor: theme.greyWeak,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            width: width,
            height: width,
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, progress) => const Image(
              image: AssetImage(ImagesApp.userAvatarAsset),
              fit: BoxFit.fill,
            ),
            imageUrl: "",
            // "${NetworkConfigurations.BaseUrl}${NetworkConfigurations.kGetImagePath}/$imageUrl",
            errorWidget: (context, url, error) => const Image(
              image: AssetImage(ImagesApp.userAvatarAsset),
              fit: BoxFit.fill,
            ),
          ),
        ),
      );
    } catch (e) {
      return CircleAvatar(
        radius: width / 2,
        backgroundColor: theme.greyWeak,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: const Image(
            image: AssetImage(ImagesApp.userAvatarAsset),
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }
}

class TravelGuideUserAvatar extends StatelessWidget {
  const TravelGuideUserAvatar({
    Key? key,
    required this.imageUrl,
    required this.width,
  }) : super(key: key);
  final String imageUrl;
  final double width;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: width / 2,
      backgroundColor: Colors.grey,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          width: width,
          height: width,
          fit: BoxFit.fill,
          progressIndicatorBuilder: (context, url, progress) => const Image(
            image: AssetImage(ImagesApp.userAvatarAsset),
            fit: BoxFit.fill,
          ),
          imageUrl: imageUrl,
          errorWidget: (context, url, error) => const Image(
            image: AssetImage(ImagesApp.userAvatarAsset),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.title, this.showBackButton = true});

  final String title;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = sl<ThemeCubit>().globalAppTheme;
    return AppBar(
      backgroundColor: theme.darkAndWhiteForAppBar,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 18,
              color: theme.reserveDarkScaffold,
            ),
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: theme.darkAndWhiteForAppBar,
      ),
      leading: showBackButton && Navigator.of(context).canPop()
          ? IconButton(
              color: theme.reserveDarkScaffold,
              iconSize: 20,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class CustomText extends StatelessWidget {
  final String titleName;
  final TextStyle textStyleForTextTilte;
  final TextStyle defaultTextStyle;
  final Function onTap;
  CustomText({
    super.key,
    required this.titleName,
    required this.onTap,
    required this.textStyleForTextTilte,
    required this.defaultTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 10.0, 10.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleName,
            style: textStyleForTextTilte,
          ),
          InkWell(
            onTap: () {
              onTap();
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)?.translate('See all') ?? "",
                    style: defaultTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAddTextField extends StatelessWidget {
  const CustomAddTextField({
    super.key,
    required this.type,
    required this.color,
    required this.controllerName,
    required this.label,
    required this.valedate,
  });
  final Color color;
  final Function valedate;
  final String label;
  final TextEditingController controllerName;
  final TextInputType type;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.blue,
      controller: controllerName,
      keyboardType: type,
      validator: (val) {
        return valedate(val);
      },
      decoration: InputDecoration(
        errorStyle: StylesText.defaultTextStyle.copyWith(color: Colors.red),
        hintText: label,
        border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 0,
            )),
        hintStyle: StylesText.defaultTextStyle,
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1,
            )),
      ),
    );
  }
}

class NewCustomBottom extends StatelessWidget {
  final double height;
  final double? width;
  final String text;
  final Function onPress;
  final Color borderColor;
  final TextStyle textStyleForButton;
  const NewCustomBottom({
    super.key,
    required this.text,
    required this.height,
    this.width,
    required this.onPress,
    required this.borderColor,
    required this.textStyleForButton,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () {
          onPress();
        },
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 0),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.lightBlueAccent,
                Colors.blueAccent,
              ],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
              child: Text(
            text,
            style: textStyleForButton,
          )),
        ));
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.fontSize,
    this.widthFactor = 0.8,
    this.heightFactor = 0.08,
    this.borderRadius = 8,
    this.onPressed,
    this.style,
    this.backgroundColor,
    this.textColor,
    this.fontWeight,
  });

  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final Color? textColor;
  final ButtonStyle? style;
  final String text;
  final double widthFactor;
  final double heightFactor;
  final double borderRadius;
  final double? fontSize;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * widthFactor,
      height: MediaQuery.of(context).size.height * heightFactor,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.orange,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextButton(
        style: style,
        onPressed: onPressed,
        child: Center(
          child: Text(text, style: StylesText.textStyleForButton),
        ),
      ),
    );
  }
}

class LogOutCustomBottom extends StatelessWidget {
  final double height;
  final double? width;
  final String text;
  final Function onPress;
  final Color borderColor;
  final TextStyle textStyleForButton;
  const LogOutCustomBottom({
    super.key,
    required this.text,
    required this.height,
    this.width,
    required this.onPress,
    required this.borderColor,
    required this.textStyleForButton,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () {
          onPress();
        },
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 0),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.red,
                Colors.redAccent,
              ],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
              child: Text(
            text,
            style: textStyleForButton,
          )),
        ));
  }
}
