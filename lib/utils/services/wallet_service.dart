// ignore_for_file: public_member_api_docs

import 'dart:convert';

import '../../config/api.dart';
import '../../shared/models/wallet_model.dart';
import '../../shared/models/wallet_service_model.dart';
import 'http_client.dart';

class WalletService implements WalletServiceModel {
  final IHttpClient client;
  final baseUrl = baseUrls['apiBase'];

  WalletService(this.client);

  @override
  Future<WalletModel> addWallet(data) {
    // TODO: implement addWallet
    throw UnimplementedError();
  }

  @override
  Future<List<WalletModel>> getWallets() async {
    final response = await client.get('$baseUrl/wallet/find-all');
    final walletsData = <WalletModel>[];
    for (var wallet in response) {
      wallet['createdAt'] = wallet['created_at'];
      wallet['updatedAt'] = wallet['updated_at'];
      walletsData.add(WalletModel.fromJson(jsonEncode(wallet)));
    }

    return walletsData;
  }
}
