import 'package:dantelion/models/order.dart';
import 'package:gsheets/gsheets.dart';

class ClientSheetsApi {
  static final _spreadSheetId = "1uvdLlcodT2gD7_-y_2Ds9fWXyvHL4tWZnuGQM4-Qqy4";
  static final _googleSheets = GSheets(_credentials);
  static Worksheet? _orderSheet;

  static const _credentials = r'''{
    "type": "service_account",
    "project_id": "dantelion-shop",
    "private_key_id": "8232661f7d0cfdbc248c1817b3ddee54157a708a",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCmmQi6QuNSx5Bk\npR/abozWqA9E4g30xhfye49fNd0lhUbWqwYrj4nYAl/izGK32DDntUgNwxsHbsMx\n6dvPQxgoiqoWix+VMKLZWcMvWfU1UKgVv/El5tv3B/yMfk9cH4nRgvBJKRqgAFFh\nE9exXrzIXdsjapp/IohqCzeozZaElH7WycpGgqcyrJYK+tFWOImJ6ECrTcjqHtHI\nYyTVGcalyya0omdcwiGnqlyFXk4TLZ4HWlbUG0csokGCI7LiIfPtMx7ri5Tf4K/2\nnllE+0B78zyM+2OvVUc/WuO9w7xvo5WRcUGvU2StuVDniDJ/2pnkWW+hgqyHxA++\nYm9/xYVNAgMBAAECggEAFupM24Xwy8WcdGOMHpj/MVV7iC+J2OXYjGd3gJKhoRQU\netmaZyp+vOISu1j+qSgJDg4O46m3EY4oNjjjHb6uV4E/RQuM5BIFDF1+7gfzJQq7\nnAZDTsHS9sc380E6fELwS4u1rnKDcYepqe83R3PvBqZ2SohSyPMAjYmOdd8VeZXU\nUhypkYnY6nZOEssr/ea19kVfKnx5LMGrnnyRR08Lp9WEfpT8e/p6ONe2yXIBmAqL\nIPAjsiU5ks79FvDeq2nyeQLaLKrksAaWBag9ETFWN8p/nF9lEe3++/uIX3FdFayv\nVSieu5NI67G5I0x8DyP2p3nBIhq3uQGwgci2BmSwUQKBgQDiNJ/Do3MjnrPytqzM\nc7fU8LU5l3UDhUJpzeLG1hBFn8ck/ZKUENKka7l6QcR9N/B5Bls/gyqxh2aoIm2e\nxILZZzl8G49xc1qYZkrV5uPjjgSkptjUN4qt7od/G2YMVsW1CtOjiV1voj4qpTt4\nOcdF/JqRpglnbt/oSBr+og4FpQKBgQC8ioIvPcsTDblvip/exYtmxbgQJ6pDfem6\nixLpPRCazHmYql4/GVvIK1C5ypmSxohEucsW2oxCjMefK1EamMTkK1/EQFeoQtdI\nVOUB6gAJOHyTTVJM3SFYWrVAgwVzzj3SY0K7GF8afTa2n4PTO42aqY4W2s4k8Ywe\nKYaBbwqAiQKBgEARa5a7uqbCEnGSL8sQk2aqbonLTgcbPT4+ZBaxFpbBtGPTtipd\nwWt0X2ozKnXU3DVLCZkpi3QQx5Cjf6zSN8VfqTZvj+cwJt63SkbfSHhxBvujjhI9\nUPgGcTYdCoBAK2slj9/nziEKMNVfS0K4CqrV6umJv2weSSi/E3Y/a/1JAoGAdaqn\nxt300CZflZpZXgnBj1lUH1jx7P83EIHdQo0mwMVeGgYxnYWw/0LxNZKYt76JqwKd\nGd05bgs4RkEdc9DmCFR9hxh03IEipHS/G6uzbA3ByZiXBXt4ZRDvT5y1mWmcsaHb\nMrLqH7kHnX/+IKVpIZ4yHFdgEjRhsy1NUZhAYKkCgYEAgmeYQnP5FI7FltVpTo+M\nJSn38yVp9y+h23QeqDyt5iDAOQIo4SSS8SYidrta2TFZdkI9AcA2T4sGzNBddH0Q\nTjVL3cJ7qE9wucOln7UJWf77rZKeFSwOERNTiv+syi0DEw73yYVaKwJ+M0rUdjH0\nuVSZLhlTkz1RF5UnzcVZ5o0=\n-----END PRIVATE KEY-----\n",
    "client_email": "googlesheets@dantelion-shop.iam.gserviceaccount.com",
    "client_id": "118020019866045196937",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/googlesheets%40dantelion-shop.iam.gserviceaccount.com"
  }
  ''';

  static Future<void> init() async {
    try {
      final spreadsheet = await _googleSheets.spreadsheet(_spreadSheetId);
      _orderSheet = await _getWorkSheet(spreadsheet, title: 'Orders');
      final firstRow = OrderFields.getFields();
      _orderSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init error: $e');
    }
  }

  static Future<Order?> getById(int id) async {
    if (_orderSheet == null) return null;
    final json = await _orderSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Order.fromJson(json);
  }

  static Future<int> _getRowCount() async {
    if (_orderSheet == null) return 0;
    final lastRow = await _orderSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_orderSheet == null) return;
    _orderSheet!.values.map.appendRows(rowList);
  }

  static Future<List<Order>> getAll() async {
    if (_orderSheet == null) return <Order>[];
    final orders = await _orderSheet!.values.map.allRows();
    return orders == null ? <Order>[] : orders.map(Order.fromJson).toList();
  }

  static Future<bool> update(int id, Map<String, dynamic> order) async {
    if (_orderSheet == null) return false;
    return _orderSheet!.values.map.insertRowByKey(id, order);
  }

  static Future<bool> deleteById(int id) async {
    if (_orderSheet == null) return false;
    final index = await _orderSheet!.values.rowIndexOf(id);
    if (index == -1) return false;
    return _orderSheet!.deleteRow(index);
  }
}
