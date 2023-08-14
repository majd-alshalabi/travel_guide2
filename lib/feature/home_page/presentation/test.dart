import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/presentation/blocs/home_bloc.dart';
import 'package:travel_guide/feature/home_page/presentation/screen/map_page/map_screen.dart';
import 'package:travel_guide/feature/home_page/presentation/widgets/home_widgets.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(GetAllActivityEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.map_rounded))
            ],
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) {
              if (current is GetAllActivityLoading) return true;
              if (current is GetAllActivityError) return true;
              if (current is GetAllActivityLoaded) return true;
              return false;
            },
            builder: (context, state) {
              if (state is GetAllActivityLoading) return HomeLoadingWidget();
              return ListView.builder(
                itemCount: context.read<HomeBloc>().activityList.length,
                itemBuilder: (context, index) {
                  ActivityRemoteModel model =
                      context.read<HomeBloc>().activityList[index];
                  return Text(model.name ?? "");
                },
              );
            },
          ),
        );
      }),
    );
  }
}
