import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../data/model/configuration.dart';

class ContactDialog extends StatefulWidget {
  const ContactDialog({
    super.key,
  });

  @override
  State<ContactDialog> createState() => _ContactDialogState();
}

class _ContactDialogState extends State<ContactDialog> {
  final subjectController = TextEditingController();
  final textController = TextEditingController();

  @override
  void dispose() {
    subjectController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Column(
        children: [
          CupertinoTextField(
            controller: subjectController,
            placeholder: 'Message subject',
          ),
          const SizedBox(height: 30),
          CupertinoTextField(
            controller: textController,
            placeholder: 'Message text',
            maxLines: 4,
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: Configuration().supportEmail,
              query: _encodeQueryParameters(<String, String>{
                'subject': subjectController.text,
                'body': textController.text,
              }),
            );
            launchUrl(emailLaunchUri);
          },
          child: Text(
            'Send',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          isDestructiveAction: true,
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color.fromRGBO(219, 33, 33, 1),
                ),
          ),
        ),
      ],
    );
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
