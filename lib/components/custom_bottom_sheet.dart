import 'package:flutter/material.dart';

class CustomModalBottomSheetPage extends StatelessWidget {
  final List<ModalBottomSheetOption> options;
  const CustomModalBottomSheetPage({
    Key? key,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      thickness: 2,
                    ),
                itemCount: options.length,
                padding: EdgeInsets.zero,
                itemBuilder: (c, i) {
                  return options[i];
                }),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.all(16)),
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context)),
            )),
      ],
    );
  }
}

class ModalBottomSheetOption extends StatelessWidget {
  final void Function() onTapped;
  final String? title;
  const ModalBottomSheetOption({
    Key? key,
    required this.onTapped,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapped.call();
        Navigator.pop(context);
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title ?? '',
            style:
                Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 17),
          ),
        ),
      ),
    );
  }
}
