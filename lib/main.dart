import 'package:flutter/material.dart';

void main() {
  runApp(const TaskFlowApp());
}

/// --------------------------------------------
/// Name: Jagmohan Dass
/// Roll No: 2380232
/// App: TaskFlow Dashboard (Responsive)
/// --------------------------------------------

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const AdaptiveHome(),
    );
  }
}

class AdaptiveHome extends StatefulWidget {
  const AdaptiveHome({super.key});

  @override
  State<AdaptiveHome> createState() => _AdaptiveHomeState();
}

class _AdaptiveHomeState extends State<AdaptiveHome> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    DashboardScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 700;

        return Scaffold(
          appBar: AppBar(
            title: const Text("TaskFlow Dashboard"),
          ),
          drawer: isWide
              ? null
              : Drawer(
                  child: SideMenu(
                    selectedIndex: selectedIndex,
                    onItemSelected: (index) {
                      setState(() => selectedIndex = index);
                      Navigator.pop(context);
                    },
                  ),
                ),
          body: Row(
            children: [
              if (isWide)
                SizedBox(
                  width: 250,
                  child: SideMenu(
                    selectedIndex: selectedIndex,
                    onItemSelected: (index) {
                      setState(() => selectedIndex = index);
                    },
                  ),
                ),
              Expanded(child: pages[selectedIndex]),
            ],
          ),
        );
      },
    );
  }
}

/// ----------------------------
/// SIDE MENU
/// ----------------------------
class SideMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const SideMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "Navigation",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          buildTile(Icons.dashboard, "Dashboard", 0),
          buildTile(Icons.message, "Messages", 1),
          buildTile(Icons.person, "Profile", 2),
        ],
      ),
    );
  }

  Widget buildTile(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: selectedIndex == index,
      selectedTileColor: Colors.indigo.shade100,
      onTap: () => onItemSelected(index),
    );
  }
}

/// ----------------------------
/// DASHBOARD SCREEN
/// ----------------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header("Welcome Back 👋"),
        Expanded(
          child: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 700 ? 3 : 2,
            padding: const EdgeInsets.all(16),
            children: const [
              StatCard(title: "Tasks", value: "24"),
              StatCard(title: "Completed", value: "18"),
              StatCard(title: "Pending", value: "6"),
              StatCard(title: "Messages", value: "12"),
            ],
          ),
        ),
      ],
    );
  }
}

/// ----------------------------
/// MESSAGES SCREEN
/// ----------------------------
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header("Messages"),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text("${index + 1}"),
                  ),
                  title: Text("User ${index + 1}"),
                  subtitle: const Text("Hello! This is a sample message."),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// ----------------------------
/// PROFILE SCREEN
/// ----------------------------
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header("Profile"),
        const SizedBox(height: 20),
        const CircleAvatar(
          radius: 50,
          child: Icon(Icons.person, size: 50),
        ),
        const SizedBox(height: 10),
        const Text(
          "Jagmohan Dass",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text("Software Engineering Student"),
      ],
    );
  }
}

/// ----------------------------
/// HEADER WIDGET
/// ----------------------------
Widget header(String title) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(30),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo, Colors.blue],
      ),
    ),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

/// ----------------------------
/// STAT CARD
/// ----------------------------
class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}
