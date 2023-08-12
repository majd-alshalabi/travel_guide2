part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeLoadedState extends ThemeState{
  final ThemeData theme;
  final AppTheme globalAppTheme;
  ThemeLoadedState({required this.theme,required this.globalAppTheme});
}
class ThemeChooseDoneFromDialog extends ThemeState{
  final ThemeType themeType;
  ThemeChooseDoneFromDialog({required this.themeType});
}