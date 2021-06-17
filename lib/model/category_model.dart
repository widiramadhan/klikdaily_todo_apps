import 'package:flutter/cupertino.dart';

class CategoryModel {
  int categoryId;
  String categoryName;
  IconData icon;
  Color colors;
  int total;

  CategoryModel(
      this.categoryId, this.categoryName, this.icon, this.colors, this.total);

  CategoryModel.fromMap(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'] ?? "";
    total = json['total'] ?? "";
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['total'] = this.total;
    return data;
  }
}