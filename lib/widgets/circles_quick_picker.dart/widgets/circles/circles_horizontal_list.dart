import 'package:Openbook/models/circle.dart';
import 'package:Openbook/widgets/circles_picker/widgets/circles_search_results.dart';
import 'package:Openbook/widgets/circles_quick_picker.dart/widgets/circles/widgets/circle_horizontal_list_item.dart';
import 'package:Openbook/widgets/circles_quick_picker.dart/widgets/circles/widgets/new_circle_horizontal_list_item.dart';
import 'package:flutter/material.dart';

class OBCirclesHorizontalList extends StatelessWidget {
  final OnCirclePressed onCirclePressed;
  final List<Circle> circles;
  final List<Circle> selectedCircles;
  final List<Circle> disabledCircles;
  final VoidCallback onWantsToCreateANewCircle;

  OBCirclesHorizontalList(this.circles,
      {@required this.onCirclePressed,
      @required this.selectedCircles,
      @required this.disabledCircles,
      @required this.onWantsToCreateANewCircle});

  @override
  Widget build(BuildContext context) {
    int itemCount = circles.length + 1;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        Widget listItem;

        bool isLastItem = index == itemCount - 1;

        if (isLastItem) {
          listItem = OBNewCircleHorizontalListItem(
            onPressed: onWantsToCreateANewCircle,
          );
        } else {
          var circle = circles[index];
          bool isSelected = selectedCircles.contains(circle);
          bool isDisabled = disabledCircles.contains(circle);
          listItem = OBCircleHorizontalListItem(circle,
              onCirclePressed: onCirclePressed,
              isSelected: isSelected,
              isDisabled: isDisabled);
        }

        return Padding(
          padding: EdgeInsets.only(left: 20, right: isLastItem ? 20 : 0),
          child: listItem,
        );
      },
    );
  }
}
