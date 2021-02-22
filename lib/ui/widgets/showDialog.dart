import 'package:flutter/material.dart';

class StatefulDialog extends StatefulWidget {
  final String title;
  final String message;
  final img;
  final value;
  final List<DropdownMenuItem> dropdownList;
  final Function callback;
  StatefulDialog(
      {@required this.title,
      this.message,
      this.img,
      this.callback,
      this.dropdownList,
      this.value});
  @override
  _StatefulDialogState createState() => _StatefulDialogState();
}

class _StatefulDialogState extends State<StatefulDialog> {
  var selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.dropdownList != null && widget.dropdownList.length > 0) {
      print(widget.dropdownList.first.value);
      setState(() {
        selectedValue = widget.dropdownList.first.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle wh = TextStyle(color: Colors.white);
    var styles = Theme.of(context);
    return AlertDialog(
      backgroundColor: Colors.green,
      title: Text(
        widget.title,
        style: wh,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.img != null)
            Container(
                margin: EdgeInsets.only(bottom: 10.0),
                width: 400,
                child: FittedBox(
                    fit: BoxFit.fitWidth, child: Image.memory(widget.img))),
          // ConstrainedBox(
          //   constraints: BoxConstraints(
          //     maxHeight: 200.0,
          //     maxWidth: double.infinity,
          //   ),
          //   child: Container(
          //       margin: EdgeInsets.only(bottom: 10.0),
          //       width: double.infinity,
          //       child: FittedBox(
          //           fit: BoxFit.fitWidth, child: Image.memory(widget.img))),
          // ),
          if (widget.message != null)
            Text(
              widget.message,
              style: wh,
            ),
          if (widget.dropdownList != null && widget.dropdownList.length > 0)
            DropdownButton(
              isExpanded: true,
              isDense: true,
              items: widget.dropdownList,
              value: selectedValue,
              onChanged: (val) {
                setState(() {
                  selectedValue = val;
                });
              },
            ),
        ],
      ),
      actions: <Widget>[
        if (widget.callback != null)
          FlatButton(
            child: Text(
              "OK",
              style: wh,
            ),
            onPressed: () {
              if (widget.value != null) widget.callback(widget.value);
              if (widget.dropdownList != null && widget.dropdownList.length > 0)
                widget.callback(selectedValue);
              else
                widget.callback(null);
              Navigator.of(context).pop();
            },
          ),
        FlatButton(
          child: Text(
            (widget.callback != null) ? "Cancel" : "OK",
            style: wh,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
