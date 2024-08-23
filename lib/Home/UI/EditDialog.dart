import 'package:error_products/Home/Model/ErrorProductItem.dart';
import 'package:error_products/Home/UI/ColorMenu.dart';
import 'package:error_products/Repository/Repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/app_bloc.dart';
import '../Model/ColorItem.dart';

class EditDialog extends StatefulWidget {
  EditDialog({super.key, required this.item});

  ErrorProductItem item;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  TextEditingController nameTEC = TextEditingController();
  TextEditingController skuTEC = TextEditingController();
  TextEditingController colorTEC = TextEditingController();

  ColorItem? colorItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameTEC.text = widget.item.name ?? '';
    skuTEC.text = widget.item.sku ?? '';
    colorTEC.text = widget.item.colorName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Product Name'),
                TextField(
                  controller: nameTEC,
                  maxLength: 50,
                  onChanged: (value) {
                    nameTEC.text = value;
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('Sku'),
                TextField(
                  controller: skuTEC,
                  maxLength: 20,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    skuTEC.text = value;
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('Color'),
                TextField(
                  controller: colorTEC,
                  readOnly: true,
                  onTap: () async {
                    final List<ColorItem> listColor = await Repository().fetchColor();
                    if (context.mounted) {
                      final res = await showDialog(
                        context: context,
                        builder: (context) => ColorMenu(
                          listColor: listColor,
                        ),
                      );
                      if (res is ColorItem) {
                        colorTEC.text = res.name ?? '';
                        colorItem = res;
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          color: Colors.grey,
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          disabledColor: Colors.grey,
                          color: Colors.blue,
                          onPressed: nameTEC.text == '' || skuTEC.text == '' ? null : () {
                            context.read<AppBloc>().add(UpdateItem(
                                item: widget.item.copyWith(
                                    name: nameTEC.text,
                                    sku: skuTEC.text,
                                    color: colorTEC.text == widget.item.colorName ? widget.item.color : colorItem?.id,
                                    colorName: colorTEC.text == widget.item.colorName ? widget.item.colorName : colorItem?.name
                                )));
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle( fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
