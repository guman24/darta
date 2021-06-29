import 'package:flutter/material.dart';

class NotificationTestModel {
  final String title;
  final String time;
  final bool isRead;
  NotificationTestModel({
    @required this.title,
    @required this.time,
    @required this.isRead,
  });
}

List<NotificationTestModel> testNotifications = [
  NotificationTestModel(
      title:
          "तपाईको खाता प्रमाणित भयो। नयाँ फारम उपलब्ध छ। कृपया यसलाई जाँच गर्नुहोस्।",
      time: "15 mins",
      isRead: true),
  NotificationTestModel(
      title:
          "तपाईको फारम बुझाइएको छैन किनकि केहि गल्तीका कार सबै कमप्रयोग सिफा गर्न वश्यक",
      time: "2 hours",
      isRead: false),
  NotificationTestModel(
      title: "नयाँ फारम उपलब्ध छ। कृपया यसलाई जाँच गर्नुहोस्।",
      time: "2 days",
      isRead: true),
  NotificationTestModel(
      title:
          "तपाईको फारम बुझाइएको छैन किनकि केहि जब क गल्तीका र सबै कमप्रयोग सिफा गर्न वश्यक",
      time: "4 days",
      isRead: true),
  NotificationTestModel(
      title:
          "तपाईको फारम बुझाइएको छैन किनकि केहि गल्तीका कार सबै कमप्रयोग सिफा गर्न वश्यक",
      time: '1 weeks',
      isRead: false),
  NotificationTestModel(
      title: "नयाँ फारम उपलब्ध छ। कृपया यसलाई जाँच गर्नुहोस्।",
      time: "2 weeks",
      isRead: true),
  NotificationTestModel(
      title:
          "तपाईको खाता प्रमाणित भयो। नयाँ फारम उपलब्ध छ। कृपया यसलाई जाँच गर्नुहोस्।",
      time: "15 mins",
      isRead: true),
  NotificationTestModel(
      title:
          "तपाईको फारम बुझाइएको छैन किनकि केहि गल्तीका कार सबै कमप्रयोग सिफा गर्न वश्यक",
      time: "2 hours",
      isRead: false),
  NotificationTestModel(
      title: "नयाँ फारम उपलब्ध छ। कृपया यसलाई जाँच गर्नुहोस्।",
      time: "2 days",
      isRead: true),
  NotificationTestModel(
      title:
          "तपाईको फारम बुझाइएको छैन किनकि केहि जब क गल्तीका र सबै कमप्रयोग सिफा गर्न वश्यक",
      time: "4 days",
      isRead: true),
  NotificationTestModel(
      title:
          "तपाईको फारम बुझाइएको छैन किनकि केहि गल्तीका कार सबै कमप्रयोग सिफा गर्न वश्यक",
      time: '1 weeks',
      isRead: false),
  NotificationTestModel(
      title: "नयाँ फारम उपलब्ध छ। कृपया यसलाई जाँच गर्नुहोस्।",
      time: "2 weeks",
      isRead: true),
];
