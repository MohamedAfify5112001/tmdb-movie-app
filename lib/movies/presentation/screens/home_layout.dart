import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/controller/home_layout_bloc.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLayoutBloc, HomeLayoutState>(
      builder: (context, state) {
        return Scaffold(
          body: BlocProvider.of<HomeLayoutBloc>(context)
              .screens[context.watch<HomeLayoutBloc>().currentIndex],
          backgroundColor: Colors.grey.shade900,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey.shade900,
            type: BottomNavigationBarType.fixed,
            elevation: 15,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey.shade600,
            iconSize: 25.0,
            onTap: (index) {
              BlocProvider.of<HomeLayoutBloc>(context)
                  .add(HomeLayoutAllScreensEvent(index));
            },
            currentIndex: context.watch<HomeLayoutBloc>().currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
              BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TVs")
            ],
          ),
        );
      },
    );
  }
}
