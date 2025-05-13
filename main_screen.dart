import 'package:flutter/material.dart';
import 'medicine_list_screen.dart';
import 'reminder_screen.dart';
import 'symptom_checker_screen.dart';

// Add these placeholder variables at the top of the file
final String userName = 'Your User Name';
final String userImage = 'https://randomuser.me/api/portraits/men/32.jpg';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MedicineListScreen(),
    const ReminderScreen(),
    const SymptomCheckerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close drawer after selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RxInsight'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        width: 280,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile section (dynamic)
              Padding(
                padding: const EdgeInsets.only(
                    top: 32, left: 24, right: 24, bottom: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                          userImage), // Use your user image variable
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors
                                    .black)), // Use your user name variable
                        const SizedBox(height: 4),
                        const Text('Welcome!',
                            style:
                                TextStyle(fontSize: 13, color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Divider(height: 32, thickness: 1, color: Colors.black12),
              ),
              // Only three menu items
              _DrawerMenuItem(
                icon: Icons.medication_outlined,
                label: 'Medicines',
                selected: _selectedIndex == 0,
                onTap: () => _onItemTapped(0),
              ),
              _DrawerMenuItem(
                icon: Icons.alarm_outlined,
                label: 'Reminders',
                selected: _selectedIndex == 1,
                onTap: () => _onItemTapped(1),
              ),
              _DrawerMenuItem(
                icon: Icons.medical_services_outlined,
                label: 'Symptoms',
                selected: _selectedIndex == 2,
                onTap: () => _onItemTapped(2),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}

// Drawer menu item widget
class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: selected ? Colors.grey[200] : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: Colors.black, size: 22),
                const SizedBox(width: 18),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
