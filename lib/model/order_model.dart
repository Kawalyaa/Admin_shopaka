class OrderModel {
  static const ID = 'id';
  static const USER_NAME = 'userName';
  static const PHONE = 'phone';
  static const ORDER_LIST = 'ordersList';
  static const ORDER_NUMBER = 'orderNumber';
  static const TOTAL_PRICE = 'totalPrice';
  static const PICKUP_STATION = 'pickupStation';
  static const ORDER_STATUS = 'orderStatus';
  static const DELIVERY_DATE = 'deliveryDate';
  static const TIME = 'time';
  static const ADDRESS = 'address';
  static const PAYMENT_METHOD = 'paymentMethod';
  static const PAYMENT_STATUS = 'paymentStatus';
  static const DELIVERY_METHOD = 'deliveryMethod';
  static const EMAIL = 'email';

  final List ordersList;
  final List pickupStation;
  final String orderStatus;
  final String orderNumber;
  final double totalPrice;
  final  deliveryDate;
  final time;
  final String userName;
  final String id;
  final String paymentMethod;
  final String paymentStatus;
  final List address;
  final String deliveryMethod;
  final String phone;
  final String email;

  OrderModel(
      {this.totalPrice,
      this.orderNumber,
      this.ordersList,
      this.orderStatus,
      this.pickupStation,
      this.deliveryDate,
      this.time,
      this.id,
      this.userName,
      this.paymentMethod,
      this.paymentStatus,
      this.address,
      this.deliveryMethod,
      this.phone,
      this.email});

  factory OrderModel.fromSnapShot(Map data) => OrderModel(
        totalPrice: data[TOTAL_PRICE],
        orderNumber: data[ORDER_NUMBER] ?? '',
        ordersList: data[ORDER_LIST] ?? [],
        orderStatus: data[ORDER_STATUS] ?? '',
        pickupStation: data[PICKUP_STATION] ?? [],
        deliveryDate: data[DELIVERY_DATE] ?? '',
        time: data[TIME] ?? '',
        paymentMethod: data[PAYMENT_METHOD] ?? '',
        paymentStatus: data[PAYMENT_STATUS] ?? '',
        address: data[ADDRESS] ?? [],
        id: data[ID] ?? '',
        deliveryMethod: data[DELIVERY_METHOD] ?? '',
        userName: data[USER_NAME] ?? '',
        phone: data[PHONE] ?? '',
        email: data[EMAIL]??'',
      );
}
