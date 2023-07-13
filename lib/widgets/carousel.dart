import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List<List<String>> items;
  const Carousel({super.key, required this.items});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  PageController controller = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: currentPage,
      keepPage: true,
      viewportFraction: 0.9,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 280),
      child: PageView.builder(
        controller: controller,
        onPageChanged: (newPage) {
          setState(() {
            currentPage = newPage;
          });
        },
        itemBuilder: (context, index) {
          return CarouselCard(
            image: widget.items[index % widget.items.length][0],
            description: widget.items[index % widget.items.length][1],
          );
        },
        // children: [
        //   ...(widget.items.map(
        //     (e) => CarouselCard(
        //       image: e.first,
        //       description: e[1],
        //     ),
        //   )),
        // ],
      ),
    );
  }
}

class CarouselCard extends StatelessWidget {
  final String image;
  final String description;
  const CarouselCard(
      {super.key, required this.image, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                description,
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
