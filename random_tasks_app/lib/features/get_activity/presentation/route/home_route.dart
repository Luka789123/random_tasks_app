import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/entity/activity.dart';

import '../bloc/activity_bloc.dart';

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Boredom App'),
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ActivityBloc>(context, listen: false)
        .add(GetActivitiesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: size.height * 0.5,
            child: const ActivityDisplay(),
          ),
          SizedBox(
            height: size.height * 0.3,
            child: Center(
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Theme.of(context).primaryColor)),
                onPressed: () => BlocProvider.of<ActivityBloc>(context)
                    .add(GetActivitiesEvent()),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Get next activity',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityDisplay extends StatelessWidget {
  const ActivityDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ActivityBloc, ActivityState>(
            builder: (context, state) {
              if (state is LoadedState) {
                return DetialsDisplay(
                  activity: state.activity,
                );
              } else if (state is ErrorState) {
                return ErrorWidget(
                  state: state,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final ActivityState state;
  const ErrorWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _errorMaper(context),
    );
  }

  Widget _errorMaper(BuildContext context) {
    final temp = state as ErrorState;
    switch (temp.faliure) {
      case Failures.network:
        return IconTheme(
          data: IconThemeData(color: Colors.grey.shade500, size: 100),
          child: Column(
            children: [
              const Icon(Icons.wifi_off),
              Text(
                'Nema povezanosti na internet',
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        );
      case Failures.server:
        return Column(
          children: [
            const Icon(Icons.dns),
            Text('Nema povezanosti na internet',
                style: Theme.of(context).textTheme.caption)
          ],
        );

      default:
        return Column(
          children: [
            Icon(Icons.wifi_off),
            Text('Nema povezanosti na internet',
                style: Theme.of(context).textTheme.caption)
          ],
        );
    }
  }
}

class DetialsDisplay extends StatelessWidget {
  final Activity activity;
  const DetialsDisplay({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            activity.activtiyName,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
        ItemWidget(
          activity: activity,
          title: activity.accessibility.toString(),
          icon: Icons.accessibility,
        ),
        ItemWidget(
            activity: activity,
            icon: Icons.sell,
            title: activity.price.toString()),
        ItemWidget(
            activity: activity,
            icon: Icons.groups,
            title: activity.participants.toString())
      ],
    );
  }
}

class ItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const ItemWidget({
    Key? key,
    required this.activity,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.grey.shade500,
            size: 20,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
