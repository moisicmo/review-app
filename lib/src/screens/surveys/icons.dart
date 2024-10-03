import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class IconsAnimated extends StatefulWidget {
  final String imageIcon;
  final Function onTap;
  const IconsAnimated({Key? key, required this.imageIcon, required this.onTap})
      : super(key: key);

  @override
  State<IconsAnimated> createState() => _IconsAnimatedState();
}

class _IconsAnimatedState extends State<IconsAnimated> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LikeButton(
      onTap: onLikeButtonTapped,
      size: size.width / 5.7,
      isLiked: null,
      circleColor: CircleColor(
        start: Colors.grey[200]!,
        end: Colors.grey[400]!,
      ),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.red,
        dotSecondaryColor: Colors.blue,
      ),
      likeBuilder: (bool isLiked) => Image.asset(widget.imageIcon),
      countPostion: CountPostion.left,
      countBuilder: (int? count, bool? isLiked, String? text) {
        return Text(
          count == 0 ? 'love' : text!,
          style: const TextStyle(color: Colors.grey),
        );
      },
      likeCountPadding: const EdgeInsets.only(right: 15.0),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    widget.onTap();
    return !isLiked;
  }
}
