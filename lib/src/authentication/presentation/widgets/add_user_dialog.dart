import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_flutter/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({
    super.key,
    required this.nameController,
  });
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    const avatar =
        "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1160.jpg";

    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'User name',
                ),
                controller: nameController,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                child: const Text("Create User"),
                onPressed: () async {
                  context.read<AuthenticationCubit>().createUser(
                    createdAt: DateTime.now().toUtc().toString(),
                    name: nameController.text.trim(),
                    avatar: avatar,
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
