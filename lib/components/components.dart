import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:messenger/styles/icon_broken.dart';

String email = '';
String password = '';

Widget buildEmailField() {
  return TextFormField(
    decoration: InputDecoration(
      icon: const Icon(Icons.email, size: 30, color: Colors.purple),
//        fillColor: Color(0xfff3f3f4),
      //    filled: true,
      labelText: "email",
      hintText: 'Enter your Email',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    keyboardType: TextInputType.emailAddress,
    //initialValue: 'ahmed@Epark.com',

    cursorColor: Colors.purple,
    validator: (String? value) {
      if (value!.isEmpty) {
        return 'Email is required';
      }

      if (!RegExp(
              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
          .hasMatch(value)) {
        return 'Please enter a valid email address';
      }

      return null;
    },
    onChanged: (value) {
      email = value;
    },
//      onSaved: (String value) {
//        _user.email = value;
//      },
  );
}

Widget buildPasswordField({required TextEditingController passController}) {
  return TextFormField(
    obscureText: true,
    decoration: InputDecoration(
      icon: const Icon(Icons.lock, size: 30, color: Colors.purple),
      suffixIcon: IconButton(
        icon: const Icon(Icons.visibility),
        onPressed: () {},
      ),
      fillColor: const Color(0xfff3f3f4),
      filled: true,
      labelText: "password",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    cursorColor: Colors.purple,

    controller: passController,
    validator: (value) {
      if (value == null) {
        return 'Password is required';
      }

      if (value.length < 5 || value.length > 20) {
        return 'Password must be betweem 5 and 20 characters';
      }

      return null;
    },
//      onSaved: (String value) {
//        _user.password = value;
//      },
    onChanged: (value) {
      password = value;
    },
  );
}

// Widget defaultButton({
//   double width = double.infinity,
//   background = Colors.purple,
//   bool isUpperCase = true,
//   double radius = 8.0,
//   required Function function,
//   required String? text,
// }) =>
//     Container(
//       width: width,
//       height: 50.0,
//       child: ElevatedButton(
//         onPressed: function(),
//         child: Text(
//           isUpperCase ? text!.toUpperCase() : text!,
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(
//           radius,
//         ),
//         color: background,
//       ),
//     );

// Widget defaultTextButton({
//   required Function function,
//   required String text,
// }) =>
//     TextButton(
//       onPressed: function(),
//       child: Text(
//         text.toUpperCase(),
//       ),
//     );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit!(),
      onChanged: onChange!(),
      onTap: onTap!(),
      validator: validate(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed!(),
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      titleSpacing: 5.0,
      leading: IconButton(
        icon: const Icon(IconBroken.Arrow___Left_2),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text('$title'),
      actions: actions ?? [],
    );

// if (!FirebaseAuth.instance.currentUser!.emailVerified)
// Container(
// color: Colors.amber.withOpacity(.7),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20.0),
// child: Row(
// children: [
// const Icon(Icons.info_outline),
// const SizedBox(
// width: 15.0,
// ),
// const Text('please varify your email'),
// const SizedBox(
// width: 15.0,
// ),
// const Spacer(),
// TextButton(
// onPressed: () {
// FirebaseAuth.instance.currentUser!
//     .sendEmailVerification()
//     .then((value) {
// showToast(
// message: 'check your mail',
// state: ToastStates.SUCCESS);
// }).catchError((onError) {
// print(onError.toString());
// });
// },
// child: const Text('Send'),
// ),
// ],
// ),
// ),
// ),
