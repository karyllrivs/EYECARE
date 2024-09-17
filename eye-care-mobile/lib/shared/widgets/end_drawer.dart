import 'package:eyecare_mobile/model/category.model.dart';
import 'package:eyecare_mobile/view_model/auth.view_model.dart';
import 'package:eyecare_mobile/view_model/category.view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({super.key});

  @override
  State<EndDrawer> createState() => _EndDrawer();
}

class _EndDrawer extends State<EndDrawer> {
  List<Category> additionalLinks = [
    Category(id: "", name: "Logout", description: "", isInNavbar: true)
  ];
  List<Category> categories = [];

  Future<void> logout() async {
    await context.read<AuthViewModel>().logoutUser();
  }

  @override
  void didChangeDependencies() {
    categories = [
      ...context.watch<CategoryViewModel>().categories,
      ...additionalLinks
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
      child: Column(
        children: [
          ListTile(
            trailing: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return !category.isInNavbar
                    ? const SizedBox()
                    : ListTile(
                        title: Text(
                          category.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          if (category.name == "Logout") {
                            logout();
                            return;
                          }

                          context.go("/category", extra: category.id);
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
