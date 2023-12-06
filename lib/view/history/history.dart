import 'package:flutter/material.dart';
import 'package:tubes_ui/view/history/review.dart';
import 'package:tubes_ui/entity/cart.dart';
import 'package:tubes_ui/client/cartClient.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isReviewed = false;
  List<Cart> cartData = [];

  void showCart() async {
    List<Cart> data = await CartClient.fetchAll();
    setState(() {
      cartData = data;
    });
  }

  void initState() {
    showCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Center(
                    child: Text(
                      'HISTORY PAYMENT',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 40.0),
                ],
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                  itemCount: cartData.length,
                  itemBuilder: (context, index) {
                    Cart cart = cartData[index];
                    return buildPaymentCard(
                        cart.carName,
                        cart.return_date.toString(),
                        'Rp ${cart.price}',
                        cart.id.toString(),
                        cart);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentCard(
      String? title, String? date, String price, String id, Cart cart) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(30, 25),
                    backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewPage(selectedCart: cart)),
                    );
                  },
                  child: const Text(
                    'Done',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date!,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8.0),
                Text('ID: $id'),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 20),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Color.fromRGBO(127, 90, 240, 1)),
                      ),
                      onPressed: () {
                        setState(() {
                          print('test');
                        });
                      },
                      child: cart.isReviewed
                          ? Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Color.fromRGBO(127, 90, 240, 1)),
                                const SizedBox(width: 3),
                                Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(0, 33, 206, 1),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        iconSize: 12,
                                        onPressed: () {
                                          // Tambahkan logika saat tombol edit ditekan
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                    )),
                                const SizedBox(width: 3),
                                Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(216, 0, 39, 1),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        iconSize: 12,
                                        onPressed: () {
                                          // Tambahkan logika saat tombol hapus ditekan
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    )),
                              ],
                            )
                          : const Text(
                              'Review',
                              style: TextStyle(
                                  color: Color.fromRGBO(127, 90, 240, 1)),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
