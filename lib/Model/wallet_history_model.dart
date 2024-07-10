class WalletHistory {
  final int studentId;
  final double wallet;
  final String date;
  final String state;

  WalletHistory({
    required this.studentId,
    required this.wallet,
    required this.date,
    required this.state,
  });

  factory WalletHistory.fromJson(Map<String, dynamic> json) {
    return WalletHistory(
      studentId: json['student_id'],
      wallet: json['wallet'].toDouble(),
      date: json['date'],
      state: json['state'],
    );
  }
}

class WalletHistoryList {
  final double totalWallet;
  final List<WalletHistory> walletHistoryList;

  WalletHistoryList({
    required this.totalWallet,
    required this.walletHistoryList,
  });

  factory WalletHistoryList.fromJson(Map<String, dynamic> json) {
    var list = json['walletHestory'] as List;
    List<WalletHistory> walletHistoryList =
        list.map((e) => WalletHistory.fromJson(e)).toList();
    return WalletHistoryList(
      totalWallet:
          json['totalWallet'].toDouble(), // Assign directly without parsing
      walletHistoryList: walletHistoryList,
    );
  }
}
