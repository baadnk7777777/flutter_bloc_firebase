import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/models/room.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/models/message.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/models/services_request.dart';
import 'package:flutter_bloc_firebase_2/network/firebase_network.dart';
import 'package:flutter_bloc_firebase_2/network/impl/firebase_network_error.dart';
import 'package:flutter_bloc_firebase_2/utils/custom_logger.dart';
import 'package:uuid/uuid.dart';

class FirebaseNetworkImpl implements FirebaseNetwork {
  final CollectionReference _messageCollection =
      FirebaseFirestore.instance.collection('messages');
  final CollectionReference _servicsReqestCollection =
      FirebaseFirestore.instance.collection('Services_request');
  final CollectionReference _chatRoomsCollection =
      FirebaseFirestore.instance.collection('ChatRooms');
  final Uuid uuid = const Uuid();

  @override
  Future<List<Message>> getAllMessages(int chatId) async {
    try {
      QuerySnapshot querySnapshot = await _messageCollection.get();
      List<Message> messages = querySnapshot.docs
          .map((e) => Message.fromDocumentSnapshot(e))
          .toList();
      List<Message> messageQuery =
          messages.where((message) => message.chatId == chatId).toList();
      AppLogger.log('Got messages ${messageQuery.length}',
          'FIREBASE_NETWORK_GET_ALL_MESSAGES', '✅');
      return messageQuery;
    } catch (e) {
      AppLogger.logE(
          'Filed to Get messages $e', 'FIREBASE_NETWORK_GET_ALL_MESSAGES', '❌');
      return [];
    }
  }

  @override
  Future<QuerySnapshot> getDocument(String collectionPath) async {
    try {
      return await firebaseFirestore.collection(collectionPath).get();
    } catch (e) {
      print('Error fetching document: $e');
      throw FirebaseNetworkException('Error fetching document: $e');
    }
  }

  @override
  Future<void> addRequest(String issue, String uId, int rating,
      String serviceType, String status) async {
    try {
      await _servicsReqestCollection.add({
        'issue': issue,
        'rating': rating,
        'service_type': serviceType,
        'status': status,
        'timestamp': FieldValue.serverTimestamp(),
        'uId': uId,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  // TODO: implement firebaseFirestore
  FirebaseFirestore get firebaseFirestore => throw UnimplementedError();

  @override
  Future<List<ServicesRequest>> getAllServicesRequest() async {
    try {
      QuerySnapshot querySnapshot = await _servicsReqestCollection.get();
      List<ServicesRequest> request = querySnapshot.docs
          .map((e) => ServicesRequest.fromDocumentSnapshot(e))
          .toList();

      return request;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> sentMessage(String message, String uId, int chatId) async {
    try {
      await _messageCollection.add({
        'uId': uId,
        'chatId': chatId,
        'text': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
      AppLogger.log('Sent new message successfully',
          'FIREBASE_NETWORK_SENT_MESSAGE', '✅');
    } catch (e) {
      AppLogger.logE(
          'Filed to Get messages $e', 'FIREBASE_NETWORK_SENT_MESSAGE', '❌');
    }
  }

  @override
  Future<List<Room>> getRoomsById(String uId) async {
    try {
      final List<Message> lastMessageEachRoom = <Message>[];
      QuerySnapshot querySnapshot = await _chatRoomsCollection.get();
      QuerySnapshot querySnapshotMessage = await _messageCollection.get();
      List<Message> messages = querySnapshotMessage.docs
          .map((e) => Message.fromDocumentSnapshot(e))
          .toList();
      messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      Message? tempMessage;
      for (var i = 0; i < messages.length; i++) {
        if (i == 0) {
          tempMessage = messages[i];
          lastMessageEachRoom.add(tempMessage);
        }
        if (tempMessage!.chatId != messages[i].chatId) {
          lastMessageEachRoom.add(messages[i]);
        }
        tempMessage = messages[i];
      }

      List<Room> rooms =
          querySnapshot.docs.map((e) => Room.fromDocumentSnapshot(e)).toList();

      List<Room> roomsQuery = rooms.where((room) {
        if (room.members.contains(uId)) {
          // AppLogger.logD(room.chatId.toString(), "roomsQuery");
        }
        return room.members.contains(uId);
      }).toList();

      for (var i = 0; i < roomsQuery.length; i++) {
        for (var j = 0; j < lastMessageEachRoom.length; j++) {
          if (roomsQuery[i].chatId == lastMessageEachRoom[j].chatId) {
            roomsQuery[i].message = lastMessageEachRoom[j];
          }
        }
      }

      AppLogger.log('Get Rooms got rooms ${roomsQuery.length} successfully',
          'FIREBASE_NETWORK_GET_ROOMS', '✅');
      return roomsQuery;
    } catch (e) {
      AppLogger.logE(
          'Filed to Get Rooms $e', 'FIREBASE_NETWORK_GET_ROOMS_BY_ID', '❌');
      return [];
    }
  }
}
