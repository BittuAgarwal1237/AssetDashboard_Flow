import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 0,

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(16),

        side: BorderSide(
          color: Colors.grey.shade200,
        ),

      ),

      child: Padding(

        padding: const EdgeInsets.all(18),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(

              "Quick Actions",

              style: TextStyle(

                fontWeight: FontWeight.bold,

                fontSize: 18,

              ),

            ),

            const SizedBox(height: 20),

            GridView.count(

              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              crossAxisCount: 3,

              crossAxisSpacing: 12,

              mainAxisSpacing: 12,

              children: const [

                _ActionButton(
                  icon: Icons.add_box_outlined,
                  title: "Add",
                ),

                _ActionButton(
                  icon: Icons.person_add_alt,
                  title: "Assign",
                ),

                _ActionButton(
                  icon: Icons.keyboard_return,
                  title: "Return",
                ),

                _ActionButton(
                  icon: Icons.build,
                  title: "Repair",
                ),

                _ActionButton(
                  icon: Icons.description_outlined,
                  title: "Report",
                ),

                _ActionButton(
                  icon: Icons.people_alt_outlined,
                  title: "Employees",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {

  final IconData icon;

  final String title;

  const _ActionButton({

    required this.icon,

    required this.title,

  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius: BorderRadius.circular(12),

      onTap: () {},

      child: Container(

        decoration: BoxDecoration(

          color: Colors.grey.shade100,

          borderRadius: BorderRadius.circular(12),

        ),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(

              icon,

              color: Colors.blue,

            ),

            const SizedBox(height: 10),

            Text(title),

          ],

        ),

      ),

    );

  }

}