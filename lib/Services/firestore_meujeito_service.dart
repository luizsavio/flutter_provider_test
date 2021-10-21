import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:flutter_provider_test/Model/Cliente.dart';

class FirestoreMeuJeitoService {
  static final CollectionReference _clientesCollectionReference =
  FirebaseFirestore.instance.collection('teste');

  static final StreamController<List<Cliente>> _postsController =
  StreamController<List<Cliente>>.broadcast();

  // #6: Create a list that will keep the paged results
  static List<List<Cliente>> _allPagedResults = [];

  static const int PostsLimit = 20;

  static late DocumentSnapshot? _lastDocument = null;
  static bool _hasMorePosts = true;

  late List<Cliente> _clientes = <Cliente>[];

  List<Cliente> get clientes => _clientes;

  static Stream listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    _requestPosts();
    return _postsController.stream;
  }

  // #1: Move the request posts into it's own function
  static void _requestPosts() {
    // #2: split the query from the actual subscription
    var pageClientesQuery = _clientesCollectionReference
        .orderBy('codcli')
    // #3: Limit the amount of results
        .limit(PostsLimit);
    //print('ver ultimo antes ${_lastDocument ?? 'null'}');
    // #5: If we have a document start the query after it
    if (_lastDocument != null) {
      pageClientesQuery = pageClientesQuery.startAfterDocument(_lastDocument!);
      print('faz o proximo');
    }

    if (!_hasMorePosts) return;

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allPagedResults.length;

    pageClientesQuery.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.docs.isNotEmpty) {
        var clientes = postsSnapshot.docs
            .map((snapshot) => Cliente.fromMap(snapshot.data()! as Map<String, dynamic>, snapshot.id))
            .where((mappedItem) => mappedItem.nomcli != null)
            .toList();

        // #8: Check if the page exists or not
        var pageExists = currentRequestIndex < _allPagedResults.length;

        // #9: If the page exists update the clientes for that page
        if (pageExists) {
          _allPagedResults[currentRequestIndex] = clientes;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allPagedResults.add(clientes);
        }

        // #11: Concatenate the full list to be shown
        var allPosts = _allPagedResults.fold<List<Cliente>>(<Cliente>[],
                (initialValue, pageItems) => initialValue..addAll(pageItems));

        // #12: Broadcase all clientes
        _postsController.add(allPosts);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allPagedResults.length - 1) {
          _lastDocument = postsSnapshot.docs.last;
          //print('ver ultimo ${_lastDocument!.id}');
        }

        // #14: Determine if there's more clientes to request
        _hasMorePosts = clientes.length == PostsLimit;
      }
    });
  }

  void listenToPosts() {


    listenToPostsRealTime().listen((postsData) {
      List<Cliente> updatedPosts = postsData;
      if (updatedPosts != null && updatedPosts.length > 0) {
        _clientes = updatedPosts;
      }

    });
  }

  void requestMoreData() => _requestPosts();
}
