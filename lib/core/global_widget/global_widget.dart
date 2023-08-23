import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travel_guide/app_localizations.dart';
import 'package:travel_guide/core/constants/app_constant.dart';
import 'package:travel_guide/core/constants/app_images.dart';
import 'package:travel_guide/core/constants/styles.dart';
import 'package:travel_guide/core/services/network/network_configrations.dart';
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
        labelStyle: StylesText.newDefaultTextStyle.copyWith(color: Colors.grey),
        border: InputBorder.none,
        prefixIcon: prefix,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1,
            )),
        focusedBorder: const OutlineInputBorder(
          //Outline border type for TextFeild
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
        prefixIconColor: Colors.grey,
      ),
    );
  }
}

class CustomBottom extends StatelessWidget {
  final Gradient buttonColor;
  final double height;
  final String text;
  final Function onPress;
  final Color borderColor;
  final TextStyle textStyleForButton;
  const CustomBottom({
    super.key,
    required this.text,
    required this.height,
    required this.buttonColor,
    required this.onPress,
    required this.borderColor,
    required this.textStyleForButton,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPress();
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 3),
          gradient: buttonColor,
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
      width: 35.w,
      height: 20.h,
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 5),
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
                  width: 200,
                  height: 10.0,
                  color: Colors.grey,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: 200,
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
          imageUrl: "${NetworkConfigurations.BaseUrl}$imageUrl",
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
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: Constant.primaryBodyColor
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          title,
          style: StylesText.newTextStyleForAppBar.copyWith(
            color: theme.darkThemeForScafold,
          ),
        ),
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: theme.accent2,
      ),
      leading: showBackButton && Navigator.of(context).canPop()
          ? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: IconButton(
                color: theme.darkThemeForScafold,
                iconSize: 20,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:  Icon(Icons.arrow_back_ios_new ,color: theme.darkThemeForScafold,),
              ),
          )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class CustomText extends StatelessWidget {
  final String titleName;
  final Function onTap;
  final bool seeAllButton;
  CustomText({
    super.key,
    required this.titleName,
    required this.onTap,
    required this.seeAllButton,
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
            style: StylesText.newDefaultTextStyle.copyWith(color: Colors.black),
          ),
          if (seeAllButton)
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
                      style: StylesText.newDefaultTextStyle
                          .copyWith(color: Colors.grey),
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
      style: StylesText.newDefaultTextStyle.copyWith(color: Colors.black),
      cursorColor: Colors.blue,
      controller: controllerName,
      keyboardType: type,
      validator: (val) {
        return valedate(val);
      },
      decoration: InputDecoration(
        errorStyle: StylesText.newDefaultTextStyle.copyWith(color: Colors.red),
        filled: true,
        hintText: label,
        border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.black38,
            width: 0,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.red,
            width: 0,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.red,
            width: 0,
          ),
        ),
        hintStyle: StylesText.newDefaultTextStyle.copyWith(color: Colors.grey),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1,
          ),
        ),
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

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 19.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              BannerPlaceholder(),
              BannerPlaceholder(),
              BannerPlaceholder(),
            ],
          ),
        ),
      ),
    );
  }
}

class AllActivityLoadingWidget extends StatelessWidget {
  const AllActivityLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            BannerPlaceholder(),
            TitlePlaceholder(width: double.infinity),
            SizedBox(height: 16.0),
            ContentPlaceholder(
              lineType: ContentLineType.threeLines,
            ),
            SizedBox(height: 16.0),
            TitlePlaceholder(width: 200.0),
            SizedBox(height: 16.0),
            ContentPlaceholder(
              lineType: ContentLineType.twoLines,
            ),
            SizedBox(height: 16.0),
            TitlePlaceholder(width: 200.0),
            SizedBox(height: 16.0),
            ContentPlaceholder(
              lineType: ContentLineType.twoLines,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDescriptionTextField extends StatelessWidget {
  const CustomDescriptionTextField({
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
    return SizedBox(
      height: 150,
      child: TextFormField(
        style: StylesText.newDefaultTextStyle.copyWith(color: Colors.black),

        expands: true,
        maxLines: null,
        textAlignVertical:
            TextAlignVertical.top, // Set the vertical alignment to top
        cursorColor: Colors.blue,
        controller: controllerName,
        keyboardType: type,
        validator: (val) {
          return valedate(val);
        },
        decoration: InputDecoration(
          errorStyle:
              StylesText.newDefaultTextStyle.copyWith(color: Colors.red),
          filled: true,
          hintText: label,
          border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.black38,
              width: 0,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.red,
              width: 0,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.red,
              width: 0,
            ),
          ),
          hintStyle:
              StylesText.newDefaultTextStyle.copyWith(color: Colors.grey),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.black38,
              width: 1,
            ),
          ),
        ),
        cursorHeight: 24.0, // Set the desired cursor height
      ),
    );
  }
}
