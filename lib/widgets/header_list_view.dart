import 'package:flutter/material.dart';

typedef HeaderBuilder = Function(BuildContext context, int position);
typedef ItemBuilder = Function(BuildContext context, int position);

class HeaderListView extends StatefulWidget {
  final List itemList;
  final List headerList;
  final HeaderBuilder headerBuilder;
  final ItemBuilder itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;
  final ScrollController controller;

  HeaderListView(this.itemList,
      {Key key,
      this.headerList,
      this.headerBuilder,
      this.itemBuilder,
      this.separatorBuilder,
      this.controller})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HeaderListViewState();
  }
}

class HeaderListViewState extends State<HeaderListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int position) {
        return buildItemWidget(context, position);
      },
      separatorBuilder: widget.separatorBuilder,
      itemCount: getItemCount(),
      controller: widget.controller,
    );
  }

  getItemCount() {
    return getHeaderCount() +
        (widget.itemList != null ? widget.itemList.length : 0);
  }

  getHeaderCount() {
    return widget.headerList != null ? widget.headerList.length : 0;
  }

  Widget buildItemWidget(BuildContext context, int position) {
    if (position < getHeaderCount()) {
      return headerWidget(context, position);
    } else {
      return itemWidget(context, position - getHeaderCount());
    }
  }

  Widget headerWidget(BuildContext context, int position) {
    if (widget.headerBuilder != null) {
      return widget.headerBuilder(context, position);
    }
    return GestureDetector(
      child: Container(
        height: 0,
        width: 0,
      ),
    );
  }

  Widget itemWidget(BuildContext context, int position) {
    if (widget.itemBuilder != null) {
      return widget.itemBuilder(context, position);
    }
    return GestureDetector(
      child: Container(
        width: 0,
        height: 0,
      ),
    );
  }
}
