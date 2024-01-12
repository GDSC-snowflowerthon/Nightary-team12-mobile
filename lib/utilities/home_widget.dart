class WidgetData {
  final int data;
  WidgetData(this.data);

  WidgetData.fromJson(Map<String, dynamic> json) : data = json['data'];
  Map<String, dynamic> toJson() => {'data': data};
}
