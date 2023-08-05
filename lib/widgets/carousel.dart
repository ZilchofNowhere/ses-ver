import 'package:flutter/material.dart';
import 'package:greenie/assets/events.dart';

class Carousel extends StatefulWidget {
  final List<Event> items;
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
            event: widget.items[index % widget.items.length],
          );
        },
      ),
    );
  }
}

class CarouselCard extends StatelessWidget {
  final Event event;
  const CarouselCard({super.key, required this.event});

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
            Image.network(
              event.imagePath,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                event.content,
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
