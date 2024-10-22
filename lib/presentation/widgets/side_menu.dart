import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu(
      {super.key,
      required this.scaffoldKey,
      required this.selectedIndex,
      required this.onCategorySelected});
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    // final int navDrawerIndex = 0;

    return NavigationDrawer(
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: (int index) {
        // final categories = [
        //   'general',
        //   'business',
        //   'entertainment',
        //   'health',
        //   'science',
        //   'sports',
        //   'technology',
        // ];
        // final selectedCategory = categories[index];
        // context.go('/$selectedCategory');
        widget.onCategorySelected(
            index); // Llamar al callback cuando se seleccione una categoría
        Navigator.pop(context);
      },
      children: const [
        NavigationDrawerDestination(
          icon: Icon(Icons.article),
          label: Text('General'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.business),
          label: Text('Business'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.movie),
          label: Text('Entertainment'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.health_and_safety),
          label: Text('Health'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.science),
          label: Text('Science'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.sports),
          label: Text('Sports'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.computer),
          label: Text('Technology'),
        ),
      ],
    );
  }
}
