import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/home_page_import.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_outlined,
              color: Colors.black,
            )),
        title: BlocBuilder<LoginFormBloc, LoginFormState>(
          builder: (context, state) {
            if (state.status == StateStatus.success) {
              return Center(
                child: Text(
                  state.email,
                  style: const TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              );
            } else {
              return const Text('loading');
            }
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () async {},
          ),
          IconButton(
            icon: const Icon(Icons.login_rounded),
            onPressed: () async {
              context.read<LoginFormBloc>().add(const Logout());
              await locator<UserSession>().clearSession();
              AppLogger.log('SignOut', 'SignOut', '📤');
              Navigator.pushNamedAndRemoveUntil(
                  context, LoadingPage.route, (route) => false);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                  ),
                  hintText: 'Search for a service',
                  hintStyle: const TextStyle(
                    fontFamily: 'poppins',
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(height: 20),
            FlutterCarousel(
              items: [
                'images/banner_1.png',
                'images/banner_2.png',
                'images/banner_3.png',
              ].map((e) {
                return Builder(
                  builder: (context) {
                    return Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: AssetImage(e),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 150.0,
                showIndicator: true,
                slideIndicator: const CircularSlideIndicator(),
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayCurve: Curves.easeInOut,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Services by Category',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'VIEW ALL',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Row(
                        children: [
                          ServiceItem(
                            onPress: () {
                              Navigator.pushNamed(
                                  context, AddRequestPage.route);
                            },
                            title: 'Add Request',
                            icon: Icons.post_add_outlined,
                          ),
                          const SizedBox(width: 20),
                          ServiceItem(
                            onPress: () {
                              Navigator.of(context).pushNamed(
                                '/myRequests',
                              );
                            },
                            title: 'My Requests',
                            icon: Icons.note,
                          ),
                          const SizedBox(width: 20),
                          ServiceItem(
                            onPress: () {},
                            title: 'Solar Service',
                            icon: Icons.solar_power_outlined,
                          ),
                          const SizedBox(width: 20),
                          ServiceItem(
                            onPress: () {},
                            title: 'Solar Service',
                            icon: Icons.solar_power_outlined,
                          ),
                          const SizedBox(width: 20),
                          ServiceItem(
                            onPress: () {},
                            title: 'Solar Service',
                            icon: Icons.solar_power_outlined,
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
