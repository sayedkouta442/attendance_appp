import 'package:attendance_appp/core/utils/routs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RequestButton extends StatelessWidget {
  const RequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Color(0xff3662e1).withOpacity(.07),
        ),
        foregroundColor: WidgetStatePropertyAll(
          Color(0xff3662e1).withOpacity(.01),
        ),
        elevation: const WidgetStatePropertyAll(0),
        //     overlayColor: WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide(color: Color(0xff3662e1), width: 2),
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),

      onPressed: () {
        GoRouter.of(context).push(AppRouter.kLeaveView);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Color(0xff3662e1), size: 34),
          SizedBox(width: 8),
          Text(
            'Request',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff3662e1),
            ),
          ),
        ],
      ),
    );
  }
}
