import 'package:flutter/material.dart';
import 'package:tubes_ui/view/profile/subscribe/subscribe.dart';
import 'package:tubes_ui/entity/subscription.dart';
import 'package:tubes_ui/client/subscriptionClient.dart';

class PaketPage extends StatefulWidget {
  const PaketPage({Key? key}) : super(key: key);

  @override
  State<PaketPage> createState() => _PaketPageState();
}

class _PaketPageState extends State<PaketPage> {
  Future<void> purchaseSubscription(String subscriptionType) async {
    try {
      // Get the user ID from shared preferences
      int userId = await SubsciptionClient().getUserId();
      double harga = 0.0;
      String deskripsi = '';

      switch (subscriptionType) {
        case 'Bronze':
          harga = 100000.0;
          deskripsi =
              'Layanan pelanggan standardiskon 5% untuk setiap penyewaan.';
          break;
        case 'Silver':
          harga = 200000.0;
          deskripsi =
              'Layanan pelanggan prioritas 24/7diskon 10% untuk setiap penyewaan.';
          break;
        case 'Gold':
          harga = 300000.0;
          deskripsi =
              'Layanan pelanggan VIP 24/7 dengan asisten pribadi\ndiskon 20% untuk setiap penyewaanasuransi lengkap untuk keamanan tambahan.';
          break;
        default:
          harga = 0.0;
          deskripsi = "gak ada anjing";
          break;
      }

      // Create a Subscription object
      Subscription newSubscription = Subscription(
        id_user: userId,
        tipe: subscriptionType,
        harga: harga,
        deskripsi: deskripsi,
      );

      // Call the create method from SubscriptionClient to push data to the API
      await SubsciptionClient.create(newSubscription);

      // Navigate back to the subscription page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SubscribePage()),
      );
    } catch (e) {
      // Handle errors
      print('Error purchasing subscription: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubscribePage(),
                          ),
                        );
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      'SUBSCRIBES',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 40.0),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSubscriptionCard(
                  'Bronze',
                  'Rp 100.000/bulan',
                  'Layanan pelanggan standar\nDiskon 5% untuk setiap penyewaan',
                  Icons.check,
                ),
                const SizedBox(height: 20),
                _buildSubscriptionCard(
                  'Silver',
                  'Rp 200.000/bulan',
                  'Layanan pelanggan prioritas 24/7\nDiskon 10% untuk setiap penyewaan',
                  Icons.check,
                ),
                const SizedBox(height: 20),
                _buildSubscriptionCard(
                  'Gold',
                  'Rp 300.000/bulan',
                  'Layanan pelanggan VIP 24/7 dengan asisten pribadi\nDiskon 20% untuk setiap penyewaan\nAsuransi lengkap untuk keamanan tambahan',
                  Icons.check,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(
      String title, String price, String description, IconData iconData) {
    List<String> descriptionLines = description.split('\n');

    return Card(
      elevation: 4.0,
      child: ClipRect(
        child: Stack(
          children: [
            Container(
              color: _getColorForSubscriptionType(title),
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: descriptionLines
                        .map(
                          (line) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Icon(
                                  iconData,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    line,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          double maxHeight =
                              MediaQuery.of(context).size.height * 0.60;

                          return Container(
                            constraints: BoxConstraints(
                              maxHeight: maxHeight,
                            ),
                            child: buildCombinedBottomSheet(title),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(127, 90, 240, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Mulai'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForSubscriptionType(String subscriptionType) {
    switch (subscriptionType) {
      case 'Bronze':
        return Colors.brown;
      case 'Silver':
        return Colors.grey;
      case 'Gold':
        return Colors.amber;
      default:
        return Colors.transparent;
    }
  }

  Widget buildSpecCard(IconData icon, String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCombinedBottomSheet(String subscriptionType) {
    String subsName = '';
    String subsPrice = '';
    String description = '';

    switch (subscriptionType) {
      case 'Bronze':
        subsName = 'BRONZE';
        subsPrice = '100.000/bulan';
        description =
            '- Layanan pelanggan standar\n- diskon 5% untuk setiap penyewaan.';
        break;
      case 'Silver':
        subsName = 'SILVER';
        subsPrice = '200.000/bulan';
        description =
            '- Layanan pelanggan prioritas 24/7\n- diskon 10% untuk setiap penyewaan.';
        break;
      case 'Gold':
        subsName = 'GOLD';
        subsPrice = '300.000/bulan';
        description =
            '- Layanan pelanggan VIP 24/7 dengan\n  asisten pribadi\n- diskon 20% untuk setiap penyewaan\n- asuransi lengkap untuk keamanan tambahan.';
        break;
      default:
        subsName = 'Tipe paket tidak tersedia';
        subsPrice = 'Harga tidak tersedia';
        description = 'Deskripsi tidak tersedia';
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(127, 90, 240, 1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subsName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          subsPrice,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '4.8',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              // color: Colors.grey,
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Overview',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Icon(Icons.check),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Benefit:'),
                            Text(description),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Payment',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                buildSpecCard(
                  Icons.credit_card,
                  'MasterCard',
                  '**** **** 1234 5678',
                ),
                const SizedBox(height: 10),
                buildSpecCard(
                  Icons.scanner,
                  '',
                  'SCAN QR',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                      ),
                      onPressed: () {
                        // Add functionality for Print PDF
                      },
                      child: const Text('Print PDF'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                      ),
                      onPressed: () async {
                        await purchaseSubscription(subscriptionType);
                      },
                      child: const Text('Beli'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
