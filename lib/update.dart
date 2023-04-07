import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UpdateTaskAlertDialog extends StatefulWidget {
  const UpdateTaskAlertDialog({super.key, required this.taskName});
  final String taskName;
  @override
  State<UpdateTaskAlertDialog> createState() => UpdateTaskAlertDialog_State();
}

class UpdateTaskAlertDialog_State extends State<UpdateTaskAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
