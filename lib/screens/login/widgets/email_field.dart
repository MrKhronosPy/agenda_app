import 'dart:ffi';

import 'package:agenda_app/constants.dart';
import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  final bool fadeEmail;
  final TextEditingController emailController;
  const EmailField(
      {super.key, required this.emailController, required this.fadeEmail});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> with SingleTickerProviderStateMixin {
  
  double bottomAnimationValue = 0;
  double opacityAnimationValue = 0;
  EdgeInsets paddingAnimationValue = const EdgeInsets.only(top: 22);

  late TextEditingController emailController;
  late AnimationController _animationController;
  late Animation<Color?> _animation;

  FocusNode node = FocusNode();

  bool isValid = false;
  bool isEmpty = true;

  @override
  void initState() {
    emailController = widget.emailController;
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    final tween = ColorTween(begin: Colors.grey.withOpacity(0), end: primaryColor);

    _animation = tween.animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    super.initState();

    node.addListener(() {
      if (node.hasFocus) {
        setState(() {
          bottomAnimationValue = 1;
        });
      } else {
        setState(() {
          bottomAnimationValue = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300),
          tween: Tween(begin: 0, end: widget.fadeEmail ? 0 : 1),
          builder: ((_, value, __) => Opacity(
                opacity: value,
                child: TextFormField(
                  controller: emailController,
                  focusNode: node,
                  decoration: const InputDecoration(hintText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) async {
                    if (value.isNotEmpty) {

                      isEmpty = false;

                      isValid = isValidEmail(value);

                      if (isValid) {
                        setState(() {
                          bottomAnimationValue = 0;
                          opacityAnimationValue = 1;
                          paddingAnimationValue = const EdgeInsets.only(top: 0);
                        });
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                        setState(() {
                          bottomAnimationValue = 1;
                          opacityAnimationValue = 0;
                          paddingAnimationValue = const EdgeInsets.only(top: 22);
                        });
                      }
                    } else {

                      isEmpty = true;

                      setState(() {
                        bottomAnimationValue = 0;
                      });
                    }
                  },
                ),
              )),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: widget.fadeEmail ? 0 : 300,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: bottomAnimationValue),
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 500),
                builder: ((context, value, child) => LinearProgressIndicator(
                      value: value,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      color: isEmpty ? Colors.black : isValid ?  primaryColor : Colors.red,
                    )),
              ),
            ),
          ),
        ),
        IconMail(paddingAnimationValue: paddingAnimationValue, widget: widget, animation: _animation, isEmpty: isEmpty, isFocused: bottomAnimationValue == 1 ? false : true, isValid: isValid,),
      ],
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
    .hasMatch(email);
  }
}

class IconConfirmPassword extends StatelessWidget {

  const IconConfirmPassword({
    Key? key,
    required this.paddingAnimationValue,
    required this.widget,
    required Animation<Color?> animation,
  }) : _animation = animation, super(key: key);

  final EdgeInsets paddingAnimationValue;
  final EmailField widget;
  final Animation<Color?> _animation;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedPadding(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.only(top: 0),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: widget.fadeEmail ? 0 : 1),
          duration: const Duration(milliseconds: 700),
          builder: ((context, value, child) => Opacity(
                opacity: value,
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0).copyWith(bottom: 0),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 27,
                      color: primaryColor // _animation.value,
                    ),
                  ),
                ),
              )),
        ),
      ),
    ); 
  }
}
class IconErrorPassword extends StatelessWidget {
  const IconErrorPassword({
    Key? key,
    required this.paddingAnimationValue,
    required this.widget,
    required Animation<Color?> animation,
  }) : _animation = animation, super(key: key);

  final EdgeInsets paddingAnimationValue;
  final EmailField widget;
  final Animation<Color?> _animation;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedPadding(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.only(top: 0),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: widget.fadeEmail ? 0 : 1),
          duration: const Duration(milliseconds: 700),
          builder: ((context, value, child) => Opacity(
                opacity: value,
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0).copyWith(bottom: 0),
                    child: const Icon(
                      Icons.cancel_outlined,
                      size: 27,
                      color: Colors.red // _animation.value,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

class IconMailEmpty extends StatelessWidget {
  const IconMailEmpty({
    Key? key,
    required this.paddingAnimationValue,
    required this.widget,
    required Animation<Color?> animation,
  }) : _animation = animation, super(key: key);

  final EdgeInsets paddingAnimationValue;
  final EmailField widget;
  final Animation<Color?> _animation;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedPadding(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.only(top: 0),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: widget.fadeEmail ? 0 : 1),
          duration: const Duration(milliseconds: 700),
          builder: ((context, value, child) => Opacity(
                opacity: value,
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0).copyWith(bottom: 0),
                    child: Icon(
                      Icons.alternate_email_outlined,
                      size: 27,
                      color: Colors.black // _animation.value,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

class IconMail extends StatelessWidget {
  const IconMail({
    Key? key,
    required this.paddingAnimationValue,
    required this.widget,
    required Animation<Color?> animation, 
    required this.isValid, 
    required this.isEmpty, 
    required this.isFocused,
  }) : _animation = animation, super(key: key);

  final EdgeInsets paddingAnimationValue;
  final EmailField widget;
  final Animation<Color?> _animation;
  final bool isValid;
  final bool isEmpty;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedPadding(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.only(top: 0),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: isFocused ? 0 : 1),
          duration: const Duration(milliseconds: 700),
          builder: ((context, value, child) => Opacity(
                opacity: value,
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0).copyWith(bottom: 0),
                    child: Icon(
                      isEmpty ? Icons.alternate_email_outlined : isValid ? Icons.check_rounded : Icons.cancel_outlined ,
                      size: 27,
                      color: isEmpty ? Colors.black : isValid ? primaryColor : Colors.red // _animation.value,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
