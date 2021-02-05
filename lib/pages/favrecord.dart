import 'package:budget_tracking_system/services/record.dart';
import 'package:budget_tracking_system/pages/editrecord.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class RecordGroupSeparator extends StatelessWidget {
  final DateTime date;
  RecordGroupSeparator({this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(41, 41, 41, 1)),
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "${this.date.day}.${this.date.month}.${this.date.year}",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavouriteRecord extends StatefulWidget {
  final String uid;

  FavouriteRecord({this.uid});

  @override
  _FavouriteRecordState createState() => _FavouriteRecordState(uid: uid);
}

class _FavouriteRecordState extends State<FavouriteRecord> {
  final String uid;
  List recordView = [];

  _FavouriteRecordState({this.uid});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    List<Record> allRecord = List.from(Record.list);
    allRecord.forEach((Record record) {
      if (record.isFav) {
        recordView.add(record);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(57, 57, 57, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(18, 18, 18, 1),
          title: Text('Favourite Records'),
        ),
        body: recordView.length != 0
            ? SafeArea(
                child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(57, 57, 57, 1)),
                  child: GroupedListView<dynamic, DateTime>(
                    elements: recordView,
                    groupBy: (record) {
                      return DateTime(record.dateTime.year,
                          record.dateTime.month, record.dateTime.day);
                    },
                    groupSeparatorBuilder: (DateTime dateTime) =>
                        RecordGroupSeparator(date: dateTime),
                    order: GroupedListOrder.DESC,
                    separator: Divider(
                      color: Colors.grey,
                      indent: 15.0,
                      endIndent: 15.0,
                    ),
                    itemComparator: (item1, item2) =>
                        item1.dateTime.hour.compareTo(item2.dateTime.hour),
                    padding: EdgeInsets.only(bottom: 100),
                    indexedItemBuilder: (context, dynamic record, index) {
                      Container(
                        height: 70,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditRecord(
                                      uid: uid,
                                      index: recordView.length - 1 - index,
                                      type: recordView[
                                              recordView.length - 1 - index]
                                          .type,
                                      title: recordView[
                                              recordView.length - 1 - index]
                                          .title,
                                      dateTime: recordView[
                                              recordView.length - 1 - index]
                                          .dateTime,
                                      category: recordView[
                                              recordView.length - 1 - index]
                                          .category,
                                      account: recordView[
                                              recordView.length - 1 - index]
                                          .account,
                                      toAccount: recordView[
                                              recordView.length - 1 - index]
                                          .toAccount,
                                      budget: recordView[
                                              recordView.length - 1 - index]
                                          .budget,
                                      amount: recordView[
                                              recordView.length - 1 - index]
                                          .amount,
                                      note: recordView[
                                              recordView.length - 1 - index]
                                          .note,
                                      isFav: recordView[
                                              recordView.length - 1 - index]
                                          .isFav,
                                    ),
                                        fullscreenDialog: true),
                                  ).then((value) => setState(() {
                                        List<Record> allRecord =
                                            List.from(Record.list);
                                        recordView = [];
                                        allRecord.forEach((Record record) {
                                          if (record.isFav) {
                                            recordView.add(record);
                                          }
                                        });
                                      }));
                                },
                                leading: record.type != 'Transfer'
                                    ? Text(
                                        record.category.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      )
                                    : Text(
                                        'Transfer',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditRecord(
                                      uid: uid,
                                      index: recordView.length - 1 - index,
                                      type: recordView[
                                              recordView.length - 1 - index]
                                          .type,
                                      title: recordView[
                                              recordView.length - 1 - index]
                                          .title,
                                      dateTime: recordView[
                                              recordView.length - 1 - index]
                                          .dateTime,
                                      category: recordView[
                                              recordView.length - 1 - index]
                                          .category,
                                      account: recordView[
                                              recordView.length - 1 - index]
                                          .account,
                                      toAccount: recordView[
                                              recordView.length - 1 - index]
                                          .toAccount,
                                      budget: recordView[
                                              recordView.length - 1 - index]
                                          .budget,
                                      amount: recordView[
                                              recordView.length - 1 - index]
                                          .amount,
                                      note: recordView[
                                              recordView.length - 1 - index]
                                          .note,
                                      isFav: recordView[
                                              recordView.length - 1 - index]
                                          .isFav,
                                    ),
                                        fullscreenDialog: true),
                                  ).then((value) => setState(() {
                                        List<Record> allRecord =
                                            List.from(Record.list);
                                        recordView = [];
                                        allRecord.forEach((Record record) {
                                          if (record.isFav) {
                                            recordView.add(record);
                                          }
                                        });
                                      }));
                                },
                                title: Text(
                                  record.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: record.type != 'Transfer'
                                    ? Text(
                                        record.account.name,
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    : Text(
                                        '${record.account.name} - ${record.toAccount.name}',
                                        style: TextStyle(color: Colors.grey),
                                      ),

                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditRecord(
                                      uid: uid,
                                      index: recordView.length - 1 - index,
                                      type: recordView[
                                              recordView.length - 1 - index]
                                          .type,
                                      title: recordView[
                                              recordView.length - 1 - index]
                                          .title,
                                      dateTime: recordView[
                                              recordView.length - 1 - index]
                                          .dateTime,
                                      category: recordView[
                                              recordView.length - 1 - index]
                                          .category,
                                      account: recordView[
                                              recordView.length - 1 - index]
                                          .account,
                                      toAccount: recordView[
                                              recordView.length - 1 - index]
                                          .toAccount,
                                      budget: recordView[
                                              recordView.length - 1 - index]
                                          .budget,
                                      amount: recordView[
                                              recordView.length - 1 - index]
                                          .amount,
                                      note: recordView[
                                              recordView.length - 1 - index]
                                          .note,
                                      isFav: recordView[
                                              recordView.length - 1 - index]
                                          .isFav,
                                    ),
                                fullscreenDialog: true),
                          ).then((value) => setState(() {
                                List<Record> allRecord = List.from(Record.list);
                                recordView = [];
                                allRecord.forEach((Record record) {
                                  if (record.isFav) {
                                    recordView.add(record);
                                  }
                                });
                              }));
                        },
                        trailing: record.type == 'Expenses'
                            ? Text(
                                "- RM " + record.amount.toStringAsFixed(2),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13.0),
                              )
                            : Text(
                                "+ RM " + record.amount.toStringAsFixed(2),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13.0),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditRecord(
                                              uid: uid,
                                              index: Record.list.length -
                                                  1 -
                                                  index,
                                              type: Record
                                                  .list[Record.list.length -
                                                      1 -
                                                      index]
                                                  .type,
                                              title: Record
                                                  .list[Record.list.length -
                                                      1 -
                                                      index]
                                                  .title,
                                              dateTime: Record
                                                  .list[Record.list.length -
                                                      1 -
                                                      index]
                                                  .dateTime,
                                              category: Record
                                                  .list[Record.list.length -
                                                      1 -
                                                      index]
                                                  .category,
                                              account: Record
                                                  .list[Record.list.length -
                                                      1 -
                                                      index]
                                                  .account,
                                              toAccount: Record
                                                  .list[Record.list.length -
                                                      1 -
                                                      index]
                                                  .toAccount,
                                              amount: Record
                                                  .list[Record.list.length -
                                                      1 -
                                                      index]
                                                  .amount,
                                              note: Record
                                                  .list[Record.list.length -
                                                      1 -
                                                      index]
                                                  .note,
                                              isFav: Record
                                                  .list[Record.list.length -
                                                      1 -
                                                      index]
                                                  .isFav,
                                            ),
                                        fullscreenDialog: true),
                                  ).then((value) => setState(() {
                                        List<Record> allRecord =
                                            List.from(Record.list);
                                        recordView = [];
                                        allRecord.forEach((Record record) {
                                          if (record.isFav) {
                                            recordView.add(record);
                                          }
                                        });
                                      }));
                                },
                                trailing: record.type == 'Expenses'
                                    ? Text(
                                        "- RM " +
                                            record.amount.toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.0),
                                      )
                                    : Text(
                                        "+ RM " +
                                            record.amount.toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.0),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            : Center(
                child: Text(
                  "No favourite records added.",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ));
  }
}
