import 'package:flutter/material.dart';
import 'package:limu_marvel/helpers/consts.dart';
import 'package:limu_marvel/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/InvertedLogo.png",
          width: size.width * 0.2,
        ),
      ),
      body: Column(
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24),
                itemCount: nums.length,
                itemBuilder: (context, index) {
                  return const MovieCard();
                }),
          )
        ],
      ),
    );
  }
}
