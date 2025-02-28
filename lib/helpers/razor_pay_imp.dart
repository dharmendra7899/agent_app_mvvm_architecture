import 'package:agent_app/res/app_urls.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayImp {
  late final Function(PaymentFailureResponse response) onPaymentFailed;
  late final Function(PaymentSuccessResponse response) onPaymentSuccess;

  RazorPayImp();

  final Razorpay _razorpay = Razorpay();

  initialize({
    required Function(PaymentFailureResponse response) onPaymentFailed,
    required Function(PaymentSuccessResponse response) onPaymentSuccess,
  }) {
    this.onPaymentFailed = onPaymentFailed;
    this.onPaymentSuccess = onPaymentSuccess;
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onPaymentFailed);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  startPayment(String orderId, String? userEmail) {
    var options = {
      'key': AppUrls.razorPayKey,
      'order_id': orderId,
      'name': 'String Art',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'email': userEmail},
      'method': {'wallet': '0'},
      'config': {
        'display': {
          'hide': [
            {'method': 'wallet'},
          ],
        },
      },
    };
    _razorpay.open(options);
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {}
}
