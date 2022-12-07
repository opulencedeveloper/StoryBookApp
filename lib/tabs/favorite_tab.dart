import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/favorite_book.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context).colorScheme;
    //final theme2 = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final favBooks = Provider.of<FavoriteBooks>(context, listen: false);
    final myFavBooks = favBooks.favoriteBooks;
    return Container(
        height: (mediaQuery.size.height -
            mediaQuery.padding.top -
            kBottomNavigationBarHeight),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: 30),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Saved',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Text(
                'Today',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.black, size: 18),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
              height: (mediaQuery.size.height -
                      mediaQuery.padding.top -
                      kBottomNavigationBarHeight) *
                  0.85,
              // padding: const EdgeInsets.symmetric(horizontal: 15),
              child: myFavBooks.isEmpty
                  ? const Center(
                      child: Text('No Favorite Books'),
                    )
                  : GridView.builder(
                      // padding: const EdgeInsets.all(0),
                      itemCount: myFavBooks.length,
                      itemBuilder: (ctx, i) => Image.network(
                          myFavBooks[i].imageUrl,
                          fit: BoxFit.cover),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisExtent: 200,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 15,
                      ),
                    ))
        ])));
  }
}
