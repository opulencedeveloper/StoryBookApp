import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

import '../widgets/story_book.dart';
import '../provider/books.dart';
import '../screens/book_details_screen.dart';

class MyHomeTab extends StatefulWidget {
  const MyHomeTab({Key? key}) : super(key: key);
  @override
  _MyHomeTabState createState() => _MyHomeTabState();
}

class _MyHomeTabState extends State<MyHomeTab> {
  Future<dynamic>? _allUsersFuture;

  Future _obtainAllUsersFuture() {
    return Provider.of<Books>(context, listen: false).fetchAndSetBooks();
  }

  @override
  void initState() {
    super.initState();
    _allUsersFuture = _obtainAllUsersFuture();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    //final theme2 = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    Widget content(String type) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(type,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              )),
          const Text('See all',
              style: TextStyle(
                color: Color(0xff8C8C8C),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ))
        ],
      );
    }

    return Container(
      height: (mediaQuery.size.height -
          mediaQuery.padding.top -
          kBottomNavigationBarHeight),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: FutureBuilder(
          future: _allUsersFuture,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ));
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        visualDensity: const VisualDensity(horizontal: 0),
                        horizontalTitleGap: 10,
                        leading: SizedBox(
                            width: 50,
                            child: CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.grey[100],
                              backgroundImage:
                                  const AssetImage('assets/images/profile.png'),
                            )),
                        title: const Text(
                          'Hello Reader',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Row(children: [
                          const Text('Welcome',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 14,
                              )),
                          const SizedBox(width: 5),
                          SizedBox(
                              height: 15,
                              child: Image.asset('assets/images/hi.png')),
                        ]),
                        trailing: SizedBox(
                          height: 40,
                          width: 50,
                          child: Badge(
                            animationType: BadgeAnimationType.fade,
                            padding: const EdgeInsets.all(4),
                            //toAnimate: false,
                            badgeContent:
                                const Text("0", style: TextStyle(fontSize: 10)),
                            badgeColor: Colors.red,
                            position: BadgePosition.topEnd(top: 3, end: 10),
                            child: const Icon(
                              Icons.notifications_outlined,
                              size: 40,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        readOnly: true,
                        enableInteractiveSelection:
                            false, // will disable paste operation
                        //enabled: false,
                        //focusNode: new AlwaysDisabledFocusNode(),
                        //autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                          ),
                          filled: true,
                          fillColor: theme.secondary,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      const SizedBox(height: 40),
                      content('Recently Viewed'),
                      const StoryBook(type: 'recent'),
                      const SizedBox(height: 25),
                      content('New'),
                      const StoryBook(type: 'new'),
                      const SizedBox(height: 25),
                      content('More for you'),
                      const StoryBook(type: 'more'),
                    ],
                  ),
                );
              }
            }
          }),
    );
  }
}
