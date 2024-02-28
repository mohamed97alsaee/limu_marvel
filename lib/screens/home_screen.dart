
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limu_marvel/helpers/consts.dart';
import 'package:limu_marvel/main.dart';
import 'package:limu_marvel/providers/auth_provider.dart';
import 'package:limu_marvel/providers/movies_provider.dart';
import 'package:limu_marvel/widgets/movie_card.dart';

import 'package:limu_marvel/widgets/shimmer_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<MoviesProvider>(context, listen: false).getMovies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<MoviesProvider>(builder: (context, moviesConsumer, _) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black87),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Image.asset(
            "assets/InvertedLogo.png",
            width: size.width * 0.2,
          ),
        ),
        body: moviesConsumer.isFailed
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.network_locked_sharp,
                        color: primaryColor.withOpacity(0.6),
                        size: size.width * 0.2),
                    const Text(
                      "Somthing went wrong!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  Divider(
                    color: primaryColor.withOpacity(0.2),
                    height: 0,
                  ),
                  Expanded(
                    child: GridView.builder(
                        padding: const EdgeInsets.all(24),
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 24),
                        itemCount: moviesConsumer.isLoading
                            ? 10
                            : moviesConsumer.movies.length,
                        itemBuilder: (context, index) {
                          return moviesConsumer.isLoading
                              ? const ShimmerWidget()
                              : MovieCard(
                                  movieModel: moviesConsumer.movies[index],
                                );
                        }),
                  )
                ],
              ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const ListTile(
                  title: Text("Contact Us"),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .logout()
                        .then((logedOut) {
                      if (logedOut) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const ScreenRouter()),
                            (route) => false);
                      }
                    });
                  },
                  child: const ListTile(
                    title: Text("Logout"),
                    trailing: Icon(Icons.exit_to_app),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
